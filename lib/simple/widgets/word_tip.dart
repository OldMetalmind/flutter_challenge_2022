import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:selector/game/bloc/game_bloc.dart';

/// Shows the Word that the player needs to find
class WordTip extends StatelessWidget {
  /// Constructor
  const WordTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) =>
          previous.currentStage != current.currentStage,
      builder: (context, state) {
        final word = context.watch<GameBloc>().state.getCurrentWord();
        final tip =
            word.split('').map((letter) => WordLetter(letter: letter)).toList();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...tip,
          ],
        );
      },
    );
  }
}

/// A Letter of the word that the player needs to find
class WordLetter extends StatelessWidget {
  const WordLetter({Key? key, required this.letter}) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff949494a),
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          letter,
          style: TextStyle(),
        ));
  }
}
