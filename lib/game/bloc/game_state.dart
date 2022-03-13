part of 'game_bloc.dart';

/// Base State
abstract class GameState extends Equatable {
  /// Simple Constructor
  const GameState({
    this.hardMode = false,
    this.initialStage = 3,
    this.numberOfStages = 3,
    this.currentStage = 3,
    required this.gameWords,
    this.complete = false,
    this.totalSteps = 0,
  });

  /// If the player is in easy mode, aka shows the word to be found;
  ///
  /// Defaults to false
  ///
  final bool hardMode;

  /// In what stage does the player starts
  ///
  /// Defaults to 3
  ///
  final int initialStage;

  /// Number of stages that exist.
  ///
  /// Defaults to 3
  ///
  /// The count stages with the [initialStage] its how is determined the sizes
  /// of the puzzles.
  final int numberOfStages;

  /// What stage is the player
  ///
  /// Defaults to [currentStage] == [initialStage]
  ///
  final int currentStage;

  /// What are the words the player needs to find to solve the puzzle
  final Map<int, String> gameWords;

  /// Determines if player completed the final level
  final bool complete;

  /// Total number of steps taken
  final int totalSteps;

  /// Helper getter to make code more readable and obvious
  /// if hard mode is activated
  bool get isEasyModeActivated => !hardMode;

  /// Copy the current stage to a new object
  StageGameState copyWith({
    required int current,
    String? word,
    bool? isComplete,
    bool? isHard,
    int? totalSteps,
  }) {
    return StageGameState(
      current,
      word ?? _getStageWord(current),
      isCompleted: isComplete ?? complete,
      words: gameWords,
      hardMode: isHard ?? hardMode,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }

  /// Copy the current finished stage
  StageCompleteState copyStageCompleteState(
    int current,
    int totalSteps,
  ) {
    return StageCompleteState(
      gameWords,
      current,
      totalSteps,
    );
  }

  StageGameState copySteps({
    int? steps,
  }) {
    return StageGameState(
      currentStage,
      _getStageWord(currentStage),
      words: gameWords,
      totalSteps: steps ?? totalSteps,
    );
  }

  /// Get the current word for the puzzle
  String _getStageWord(int current) => gameWords[current] ?? '';

  /// Returns the word that is the goal for the current puzzle
  String? getCurrentWord() {
    //assert(gameWords[currentStage] != null, 'Should always exist a word');
    return gameWords[currentStage];
  }

  /// Determines if the user has reach the final level
  bool isGameFinished() => currentStage + 1 >= numberOfStages + initialStage;

  @override
  List<Object?> get props => [
        hardMode,
        initialStage,
        numberOfStages,
        currentStage,
        gameWords,
        complete,
      ];
}

/// Initial State of the game
class GameInitial extends GameState {
  /// Initial state of the game
  GameInitial()
      : super(
          gameWords: randomizeStageWords(), // Grabs the
        );

  /// Randomize what will be the words that the player needs to find
  static Map<int, String> randomizeStageWords() {
    return validWords.entries.fold(
      <int, String>{},
      (previousValue, words) {
        previousValue[words.key] =
            words.value[Random().nextInt(words.value.length)];
        return previousValue;
      },
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}

/// When the stage is complete and next to next stage
class StageCompleteState extends GameState {
  ///
  const StageCompleteState(
    Map<int, String> words,
    int current,
    int totalSteps,
  ) : super(
          gameWords: words,
          currentStage: current,
          totalSteps: totalSteps,
        );
}

/// Current Stage Game State.
class StageGameState extends GameState {
  ///
  const StageGameState(
    int currentStage,
    this.word, {
    bool isCompleted = false,
    bool hardMode = false,
    required Map<int, String> words,
    int totalSteps = 0,
  }) : super(
          currentStage: currentStage,
          complete: isCompleted,
          gameWords: words,
          hardMode: hardMode,
          totalSteps: totalSteps,
        );

  /// Word that solves the current puzzle
  final String word;

  @override
  List<Object?> get props => [
        ...super.props,
        word,
      ];
}
