import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';
import 'package:seletter/simple/widgets/puzzle_hint.dart';

/// Used in the final screen to show what words the player found and not found
class FinishCompletedWords extends StatelessWidget {
  /// Main constructor
  const FinishCompletedWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Column(
          children: [
            ...state.gameWords.entries.map<Widget>(
              (entry) {
                final wasFound = entry.key <= state.currentStage;
                final word = entry.value;
                return _FinishCompletedWord(
                  word: word,
                  wasFound: wasFound,
                );
              },
            ).toList(),
          ],
        );
      },
    );
  }
}

class _FinishCompletedWord extends StatelessWidget {
  const _FinishCompletedWord({
    Key? key,
    required this.word,
    this.wasFound = false,
  }) : super(key: key);

  /// If the words was successfully found
  final bool wasFound;

  /// Word to be shown
  final String word;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...word.split('').map(
              (letter) => Padding(
                padding: const EdgeInsets.only(top: 12),
                child: PuzzleHint(
                  key: UniqueKey(),
                  letter: letter,
                  animation: LottieAnimations.tileHint,
                  initialAnimation: wasFound
                      ? LottieAnimationType.correct
                      : LottieAnimationType.iin,
                ),
              ),
            ),
      ],
    );
  }
}
