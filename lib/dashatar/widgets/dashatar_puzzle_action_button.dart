import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/assets/constants.dart';
import 'package:seletter/dashatar/dashatar.dart';
import 'package:seletter/l10n/l10n.dart';
import 'package:seletter/puzzle/puzzle.dart';
import 'package:seletter/theme/theme.dart';
import 'package:seletter/timer/timer.dart';

/// {@template dashatar_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class DashatarPuzzleActionButton extends StatefulWidget {
  /// {@macro dashatar_puzzle_action_button}
  const DashatarPuzzleActionButton({Key? key}) : super(key: key);

  @override
  State<DashatarPuzzleActionButton> createState() =>
      _DashatarPuzzleActionButtonState();
}

class _DashatarPuzzleActionButtonState
    extends State<DashatarPuzzleActionButton> {
  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);

    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == DashatarPuzzleStatus.loading;
    final isStarted = status == DashatarPuzzleStatus.started;

    final text = isStarted
        ? context.l10n.dashatarRestart
        : (isLoading
            ? context.l10n.dashatarGetReady
            : context.l10n.dashatarStartGame);

    return AnimatedSwitcher(
      duration: globalAnimationDuration,
      child: Tooltip(
        key: ValueKey(status),
        message: isStarted ? context.l10n.puzzleRestartTooltip : '',
        verticalOffset: 40,
        child: PuzzleButton(
          onPressed: isLoading
              ? null
              : () async {
                  final hasStarted = status == DashatarPuzzleStatus.started;

                  // Reset the timer and the countdown.
                  context.read<TimerBloc>().add(const TimerReset());
                  context.read<DashatarPuzzleBloc>().add(
                        DashatarCountdownReset(
                          secondsToBegin: hasStarted ? 5 : 3,
                        ),
                      );

                  // Initialize the puzzle board to show the initial puzzle
                  // (unshuffled) before the countdown completes.
                  if (hasStarted) {
                    context.read<PuzzleBloc>().add(
                          const PuzzleInitialized(shufflePuzzle: false),
                        );
                  }
                },
          textColor: isLoading ? theme.defaultColor : null,
          child: Text(text),
        ),
      ),
    );
  }
}
