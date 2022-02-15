part of 'game_bloc.dart';

/// Base State
abstract class GameState extends Equatable {
  /// Simple Constructor
  const GameState({
    this.easyMode = true,
    this.initialStage = 3,
    this.numberOfStages = 3,
    this.currentStage = 3,
    required this.gameWords,
    this.complete = false,
    this.stageComplete = false,
  });

  /// If the player is in easy mode, aka shows the word to be found;
  ///
  /// Defaults to true
  ///
  final bool easyMode;

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

  /// When the current stage is complete and ready for next stage
  final bool stageComplete;

  /// Copy the current stage to a new object
  StageGameState copyWith({
    int current = 0,
    String? word,
    bool? isComplete,
  }) {
    return StageGameState(
      current,
      word ?? _getStageWord(current),
      isCompleted: isComplete ?? complete,
      words: gameWords,
    );
  }

  /// Copy the current finished stage
  StageCompleteState copyStageCompleteState() {
    return StageCompleteState(gameWords);
  }

  /// Get the current word for the puzzle
  String _getStageWord(int current) => gameWords[current] ?? '';

  /// Returns the word that is the goal for the current puzzle
  String getCurrentWord() {
    logger.wtf('StageWords: $gameWords | currentStage: $currentStage');
    assert(gameWords[currentStage] != null, 'Should always exist a word');
    return gameWords[currentStage] ?? '';
  }

  /// Determines if the user has reach the final level
  bool isGameFinished() => currentStage - initialStage == numberOfStages;

  @override
  List<Object?> get props => [
        easyMode,
        initialStage,
        numberOfStages,
        currentStage,
        gameWords,
        complete,
      ];

  /// Returns the current stage the user is at
  ///
  /// Corresponds to stage the player is current at versus ao many are left
  ///
  int getCurrentStage() => currentStage - initialStage;
}

/// Initial State of the game
class GameInitial extends GameState {
  /// Initial state of the game
  GameInitial()
      : super(
          gameWords: randomizeStageWords(), // Grabs the
          stageComplete: false,
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
  ) : super(
          stageComplete: true,
          gameWords: words,
        );
}

/// Current Stage Game State.
class StageGameState extends GameState {
  ///
  const StageGameState(
    int currentStage,
    this.word, {
    bool isCompleted = false,
    required Map<int, String> words,
  }) : super(
          currentStage: currentStage,
          complete: isCompleted,
          stageComplete: false,
          gameWords: words,
        );

  /// Word that solves the current puzzle
  final String word;

  @override
  List<Object?> get props => [
        ...super.props,
        word,
      ];
}
