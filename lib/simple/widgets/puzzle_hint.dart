import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seletter/assets/constants.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';

/// Hint letter
class PuzzleHint extends StatefulWidget {
  /// Main constructor
  const PuzzleHint({
    Key? key,
    required this.letter,
    required this.animation,
    this.initialAnimation = LottieAnimationType.iin,
  }) : super(key: key);

  /// Letter to be shown
  final String letter;

  /// Animation file to be shown
  final LottieAnimation animation;

  /// Initial animation ran when created
  ///
  /// Default: LottieAnimationType.iin
  ///
  final LottieAnimationType initialAnimation;

  @override
  State<PuzzleHint> createState() => _PuzzleHintState();
}

class _PuzzleHintState extends State<PuzzleHint> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late LottieAnimationType _currentAnimation;

  @override
  void initState() {
    super.initState();
    _animate(widget.initialAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Animates this widget according with Animation Type and the default Lottie
  /// animation
  void _animate(LottieAnimationType type) {
    _currentAnimation = type;
    _animationController = AnimationController(
      vsync: this,
      duration: globalAnimationDurationSlower,
      lowerBound: widget.animation.lowerBoundByType(_currentAnimation),
      upperBound: widget.animation.upperBoundByType(_currentAnimation),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.animation.lottieFile,
      animate: true,
      frameRate: FrameRate.max,
      controller: _animationController,
      delegates: LottieDelegates(
        text: (initialText) => widget.letter,
        textStyle: (font) {
          return TextStyle(
              fontWeight: FontWeight.w700, fontFamily: font.fontFamily);
        },
        values: [
          ValueDelegate.color(['A'], value: const Color(0xff949494)),
        ],
      ),
    );
  }
}
