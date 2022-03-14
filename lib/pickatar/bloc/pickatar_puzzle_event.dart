// ignore_for_file: public_member_api_docs

part of 'pickatar_puzzle_bloc.dart';

abstract class PickatarPuzzleEvent extends Equatable {
  const PickatarPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class PickatarCountdownStarted extends PickatarPuzzleEvent {
  const PickatarCountdownStarted();
}

class PickatarCountdownTicked extends PickatarPuzzleEvent {
  const PickatarCountdownTicked();
}

class PickatarCountdownStopped extends PickatarPuzzleEvent {
  const PickatarCountdownStopped();
}

class PickatarCountdownReset extends PickatarPuzzleEvent {
  const PickatarCountdownReset({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [PickatarPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
