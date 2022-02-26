// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seletter/assets/alphabet.dart';
import 'package:seletter/assets/words.dart';
import 'package:seletter/main.dart';
import 'package:seletter/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, this._gameWords, {this.random})
      : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
    on<PuzzleNextStageEvent>(_onPuzzleNextStage);
  }

  final int _size;

  final Map<int, String> _gameWords;

  final Random? random;

  void _onPuzzleNextStage(
    PuzzleNextStageEvent event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(event.currentSize + 1);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
      ),
    );
  }

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(_size, shuffle: event.shufflePuzzle);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
      ),
    );
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        logger.wtf(
          '''
gameWords:$_gameWords 

±±±±±±±

 puzzle: $puzzle
''',
        );
        if (puzzle.isComplete(_gameWords)) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        } else {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
              previousSpace: state.puzzle.getWhitespaceTile(),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
      ),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Fills the first row with the only correct positions, since it will be the
    // word we want to accomplish
    // We disregard any other correct position, since they are irrelevant.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);

          if (y == 1) {
            correctPositions.add(position);
          }

          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile positions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable()) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final tiles = <Tile>[];
    for (var i = 1; i <= size * size; i++) {
      // If whitespace
      if (i == size * size) {
        final whitespace = Tile(
          value: i,
          currentPosition: currentPositions[i - 1],
          isWhitespace: true,
          letter: '',
        );
        tiles.add(whitespace);
      } else {
        if (i < size + 1) {
          assert(validWords[size] != null, 'Valid word cannot be "null"');
          assert(_gameWords[size] != null, 'There is always a word');
          final tile = Tile(
            value: i,
            currentPosition: currentPositions[i - 1],
            letter: _gameWords[size]?[i - 1] ?? '',
          );
          tiles.add(tile);
        } else {
          final tile = Tile(
            value: i,
            currentPosition: currentPositions[i - 1],
            letter: alphabet[Random().nextInt(alphabet.length)],
          );
          tiles.add(tile);
        }
      }
    }
    return tiles;
  }
}
