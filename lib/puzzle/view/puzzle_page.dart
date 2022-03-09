import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/dashatar/dashatar.dart';
import 'package:seletter/game/bloc/game_bloc.dart';
import 'package:seletter/l10n/l10n.dart';
import 'package:seletter/layout/layout.dart';
import 'package:seletter/models/models.dart';
import 'package:seletter/puzzle/puzzle.dart';
import 'package:seletter/simple/simple.dart';
import 'package:seletter/simple/widgets/puzzle_button_primary.dart';
import 'package:seletter/simple/widgets/puzzle_button_secondary.dart';
import 'package:seletter/simple/widgets/puzzle_word_title.dart';
import 'package:seletter/simple/widgets/stars.dart';
import 'package:seletter/simple/widgets/word_tip.dart';
import 'package:seletter/theme/theme.dart';
import 'package:seletter/timer/timer.dart';
import 'package:seletter/typography/typography.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]
/// from [ThemeBloc].
/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DashatarThemeBloc(
            themes: const [
              BlueDashatarTheme(),
              GreenDashatarTheme(),
              YellowDashatarTheme()
            ],
          ),
        ),
        BlocProvider(
          create: (_) => DashatarPuzzleBloc(
            secondsToBegin: 3,
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(
            initialThemes: [
              const SimpleTheme(),
              context.read<DashatarThemeBloc>().state.theme,
            ],
          ),
        ),
        BlocProvider(
          create: (_) => TimerBloc(
            ticker: const Ticker(),
          ),
        ),
      ],
      child: const PuzzleView(),
    );
  }
}

/// {@template puzzle_view}
/// Displays the content for the [PuzzlePage].
/// {@endtemplate}
class PuzzleView extends StatefulWidget {
  /// {@macro puzzle_view}
  const PuzzleView({Key? key}) : super(key: key);

  @override
  State<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    /// Shuffle only if the current theme is Simple.
    final shufflePuzzle = theme is SimpleTheme;

    final gameStage = context.read<GameBloc>().state;

    return Scaffold(
      body: AnimatedContainer(
        duration: PuzzleThemeAnimationDuration.backgroundColorChange,
        child: BlocListener<DashatarThemeBloc, DashatarThemeState>(
          listener: (context, state) {
            final dashatarTheme = context.read<DashatarThemeBloc>().state.theme;
            context.read<ThemeBloc>().add(ThemeUpdated(theme: dashatarTheme));
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TimerBloc(
                  ticker: const Ticker(),
                ),
              ),
              BlocProvider(
                lazy: false,
                create: (context) => PuzzleBloc(
                  gameStage.currentStage,
                  gameStage.gameWords,
                )..add(
                    PuzzleInitialized(
                      shufflePuzzle: shufflePuzzle,
                    ),
                  ),
              ),
            ],
            child: const _Puzzle(
              key: Key('puzzle_view_puzzle'),
            ),
          ),
        ),
      ),
    );
  }
}

class _Puzzle extends StatefulWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  State<_Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<_Puzzle> {
  late bool showNextStageButton;

  @override
  void initState() {
    super.initState();
    showNextStageButton = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    final puzzleIncomplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;

    return BlocBuilder<PuzzleBloc, PuzzleState>(
      buildWhen: (previous, current) {
        return previous.puzzleStatus != current.puzzleStatus;
      },
      builder: (context, puzzleState) {
        return BlocBuilder<GameBloc, GameState>(
          buildWhen: (previous, current) {
            return previous.currentStage != current.currentStage;
          },
          builder: (context, gameState) {
            showNextStageButton =
                puzzleState.puzzleStatus == PuzzleStatus.complete;
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    if (theme is SimpleTheme)
                      theme.layoutDelegate.backgroundBuilder(state),
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 48),
                          child: Column(
                            children: [
                              const PuzzleWordTitle(),
                              const SizedBox(height: 16),
                              if (gameState.isEasyModeActivated)
                                const WordTip(),
                              const SizedBox(height: 24),
                              const Stars(),
                              const PuzzleSections(),

                              if (showNextStageButton)
                                PuzzleButtonPrimary(
                                  //TODO(FB) Move to IntL,
                                  text: 'Next',
                                  onTap: () {
                                    setState(() {
                                      showNextStageButton =
                                          !showNextStageButton;
                                    });

                                    context.read<GameBloc>().add(
                                          NextStageGameEvent(),
                                        );

                                    context.read<PuzzleBloc>().add(
                                          PuzzleNextStageEvent(
                                            gameState.currentStage,
                                          ),
                                        );
                                  },
                                ),
                              if (!showNextStageButton)
                                PuzzleButtonSecondary(
                                  text: 'I Quit',
                                  onTap: () {
                                    context
                                        .read<GameBloc>()
                                        .add(const GameResetEvent());
                                    context
                                        .read<PuzzleBloc>()
                                        .add(const PuzzleReset());
                                    Navigator.pop(context);
                                  },
                                ),
                              //const DemoAnimations(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (theme is! SimpleTheme)
                      theme.layoutDelegate.backgroundBuilder(state),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

/// {@template puzzle_logo}
/// Displays the logo of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleLogo extends StatelessWidget {
  /// {@macro puzzle_logo}
  const PuzzleLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    return AppFlutterLogo(
      key: puzzleLogoKey,
      isColored: theme.isLogoColored,
    );
  }
}

/// {@template puzzle_sections}
/// Displays start and end sections of the puzzle.
/// {@endtemplate}
class PuzzleSections extends StatelessWidget {
  /// {@macro puzzle_sections}
  const PuzzleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return ResponsiveLayoutBuilder(
      small: (context, child) => Column(
        children: [
          theme.layoutDelegate.startSectionBuilder(state),
          // const PuzzleMenu(),
          const PuzzleBoard(),
          theme.layoutDelegate.endSectionBuilder(state),
        ],
      ),
      medium: (context, child) => Column(
        children: [
          theme.layoutDelegate.startSectionBuilder(state),
          const PuzzleBoard(),
          theme.layoutDelegate.endSectionBuilder(state),
        ],
      ),
      large: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: theme.layoutDelegate.startSectionBuilder(state),
          ),
          const PuzzleBoard(),
          Expanded(
            child: theme.layoutDelegate.endSectionBuilder(state),
          ),
        ],
      ),
    );
  }
}

/// {@template puzzle_board}
/// Displays the board of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleBoard extends StatelessWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();

    return PuzzleKeyboardHandler(
      child: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          final gameFinished = context.read<GameBloc>().state.isGameFinished();
          if (gameFinished) {
            context.read<GameBloc>().add(FinishedGameEvent());
          } else if (state.puzzleStatus == PuzzleStatus.complete &&
              !gameFinished) {
            context.read<GameBloc>().add(StageCompleteGameEvent());
          }
          if (theme.hasTimer && state.puzzleStatus == PuzzleStatus.complete) {
            context.read<TimerBloc>().add(const TimerStopped());
          }
        },
        builder: (context, state) {
          return theme.layoutDelegate.boardBuilder(
            size,
            state.puzzle.tiles
                .map(
                  (tile) => _PuzzleTile(
                    key: Key('puzzle_tile_${tile.value.toString()}'),
                    tile: tile,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return tile.isWhitespace
        ? theme.layoutDelegate.whitespaceTileBuilder()
        : theme.layoutDelegate.tileBuilder(tile, state);
  }
}

/// {@template puzzle_menu}
/// Displays the menu of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleMenu extends StatelessWidget {
  /// {@macro puzzle_menu}
  const PuzzleMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themes = context.select((ThemeBloc bloc) => bloc.state.themes);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          themes.length,
          (index) => PuzzleMenuItem(
            theme: themes[index],
            themeIndex: index,
          ),
        ),
      ],
    );
  }
}

/// {@template puzzle_menu_item}
/// Displays the menu item of the [PuzzleMenu].
/// {@endtemplate}
@visibleForTesting
class PuzzleMenuItem extends StatelessWidget {
  /// {@macro puzzle_menu_item}
  const PuzzleMenuItem({
    Key? key,
    required this.theme,
    required this.themeIndex,
  }) : super(key: key);

  /// The theme corresponding to this menu item.
  final PuzzleTheme theme;

  /// The index of [theme] in [ThemeState.themes].
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final isCurrentTheme = theme == currentTheme;

    return ResponsiveLayoutBuilder(
      small: (_, child) => Column(
        children: [
          Container(
            width: 100,
            height: 40,
            decoration: isCurrentTheme
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: currentTheme.menuUnderlineColor,
                      ),
                    ),
                  )
                : null,
            child: child,
          ),
        ],
      ),
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final leftPadding =
            themeIndex > 0 && currentSize != ResponsiveLayoutSize.small
                ? 40.0
                : 0.0;

        return Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Tooltip(
            message:
                theme != currentTheme ? context.l10n.puzzleChangeTooltip : '',
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                // Ignore if this theme is already selected.
                if (theme == currentTheme) {
                  return;
                }

                // Update the currently selected theme.
                context
                    .read<ThemeBloc>()
                    .add(ThemeChanged(themeIndex: themeIndex));

                // Reset the timer of the currently running puzzle.
                context.read<TimerBloc>().add(const TimerReset());

                // Stop the Dashatar countdown if it has been started.
                context.read<DashatarPuzzleBloc>().add(
                      const DashatarCountdownStopped(),
                    );

                // Initialize the puzzle board for the newly selected theme.
                context.read<PuzzleBloc>().add(
                      PuzzleInitialized(
                        shufflePuzzle: theme is SimpleTheme,
                      ),
                    );
              },
              child: AnimatedDefaultTextStyle(
                duration: PuzzleThemeAnimationDuration.textStyle,
                style: PuzzleTextStyle.headline5.copyWith(
                  color: isCurrentTheme
                      ? currentTheme.menuActiveColor
                      : currentTheme.menuInactiveColor,
                ),
                child: Text(theme.name),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The global key of [PuzzleLogo].
///
/// Used to animate the transition of [PuzzleLogo] when changing a theme.
final puzzleLogoKey = GlobalKey(debugLabel: 'puzzle_logo');

/// The global key of [PuzzleName].
///
/// Used to animate the transition of [PuzzleName] when changing a theme.
final puzzleNameKey = GlobalKey(debugLabel: 'puzzle_name');

/// The global key of [PuzzleTitle].
///
/// Used to animate the transition of [PuzzleTitle] when changing a theme.
final puzzleTitleKey = GlobalKey(debugLabel: 'puzzle_title');

/// The global key of [NumberOfMovesAndTilesLeft].
///
/// Used to animate the transition of [NumberOfMovesAndTilesLeft]
/// when changing a theme.
final numberOfMovesAndTilesLeftKey =
    GlobalKey(debugLabel: 'number_of_moves_and_tiles_left');
