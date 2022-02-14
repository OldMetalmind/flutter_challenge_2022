part of 'game_bloc.dart';

/// Base State
abstract class GameState extends Equatable {
  /// Simple Constructor
  const GameState({
    this.easyMode = true,
    this.initialStage = 3,
    this.numberOfStages = 3,
    this.currentStage = 3,
    this.stageWords = const <int, String>{},
    this.complete = false,
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
  final Map<int, String> stageWords;

  /// Determines if player completed the final level
  final bool complete;

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
      stageWords: stageWords,
    );
  }

  /// Get the current word for the puzzle
  String _getStageWord(int current) => stageWords[current] ?? '';

  /// Returns the word that is the goal for the current puzzle
  String getCurrentWord() {
    logger.wtf('StageWords: $stageWords | currentStage: $currentStage');
    assert(stageWords[currentStage] != null, 'Should always exist a word');
    return stageWords[currentStage] ?? '';
  }

  @override
  List<Object?> get props => [
        easyMode,
        initialStage,
        numberOfStages,
        currentStage,
        stageWords,
        complete,
      ];
}

/// Initial State of the game
class GameInitial extends GameState {
  /// Initial state of the game
  GameInitial()
      : super(
          stageWords: randomizeStageWords(), // Grabs the
        );

  /// Randomize what will be the words that the player needs to find
  static Map<int, String> randomizeStageWords() {
    return validWords.entries.fold(<int, String>{}, (previousValue, words) {
      previousValue[words.key] =
          words.value.first; //TODO(FB) Randomize properly
      //previousValue.add(words.value.first);
      return previousValue;
    });
  }

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}

/// Current Stage Game State.
class StageGameState extends GameState {
  ///
  const StageGameState(
    int currentStage,
    this.word, {
    bool isCompleted = false,
    required Map<int, String> stageWords,
  }) : super(
          currentStage: currentStage,
          complete: isCompleted,
          stageWords: stageWords,
        );

  /// Word that solves the current puzzle
  final String word;

  @override
  List<Object?> get props => [
        ...super.props,
        word,
      ];
}
