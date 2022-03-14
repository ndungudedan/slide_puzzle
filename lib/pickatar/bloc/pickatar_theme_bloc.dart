import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/pickatar/pickatar.dart';
import 'package:very_good_slide_puzzle/pickatar/themes/green_pickatar_theme.dart';
import 'package:very_good_slide_puzzle/pickatar/themes/pickatar_theme.dart';

part 'pickatar_theme_event.dart';
part 'pickatar_theme_state.dart';

/// {@template dashatar_theme_bloc}
/// Bloc responsible for the currently selected [PickatarTheme].
/// {@endtemplate}
class PickatarThemeBloc extends Bloc<PickatarThemeEvent, PickatarThemeState> {
  /// {@macro dashatar_theme_bloc}
  PickatarThemeBloc({required List<PickatarTheme> themes})
      : super(PickatarThemeState(themes: themes)) {
    on<PickatarThemeChanged>(_onPickatarThemeChanged);
  }

  void _onPickatarThemeChanged(
    PickatarThemeChanged event,
    Emitter<PickatarThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
