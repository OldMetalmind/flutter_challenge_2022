import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/simple/widgets/puzzle_button_primary.dart';
import 'package:seletter/simple/widgets/puzzle_word_title.dart';

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
                return Column(
                  children: [
                    const PuzzleWordTitle('Congratulations!'),
                    const PuzzleWordTitle('You found all the words today!'),
                    PuzzleButtonPrimary(
                      text: 'Share',
                      onTap: () {},
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const PuzzleWordTitle("You didn't all the words!"),
                    const PuzzleWordTitle('Try again tomorrow.'),
                    PuzzleButtonPrimary(
                      text: 'Share',
                      onTap: () {},
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
