import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selector/assets/words.dart';

part 'game_event.dart';
part 'game_state.dart';

/// Business logic of the game itself
class GameBloc extends Bloc<GameEvent, GameState> {
  /// Constructor with the initial set defined so the game can begin
  GameBloc() : super(GameInitial()) {
    on<GameEvent>((event, emit) {
      final currentStage = state.initialStage;
      final currentWord = state.stageWords[currentStage];

      emit(
        state.copyWith(
          current: currentStage,
          word: currentWord,
        ),
      );

      emit.call(
        StageGameState(currentStage, currentWord),
      );
    });

    on<NextStageGameEvent>((event, emit) {
      final currentStage = state.currentStage + 1;
      final currentWord = state.stageWords[currentStage];
      final isCompleted =
          currentStage == state.initialStage + state.numberOfStages;
      emit(
        state.copyWith(
          current: currentStage,
          word: currentWord,
          isComplete: isCompleted,
        ),
      );
    });
  }
}
