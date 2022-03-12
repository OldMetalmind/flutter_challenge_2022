import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/helpers/navigator_helper.dart';
import 'package:seletter/simple/widgets/puzzle_button_primary.dart';
import 'package:seletter/simple/widgets/puzzle_word_title.dart';
import 'package:seletter/simple/widgets/stars.dart';
import 'package:seletter/ui/finish/finish_completed_words.dart';

/// Page the user sees when he sucessfully finish a game
class FinishPage extends StatelessWidget {
  /// Main constructor
  const FinishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state.complete) {
                return const _FinishPageContent(
                  title: 'Congratulations!',
                  subtitle: 'You found all the words.',
                );
              } else {
                return const _FinishPageContent(
                  title: "You didn't found all the words!",
                  subtitle: 'Try again with the next set of words.',
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _FinishPageContent extends StatelessWidget {
  const _FinishPageContent({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Column(
            children: [
              PuzzleWordTitle(title),
              PuzzleWordTitle(subtitle),
              if (state.hardMode)
                Column(
                  children: const [
                    SizedBox(height: 20),
                    PuzzleWordTitle('Played in HardMode!'),
                  ],
                ),
              const SizedBox(height: 50),
              const FinishCompletedWords(),
              const SizedBox(height: 50),
              const Stars(
                scale: 2,
              ),
              const SizedBox(height: 50),
              PuzzleButtonPrimary(
                text: 'Play Again',
                onTap: () {
                  context.read<GameBloc>().add(const GameResetEvent());
                  PuzzleNavigator.navigateToHome(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
