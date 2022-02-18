import 'package:flutter/material.dart';
import 'package:selector/simple/widgets/puzzle_button_primary.dart';
import 'package:selector/simple/widgets/puzzle_button_secondary.dart';
import 'package:selector/simple/widgets/puzzle_letter_tile.dart';

/// First page that the user lands on when opening the app
class HomePage extends StatelessWidget {
  /// Main constructor
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const MainLogo(),
            const SizedBox(height: 72),
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
    );
  }
}

/// Main Logo of the app SELECTOR
class MainLogo extends StatelessWidget {
  ///
  const MainLogo({Key? key}) : super(key: key);

  /// Words presented as a logo
  static const String name = 'SE LECTOR';

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Theme.of(context).colorScheme.background,
      shadowColor: Theme.of(context).colorScheme.background,
      elevation: 10,
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 500,
        width: 500,
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            ...name
                .split('')
                .map<Widget>(
                  (letter) => PuzzleLetterTile(letter),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
