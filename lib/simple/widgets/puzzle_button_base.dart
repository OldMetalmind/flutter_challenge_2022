import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:selector/assets/constants.dart';
import 'package:selector/helpers/animations_bounds_helper.dart';

/// Base Button.
class PuzzleButtonBase extends StatefulWidget {
  /// const Main constructor
  ///
  /// text: Label of the button
  /// onTap: action taken when clicking this button
  /// animation: Lottie animation used with this widget
  /// initialAnimation: What is the initial animation it should run
  const PuzzleButtonBase({
    Key? key,
    required this.text,
    required this.onTap,
    required this.animation,
    this.initialAnimation = LottieAnimationType.iin,
  }) : super(key: key);

  /// Text that is shown
  final String text;

  /// When button is tapped
  final VoidCallback onTap;

  /// Animation file to be shown
  final LottieAnimation animation;

  /// Initial animation ran when created
  ///
  /// Default: LottieAnimationType.iin
  ///
  final LottieAnimationType initialAnimation;

  @override
  State<PuzzleButtonBase> createState() => _PuzzleButtonBaseState();
}

class _PuzzleButtonBaseState extends State<PuzzleButtonBase>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late LottieAnimationType _currentAnimation;

  @override
  void initState() {
    super.initState();
    animate(widget.initialAnimation);
  }

  void animate(LottieAnimationType type) {
    _currentAnimation = type;
    _animationController = AnimationController(
      vsync: this,
      duration: globalAnimationDuration * 3,
      lowerBound: widget.animation.lowerBoundByType(_currentAnimation),
      upperBound: widget.animation.upperBoundByType(_currentAnimation),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            animate(LottieAnimationType.hoverIn);
          });
        },
        onExit: (event) {
          setState(() {
            animate(LottieAnimationType.hoverOut);
          });
        },
        child: Container(
          child: Lottie.asset(
            widget.animation.lottieFile,
            animate: true,
            frameRate: FrameRate.max,
            controller: _animationController,
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
      ),
    );
  }
}
