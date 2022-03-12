import 'package:flutter/material.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';
import 'package:seletter/simple/widgets/puzzle_hint.dart';

/// Shows if a certain letter was found or not
class FinishLetter extends StatelessWidget {
  /// Main constructor
  const FinishLetter({
    Key? key,
    required this.letter,
    this.isFound = false,
  }) : super(key: key);

  /// Letter to be shown
  final String letter;

  /// If found it will show it in a green manner
  final bool isFound;

  @override
  Widget build(BuildContext context) {
    return PuzzleHint(
      letter: letter,
      animation: LottieAnimations.tileHint,
    );
  }
}
