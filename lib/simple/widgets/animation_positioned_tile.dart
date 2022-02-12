import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:very_good_slide_puzzle/assets/constants.dart';
import 'package:very_good_slide_puzzle/models/position.dart';
import 'package:very_good_slide_puzzle/models/tile.dart';
import 'package:very_good_slide_puzzle/models/tile_animation.dart';

/// Used to animate the tile when tapped
class AnimateTappedTile extends StatefulWidget {
  /// Main const constructor
  const AnimateTappedTile({
    Key? key,
    required this.position,
    required this.squareSize,
    required this.spaceTile,
    required this.tile,
    required this.animationListener, required this.tileAnimation,
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

  /// Model for this animation tile
  final TileAnimation tileAnimation;

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: globalAnimationDuration,
      vsync: this,
    );

    _controllerLottie = AnimationController(
      duration: globalAnimationDuration,
      vsync: this,
      lowerBound: widget.tileAnimation.animation.bounds().first,
      upperBound: widget.tileAnimation.animation.bounds().last,
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

    _controller..reset()..forward();
    _controllerLottie..reset()..forward();

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
                  biggest ,
                ),
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.linear,
                ),
              ),
              child: Transform.scale(
                scale: 2,
                child: Lottie.asset(
                  widget.tileAnimation.animationFile,
                  controller: _controllerLottie,
                  delegates: LottieDelegates(
                    textStyle: (lottie){
                      return const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Rubik',
                      );

                    },
                    text: (initialText) => widget.tile?.letter ?? '',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
