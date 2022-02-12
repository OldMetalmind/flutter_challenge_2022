import 'package:flutter/material.dart';

class WordTip extends StatelessWidget {
  const WordTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        WordLetter(
          letter: 'G',
        ),
        WordLetter(
          letter: 'E',
        ),
        WordLetter(
          letter: 'T',
        ),
      ],
    );
  }
}

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
