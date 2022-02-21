import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';
import 'package:seletter/simple/widgets/puzzle_button_primary.dart';
import 'package:seletter/simple/widgets/puzzle_button_secondary.dart';
import 'package:seletter/simple/widgets/puzzle_empty_tile.dart';
import 'package:seletter/simple/widgets/puzzle_hard_mode_checkbox.dart';
import 'package:seletter/simple/widgets/puzzle_letter_tile.dart';

/// First page that the user lands on when opening the app
class HomePage extends StatelessWidget {
  /// Main constructor
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const MainLogo(),
              const SizedBox(height: 72),
              PuzzleHardModeCheckbox(
                value: context.read<GameBloc>().state.hardMode,
              ),
              const SizedBox(height: 18),
              PuzzleButtonPrimary(
                text: 'PLAY NOW',
                onTap: () {
                  Navigator.pushNamed(context, '/game');
                },
              ),
              const SizedBox(height: 18),
              PuzzleButtonSecondary(
                text: 'HOW TO PLAY',
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Main Logo of the app seletter
class MainLogo extends StatelessWidget {
  ///
  const MainLogo({Key? key}) : super(key: key);

  /// Words presented as a logo
  static const String name = 'SE_LETTER';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhysicalModel(
          color: Theme.of(context).colorScheme.background,
          shadowColor: Theme.of(context).colorScheme.background,
          elevation: 10,
          borderRadius: BorderRadius.circular(24),
          child: const SizedBox(
            height: 500,
            width: 500,
          ),
        ),
        SizedBox(
          height: 500,
          width: 500,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              ...name.split('').asMap().entries.map<Widget>(
                (entry) {
                  Widget tile;
                  if (entry.value == '_') {
                    return const PuzzleEmptyTile();
                  } else if (entry.key > 2) {
                    tile = PuzzleLetterTile(
                      entry.value,
                      initialAnimation: LottieAnimationType.correct,
                    );
                  } else {
                    tile = PuzzleLetterTile(entry.value);
                  }

                  return tile;
                },
              ).toList()
            ],
          ),
        )
      ],
    );
  }
}
