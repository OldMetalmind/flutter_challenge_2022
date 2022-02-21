import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seletter/assets/constants.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';
import 'package:seletter/models/position.dart';
import 'package:seletter/models/tile.dart';

/// Used to animate the tile when tapped
class AnimateTappedTile extends StatefulWidget {
  /// Main const constructor
  const AnimateTappedTile({
    Key? key,
    required this.position,
    required this.squareSize,
    required this.spaceTile,
    required this.tile,
    required this.animationListener,
    this.animation = LottieAnimations.tilePuzzle,
    this.initialAnimation = LottieAnimationType.iin,
  }) : super(key: key);

  /// Position of the clicked tile
  final Position position;

  /// Size of each square used in the animation
  final double squareSize;

  /// The whitespace tile information
  final Tile? spaceTile;

  /// The tile information
  final Tile? tile;

  /// Animation listener to handle outside of this widget
  final VoidCallback animationListener;

  /// Animation used with this tile
  final LottieTilePuzzleAnimation animation;

  /// Initial Animation ran
  final LottieAnimationType initialAnimation;

  @override
  State<AnimateTappedTile> createState() => _AnimateTappedTileState();
}

/// AnimationControllers can be created with `vsync: this` because
/// of [TickerProviderStateMixin]
class _AnimateTappedTileState extends State<AnimateTappedTile>
    with TickerProviderStateMixin {
  _AnimateTappedTileState();

  late final AnimationController _controller;
  late final AnimationController _controllerLottie;

  late LottieAnimationType _currentAnimation;

  @override
  void initState() {
    super.initState();
    _currentAnimation = widget.initialAnimation;

    _controller = AnimationController(
      duration: globalTileMovementAnimationDuration,
      vsync: this,
    );

    _controllerLottie = AnimationController(
      duration: globalTileMovementAnimationDuration,
      vsync: this,
      lowerBound: widget.animation.lowerBoundByType(_currentAnimation),
      upperBound: widget.animation.upperBoundByType(_currentAnimation),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            widget.animationListener.call();
          }
        },
      );

    _controller.forward();
    _controllerLottie
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerLottie.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spaceTile =
        widget.spaceTile?.currentPosition ?? const Position(x: 0, y: 0);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final biggest = constraints.biggest;
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                  Rect.fromLTWH(
                    (widget.position.x * widget.squareSize) - widget.squareSize,
                    (widget.position.y * widget.squareSize) - widget.squareSize,
                    widget.squareSize,
                    widget.squareSize,
                  ),
                  biggest,
                ),
                end: RelativeRect.fromSize(
                  Rect.fromLTWH(
                    (spaceTile.x - 1) * widget.squareSize,
                    (spaceTile.y - 1) * widget.squareSize,
                    widget.squareSize,
                    widget.squareSize,
                  ),
                  biggest,
                ),
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.linear,
                ),
              ),
              child: Lottie.asset(
                widget.animation.lottieFile,
                frameRate: FrameRate.max,
                fit: BoxFit.contain,
                height: 100,
                width: 100,
                controller: _controllerLottie,
                delegates: LottieDelegates(
                  textStyle: (lottie) {
                    return const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Rubik',
                      color: Color(0xff6B6B6B),
                    );
                  },
                  text: (initialText) => widget.tile?.letter ?? '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
