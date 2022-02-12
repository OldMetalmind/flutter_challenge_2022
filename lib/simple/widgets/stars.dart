import 'package:flutter/material.dart';

/// Row of stars representing the current level of the puzze
class Stars extends StatelessWidget {
  /// Default constructor
  const Stars({Key? key, this.stageNumber = 0})
      : assert(stageNumber >= 0 && stageNumber <= 3, 'Stage number invalid'),
        super(key: key);

  /// What stage is the user at
  final int stageNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Star(active: true),
        Star(active: false),
        Star(active: false),
      ],
    );
  }
}

///
class Star extends StatelessWidget {
  ///
  const Star({Key? key, required this.active}) : super(key: key);

  /// True case the Star is active
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (active) {
      return Stack(
        children: const [
          Positioned(
            top: 2,
            child: Icon(
              Icons.star,
              color: Color(0xffE3A300),
            ),
          ),
          Icon(
            Icons.star,
            color: Color(0xffFFB906),
          ),
        ],
      );
    }

    return const Icon(
      Icons.star_border_outlined,
      color: Color(0xffD1D1D1),
    );
  }
}
