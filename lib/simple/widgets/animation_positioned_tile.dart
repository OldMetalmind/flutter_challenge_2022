import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:very_good_slide_puzzle/assets/constants.dart';
import 'package:very_good_slide_puzzle/models/position.dart';
import 'package:very_good_slide_puzzle/models/tile.dart';

/// ABC
class AnimateTappedTile extends StatefulWidget {
  /// ABC
  const AnimateTappedTile({
    Key? key,
    required this.position,
    required this.squareSize,
    required this.spaceTile,
    required this.lottieAnimation,
    required this.animationListener,
  }) : super(key: key);

  /// Position of the clicked tile
  final Position position;

  /// Size of each square used in the animation
  final double squareSize;

  /// The whitespace tile information
  final Tile? spaceTile;

  /// Asset used in the Lottie animation
  final String lottieAnimation;

  /// Animation listener to handle outside of this widget
  final VoidCallback animationListener;

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

  final animationDuration  = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    _controllerLottie = AnimationController(
      duration: animationDuration,
      vsync: this,
      lowerBound: 3.74 / animationGoldenNumber,
      upperBound: 3.92 / animationGoldenNumber,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.animationListener.call();
        }
      });
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

    log('Position: ${widget.position} | space: $spaceTile ');

    _controller..reset()..forward();
    _controllerLottie..reset()..forward();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final biggest = constraints.biggest;
        return Stack(
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
                widget.lottieAnimation,
                controller: _controllerLottie,
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }
}
