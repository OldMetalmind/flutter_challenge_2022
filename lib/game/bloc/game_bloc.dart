import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seletter/assets/words.dart';

part 'game_event.dart';
part 'game_state.dart';

/// Business logic of the game itself
class GameBloc extends Bloc<GameEvent, GameState> {
  /// Constructor with the initial set defined so the game can begin
  GameBloc() : super(GameInitial()) {
    on<NextStageGameEvent>((event, emit) {
      final currentStage = state.currentStage + 1;
      emit(
        state.copyWith(
          current: currentStage,
        ),
      );
    });

    on<StageCompleteGameEvent>((event, emit) {
      emit(
        state.copyStageCompleteState(state.currentStage),
      );
    });

    on<FinishedGameEvent>((event, emit) {
      emit(
        state.copyWith(
          current: state.currentStage,
          isComplete: true,
        ),
      );
    });

    on<UpdateHardModeEvent>((event, emit) {
      emit(
        state.copyWith(
          current: state.currentStage,
          isHard: event.value,
        ),
      );
    });
  }
}
