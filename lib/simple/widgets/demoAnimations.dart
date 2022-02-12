import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:very_good_slide_puzzle/assets/constants.dart';
import 'package:very_good_slide_puzzle/models/tile_animation.dart';

class DemoAnimations extends StatelessWidget {
  const DemoAnimations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...TileAnimationEnum.values.map((e) => _DemoAnimation(e)).toList(),
      ],
    );
  }
}

class _DemoAnimation extends StatefulWidget {
  const _DemoAnimation(this.animation, {Key? key}) : super(key: key);

  final TileAnimationEnum animation;

  @override
  __DemoAnimationState createState() => __DemoAnimationState();
}

class __DemoAnimationState extends State<_DemoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: globalAnimationDuration,
      lowerBound: widget.animation.bounds().first,
      upperBound: widget.animation.bounds().last,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.animation.name),
          Transform.scale(
            scale: 2.5,
            child: Lottie.asset(
              lottieTileAnimationFile,
              animate: false,
              controller: _controller,
              delegates: LottieDelegates(
                text: (initialText) => 'Z',
                textStyle: (lottie) {
                  return const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Rubik',
                  );
                },
              ),
            ),
          ),
          //Text(widget.animation.bounds().map((e) => e.toString()).toList().toString()),
        ],
      ),
    );
  }
}
