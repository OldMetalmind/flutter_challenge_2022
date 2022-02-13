part of 'game_bloc.dart';

/// Base State
abstract class GameState extends Equatable {
  /// Simple Constructor
  const GameState({
    this.easyMode = false,
    this.initialStage = 3,
    this.numberOfStages = 3,
    this.currentStage = 3,
    this.stageWords = const [],
    this.complete = false,
  });

  /// If the player is in easy mode, aka shows the word to be found;
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
  final List<String> stageWords;

  /// Determines if player completed the final level
  final bool complete;

  /// Copy the current stage to a new object
  StageGameState copyWith({int? current, String? word, bool? isComplete}) {
    return StageGameState(
      current ?? currentStage,
      word ?? getStageWord(current),
      isCompleted: isComplete ?? complete,
    );
  }

  /// Get the current word for the puzzle
  String getStageWord(int? current) {
    if (current != null && current < initialStage + numberOfStages) {
      return stageWords[current];
    } else {
      return '';
    }
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
  static List<String> randomizeStageWords() {
    return validWords.entries.fold(<String>[], (previousValue, words) {
      previousValue.add(words.value.first); //TODO(FB) Randomize properly
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
  }) : super(
          currentStage: currentStage,
          complete: isCompleted,
        );

  /// Word that solves the current puzzle
  final String word;

  @override
  List<Object?> get props => [
        ...super.props,
        word,
      ];
}
