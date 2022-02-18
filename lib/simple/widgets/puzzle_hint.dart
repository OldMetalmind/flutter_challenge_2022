import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Hint letter
class PuzzleHint extends StatefulWidget {
  /// Main constructor
  const PuzzleHint({
    Key? key,
    required this.letter,
  }) : super(key: key);

  /// Letter to be shown
  final String letter;

  @override
  State<PuzzleHint> createState() => _PuzzleHintState();
}

class _PuzzleHintState extends State<PuzzleHint> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: 0.18,
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
    return Container(
      child: Lottie.asset(
        'assets/animations/tile_hint.json',
        animate: false,
        frameRate: FrameRate.max,
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
      ),
    );
  }
}
