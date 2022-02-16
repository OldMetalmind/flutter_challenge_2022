import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// ABC
class PuzzleButtonBase extends StatefulWidget {
  /// ABC
  const PuzzleButtonBase({
    Key? key,
    required this.text,
    required this.onTap,
    required this.animation,
  }) : super(key: key);

  /// Text that is shown
  final String text;

  /// When button is tapped
  final VoidCallback onTap;

  /// Animation file to be shown
  final String animation;

  @override
  State<PuzzleButtonBase> createState() => _PuzzleButtonBaseState();
}

class _PuzzleButtonBaseState extends State<PuzzleButtonBase>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: 0.20,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Lottie.asset(
          widget.animation,
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
