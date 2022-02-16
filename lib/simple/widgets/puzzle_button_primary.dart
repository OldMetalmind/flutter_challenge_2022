import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// ABC
class PuzzleButtonPrimary extends StatefulWidget {
  /// ABC
  const PuzzleButtonPrimary({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  /// Text that is shown
  final String text;

  /// When button is tapped
  final VoidCallback onTap;

  @override
  State<PuzzleButtonPrimary> createState() => _PuzzleButtonPrimaryState();
}

class _PuzzleButtonPrimaryState extends State<PuzzleButtonPrimary>
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
          'assets/animations/button_primary.json',
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
