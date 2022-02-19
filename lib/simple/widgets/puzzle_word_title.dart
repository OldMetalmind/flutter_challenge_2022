import 'package:flutter/material.dart';

/// Simple widget to show the title of the puzzle
///
/// Default: 'Find the word' as title
///
///
class PuzzleWordTitle extends StatelessWidget {
  /// Main constructor
  const PuzzleWordTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Find the word', // TODO(FB) Add to IntL
      style: TextStyle(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Color(0xFF949494),
      ),
    );
  }
}
