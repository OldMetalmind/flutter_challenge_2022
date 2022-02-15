part of 'game_bloc.dart';

/// Base class used for [GameBloc] logic
abstract class GameEvent extends Equatable {
  /// Default constructor
  const GameEvent();
}

/// When the user finish a stage he moves to the next one.
///
/// If it is the final stage, it will show the end game screen.
class NextStageGameEvent extends GameEvent {
  @override
  List<Object?> get props => [];
}

/// When the current stage is finished and ready for next stage
class StageCompleteGameEvent extends GameEvent {
  @override
  List<Object?> get props => [];
}

/// When the came is complete and completely finished, ready for sharing data
class FinishedGameEvent extends GameEvent {
  @override
  List<Object?> get props => [];
}
