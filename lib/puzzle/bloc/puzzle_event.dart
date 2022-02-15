// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized({required this.shufflePuzzle});

  final bool shufflePuzzle;

  @override
  List<Object> get props => [shufflePuzzle];
}

class TileTapped extends PuzzleEvent {
  const TileTapped(
    this.tile,
  );

  final Tile tile;

  @override
  List<Object> get props => [
        tile,
      ];
}

class PuzzleNextStage extends PuzzleEvent {
  const PuzzleNextStage(this.size);

  final int size;

  @override
  List<Object> get props => [size];
}

class PuzzleReset extends PuzzleEvent {
  const PuzzleReset();
}
