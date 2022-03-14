import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'pickatar_puzzle_event.dart';
part 'pickatar_puzzle_state.dart';

/// {@template dashatar_puzzle_bloc}
/// A bloc responsible for starting the Pickatar puzzle.
/// {@endtemplate}
class PickatarPuzzleBloc
    extends Bloc<PickatarPuzzleEvent, PickatarPuzzleState> {
  /// {@macro dashatar_puzzle_bloc}
  PickatarPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(PickatarPuzzleState(secondsToBegin: secondsToBegin)) {
    on<PickatarCountdownStarted>(_onCountdownStarted);
    on<PickatarCountdownTicked>(_onCountdownTicked);
    on<PickatarCountdownStopped>(_onCountdownStopped);
    on<PickatarCountdownReset>(_onCountdownReset);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const PickatarCountdownTicked()));
  }

  void _onCountdownStarted(
    PickatarCountdownStarted event,
    Emitter<PickatarPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    PickatarCountdownTicked event,
    Emitter<PickatarPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    PickatarCountdownStopped event,
    Emitter<PickatarPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    PickatarCountdownReset event,
    Emitter<PickatarPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }
}
