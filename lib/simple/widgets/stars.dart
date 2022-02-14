import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selector/game/bloc/game_bloc.dart';

/// Row of stars representing the current level of the puzze
class Stars extends StatelessWidget {
  /// Default constructor
  const Stars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final stage = state.getCurrentStage();
        final numberOfStages = state.numberOfStages;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              numberOfStages,
              (index) => Star(
                active: index <= stage,
              ),
            )
          ],
        );
      },
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
    const size = 100.0;
    if (active) {
      return Stack(
        children: const [
          Positioned(
            top: 10,
            child: Icon(
              Icons.star,
              color: Color(0xffE3A300),
              size: size,
            ),
          ),
          Icon(
            Icons.star,
            color: Color(0xffFFB906),
            size: size,
          ),
        ],
      );
    }

    return const Icon(
      Icons.star_border_outlined,
      color: Color(0xffD1D1D1),
      size: size,
    );
  }
}
