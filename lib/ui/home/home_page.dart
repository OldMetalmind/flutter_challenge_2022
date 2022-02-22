import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/src/provider.dart';
import 'package:seletter/assets/constants.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';
import 'package:seletter/simple/widgets/puzzle_button_primary.dart';
import 'package:seletter/simple/widgets/puzzle_button_secondary.dart';
import 'package:seletter/simple/widgets/puzzle_empty_tile.dart';
import 'package:seletter/simple/widgets/puzzle_hard_mode_checkbox.dart';
import 'package:seletter/simple/widgets/puzzle_letter_tile.dart';
import 'package:seletter/simple/widgets/puzzle_tutorial.dart';

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
              const MainLogoLottie(
                animation: LottieAnimations.introLogo,
              ),
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
                onTap: () {
                  /// Show Dialog
                  showTutorial(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Show how to play
  void showTutorial(BuildContext context) {
    showDialog<Container>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xffEFEFEF),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            PuzzleButtonSecondary(
              text: 'CLOSE',
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'HOW TO PLAY',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Color(0xff94949494),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Slide the tiles to find the word vertically or horizontally',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Color(0xff94949494),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40),
              PuzzleTutorial(
                animation: LottieAnimations.tutorial,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Main logo for the app Seletter with Lottie animation
class MainLogoLottie extends StatefulWidget {
  /// Main constructor
  const MainLogoLottie({Key? key, required this.animation}) : super(key: key);

  /// Animation file to be shown
  final LottieAnimation animation;

  @override
  State<MainLogoLottie> createState() => _MainLogoLottieState();
}

class _MainLogoLottieState extends State<MainLogoLottie>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Animates this widget according with Animation Type and the default Lottie
  /// animation
  void _animate() {
    _animationController = AnimationController(
      vsync: this,
      duration: globalAnimationDurationSlower,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.animation.lottieFile,
      animate: true,
      frameRate: FrameRate.max,
      controller: _animationController,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(['A'], value: const Color(0xffFFFFFF)),
        ],
      ),
    );
  }
}

/// Main Logo of the app seletter
@Deprecated('Use MainLogoLottie instead')
class MainLogo extends StatelessWidget {
  /// Default constructor with Key
  @Deprecated('Deprecated constructor')
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
