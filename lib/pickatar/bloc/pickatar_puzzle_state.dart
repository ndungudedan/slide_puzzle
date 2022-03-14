// ignore_for_file: public_member_api_docs

part of 'pickatar_puzzle_bloc.dart';

/// The status of [PickatarPuzzleState].
enum PickatarPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started
}

class PickatarPuzzleState extends Equatable {
  const PickatarPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  PickatarPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? PickatarPuzzleStatus.loading
      : (secondsToBegin == 0
          ? PickatarPuzzleStatus.started
          : PickatarPuzzleStatus.notStarted);

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  PickatarPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) {
    return PickatarPuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
    );
  }
}
