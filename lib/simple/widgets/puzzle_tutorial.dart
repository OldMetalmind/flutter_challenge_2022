import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seletter/assets/constants.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';

/// Widget that holds the Tutorial Animation
class PuzzleTutorial extends StatefulWidget {
  /// Default constructor
  const PuzzleTutorial({
    Key? key,
    required this.animation,
  }) : super(key: key);

  /// Animation file to be shown
  final LottieAnimation animation;

  @override
  State<PuzzleTutorial> createState() => _PuzzleTutorialState();
}

class _PuzzleTutorialState extends State<PuzzleTutorial>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Animates this widget according with Animation Type and the default Lottie
  /// animation
  void _animate() {
    _animationController = AnimationController(
      vsync: this,
      duration: globalAnimationDurationSlower,
    );
    _animationController
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController
            ..reset()
            ..forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.animation.lottieFile,
      animate: true,
      frameRate: FrameRate.max,
      controller: _animationController,
      delegates: LottieDelegates(
        textStyle: (font) {
          return TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: font.fontFamily,
          );
        },
        values: [
          ValueDelegate.color(['A'], value: const Color(0xffFFFFFF)),
        ],
      ),
    );
  }
}
