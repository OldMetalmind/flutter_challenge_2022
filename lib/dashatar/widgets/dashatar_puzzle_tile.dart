import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seletter/dashatar/dashatar.dart';
import 'package:seletter/l10n/l10n.dart';
import 'package:seletter/layout/layout.dart';
import 'package:seletter/models/models.dart';
import 'package:seletter/puzzle/puzzle.dart';
import 'package:seletter/theme/themes/themes.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 100;
  static double large = 112;
}

/// {@template dashatar_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class DashatarPuzzleTile extends StatefulWidget {
  /// {@macro dashatar_puzzle_tile}
  const DashatarPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  State<DashatarPuzzleTile> createState() => DashatarPuzzleTileState();
}

/// The state of [DashatarPuzzleTile].
@visibleForTesting
class DashatarPuzzleTileState extends State<DashatarPuzzleTile>
    with SingleTickerProviderStateMixin {
  late final Timer _timer;

  /// The controller that drives [_scale] animation.
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);
    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == DashatarPuzzleStatus.started;
    final puzzleIncomplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;

    final movementDuration = status == DashatarPuzzleStatus.loading
        ? const Duration(milliseconds: 800)
        : const Duration(milliseconds: 370);

    final canPress = hasStarted && puzzleIncomplete;

    return AnimatedAlign(
      alignment: FractionalOffset(
        (widget.tile.currentPosition.x - 1) / (size - 1),
        (widget.tile.currentPosition.y - 1) / (size - 1),
      ),
      duration: movementDuration,
      curve: Curves.easeInOut,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: Key('dashatar_puzzle_tile_small_${widget.tile.value}'),
          dimension: _TileSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: Key('dashatar_puzzle_tile_medium_${widget.tile.value}'),
          dimension: _TileSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: Key('dashatar_puzzle_tile_large_${widget.tile.value}'),
          dimension: _TileSize.large,
          child: child,
        ),
        child: (_) => MouseRegion(
          onEnter: (_) {
            if (canPress) {
              _controller.forward();
            }
          },
          onExit: (_) {
            if (canPress) {
              _controller.reverse();
            }
          },
          child: ScaleTransition(
            key: Key('dashatar_puzzle_tile_scale_${widget.tile.value}'),
            scale: _scale,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: canPress
                  ? () {
                      context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                    }
                  : null,
              icon: Image.asset(
                theme.dashAssetForTile(widget.tile),
                semanticLabel: context.l10n.puzzleTileLabelText(
                  widget.tile.value.toString(),
                  widget.tile.currentPosition.x.toString(),
                  widget.tile.currentPosition.y.toString(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
