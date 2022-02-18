import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:selector/assets/constants.dart';
import 'package:selector/helpers/animations_bounds_helper.dart';

/// Base Button.
class PuzzleButtonBase extends StatefulWidget {
  /// ABC
  const PuzzleButtonBase({
    Key? key,
    required this.text,
    required this.onTap,
    required this.animation,
    required this.initialAnimation,
  }) : super(key: key);

  /// Text that is shown
  final String text;

  /// When button is tapped
  final VoidCallback onTap;

  /// Animation file to be shown
  final LottieAnimation animation;

  /// Initial animation ran when created
  final LottieAnimationType initialAnimation;

  @override
  State<PuzzleButtonBase> createState() => _PuzzleButtonBaseState();
}

class _PuzzleButtonBaseState extends State<PuzzleButtonBase>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late LottieAnimationType currentAnimation;

  @override
  void initState() {
    super.initState();
    currentAnimation = widget.initialAnimation;
    _controller = AnimationController(
      vsync: this,
      duration: globalAnimationDuration * 3,
      lowerBound: widget.animation.lowerBoundByType(currentAnimation),
      upperBound: widget.animation.upperBoundByType(currentAnimation),
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
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Lottie.asset(
          widget.animation.lottieFile,
          animate: false,
          controller: _controller,
          delegates: LottieDelegates(
            text: (initialText) => widget.text,
            textStyle: (lottie) {
              return const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Rubik',
                color: Color(0xff6B6B6B),
              );
            },
          ),
        ),
      ),
    );
  }
}
