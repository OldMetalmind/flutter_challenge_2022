import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:seletter/assets/constants.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';

/// Row of stars representing the current level of the puzze
class Stars extends StatelessWidget {
  /// Default constructor
  const Stars({
    Key? key,
    this.scale,
  }) : super(key: key);

  /// When we want to set a different size than the default
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) =>
          previous.currentStage != current.currentStage,
      builder: (context, state) {
        final stage = state.currentStage;
        final numberOfStages = state.numberOfStages;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              numberOfStages,
              (index) => Star(
                key: UniqueKey(),
                active: index < (stage - state.initialStage),
                animation: LottieAnimations.starSmall,
                scale: scale,
              ),
            )
          ],
        );
      },
    );
  }
}

/// Star Widget with reactive animation
class Star extends StatefulWidget {
  /// Main Constructor
  const Star({
    Key? key,
    required this.active,
    required this.animation,
    this.initialAnimation = LottieAnimationType.iin,
    this.scale,
  }) : super(key: key);

  /// True case the Star is active
  final bool active;

  /// Animation file to be shown
  final LottieAnimation animation;

  /// Initial animation ran when created
  ///
  /// Default: LottieAnimationType.iin
  ///
  final LottieAnimationType initialAnimation;

  /// When we want to set a different size than the default
  final double? scale;

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late LottieAnimationType _currentAnimation;
  @override
  void initState() {
    super.initState();
    if (widget.active) {
      _animate(LottieAnimationType.correct);
    } else {
      _animate(widget.initialAnimation);
    }
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
    return Padding(
      padding: EdgeInsets.all(widget.scale == null ? 0 : 20),
      child: Transform.scale(
        scale: widget.scale ?? 1,
        child: Lottie.asset(
          widget.animation.lottieFile,
          animate: true,
          frameRate: FrameRate.max,
          controller: _animationController,
        ),
      ),
    );
  }
}
