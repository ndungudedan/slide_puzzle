// ignore_for_file: public_member_api_docs

part of 'pickatar_theme_bloc.dart';

class PickatarThemeState extends Equatable {
  const PickatarThemeState({
    required this.themes,
    this.theme = const BluePickatarTheme(),
  });

  /// The list of all available [PickatarTheme]s.
  final List<PickatarTheme> themes;

  /// Currently selected [PickatarTheme].
  final PickatarTheme theme;

  @override
  List<Object> get props => [themes, theme];

  PickatarThemeState copyWith({
    List<PickatarTheme>? themes,
    PickatarTheme? theme,
  }) {
    return PickatarThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
