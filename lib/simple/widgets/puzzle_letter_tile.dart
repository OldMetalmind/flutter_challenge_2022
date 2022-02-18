import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:selector/assets/constants.dart';
import 'package:selector/helpers/animations_bounds_helper.dart';

/// Main Widget that handles the letter tile for the Puzzle
/// Depending on the status will present the respective animation
class PuzzleLetterTile extends StatefulWidget {
  /// Main constructor
  const PuzzleLetterTile(
    this.letter, {
    Key? key,
    this.animation = lottieTileAnimationFile,
    this.initialAnimation = LottieAnimationType.iin,
  }) : super(key: key);

  /// Lottie Animation associated with this widget
  final String animation;

  /// Letter shown with this tile
  final String letter;

  /// Initial animation run when this Tile is created
  final LottieAnimationType initialAnimation;

  @override
  State<PuzzleLetterTile> createState() => _PuzzleLetterTileState();
}

class _PuzzleLetterTileState extends State<PuzzleLetterTile>
    with SingleTickerProviderStateMixin {
  final LottieTilePuzzleAnimation bounds = LottieAnimations.tilePuzzle;

  late AnimationController _controller;

  late LottieAnimationType currentAnimation;

  @override
  void initState() {
    super.initState();
    currentAnimation = widget.initialAnimation;

    _controller = AnimationController(
      vsync: this,
      duration: globalAnimationDuration,
      lowerBound: bounds.lowerBoundByType(currentAnimation),
      upperBound: bounds.upperBoundByType(currentAnimation),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.animation,
      animate: false,
      controller: _controller,
      delegates: LottieDelegates(
        text: (initialText) => widget.letter,
        textStyle: (lottie) {
          return const TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Rubik',
            color: Color(0xff6B6B6B),
          );
        },
      ),
    );
  }
}
