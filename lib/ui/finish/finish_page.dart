import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/helpers/navigator_helper.dart';
import 'package:seletter/simple/widgets/puzzle_button_primary.dart';
import 'package:seletter/simple/widgets/puzzle_word_title.dart';
import 'package:seletter/simple/widgets/stars.dart';
import 'package:seletter/ui/finish/finish_completed_words.dart';

/// Page the user sees when he successfully finish a game
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
              const SizedBox(height: 16),
              _StepsTakenWidget(
                totalSteps: state.totalSteps,
                isHardMode: state.hardMode,
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

/// Shows the total number of steps taken to complete the game and also if it
/// was in hard mode!
class _StepsTakenWidget extends StatelessWidget {
  /// Main constructor
  const _StepsTakenWidget({
    Key? key,
    required this.totalSteps,
    this.isHardMode = false,
  }) : super(key: key);

  /// total steps needed to complete the game
  final int totalSteps;

  /// If game completed in hardmode
  final bool isHardMode;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'You took',
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color(0xFF949494),
        ),
        children: [
          TextSpan(
            text: ' $totalSteps ',
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color(0xFF49D737),
            ),
          ),
          TextSpan(
            text: 'steps',
            style: getTextStyle(),
          ),
          if (isHardMode)
            TextSpan(
              text: ', on hard mode!',
              style: getTextStyle(),
            )
          else
            TextSpan(
              text: '.',
              style: getTextStyle(),
            ),
        ],
      ),
    );
  }

  TextStyle getTextStyle() {
    return const TextStyle(
      fontFamily: 'Rubik',
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Color(0xFF949494),
    );
  }
}
