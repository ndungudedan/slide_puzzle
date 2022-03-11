// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(
    this._size, {
    this.random,
  }) : super(PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
  }

  final int _size;
  final Random? random;

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(_size, shuffle: event.shufflePuzzle);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        numberOfMoves:
            puzzle.tiles.where((element) => element.isCheekyBird).length + 2,
      ),
    );
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileCheekyBird(tappedTile) &&
          !state.selectedCheekyBirds.contains(tappedTile)) {
        print('tappping cheeky');
        final puzzle = Puzzle(tiles: [...state.puzzle.tiles]);
        List<Tile> newCheekies = [];
        state.selectedCheekyBirds.forEach((element) {
          newCheekies.add(element);
        });
        newCheekies.add(tappedTile);
        if (puzzle.foundAllCheekyBirds(newCheekies)) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: newCheekies.length,
              numberOfMoves: state.numberOfMoves - 1,
              lastTappedTile: tappedTile,
              selectedCheekyBirds: newCheekies,
            ),
          );
        } else {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: newCheekies.length,
              numberOfMoves: state.numberOfMoves - 1,
              lastTappedTile: tappedTile,
              selectedCheekyBirds: newCheekies,
            ),
          );
        }
      } else {
        print('nt a cheeky');
        emit(
          state.copyWith(
            puzzle: Puzzle(tiles: [...state.puzzle.tiles]).sort(),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: state.selectedCheekyBirds.length,
            numberOfMoves: state.numberOfMoves - 1,
            lastTappedTile: tappedTile,
            selectedCheekyBirds: state.selectedCheekyBirds,
          ),
        );
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }

    if (state.numberOfMoves == 0) {
      emit(
        state.copyWith(
          puzzle: Puzzle(tiles: [...state.puzzle.tiles]).sort(),
          puzzleStatus: PuzzleStatus.complete,
          tileMovementStatus: TileMovementStatus.cannotBeMoved,
          numberOfCorrectTiles: state.selectedCheekyBirds.length,
          numberOfMoves: state.numberOfMoves,
          lastTappedTile: tappedTile,
          selectedCheekyBirds: state.selectedCheekyBirds,
        ),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        numberOfMoves:
            puzzle.tiles.where((element) => element.isCheekyBird).length + 2,
      ),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile posistions.
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
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
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
    final whitespacePosition = Position(x: size, y: size);
    currentPositions.shuffle();
    return [
      for (int i = 1; i <= size * size; i++)
        if (i % 4 == 0)
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
            isCheekyBird: true,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }
}
