import 'package:flutter/material.dart';

/// Simple widget to show the title of the puzzle
///
/// Default: 'Find the word' as title
///
///
class PuzzleWordTitle extends StatelessWidget {
  /// Main constructor
  const PuzzleWordTitle(
    this.label, {
    Key? key,
  }) : super(key: key);

  /// Text shown
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Color(0xFF949494),
      ),
    );
  }
}
