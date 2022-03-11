// ignore_for_file: public_member_api_docs

part of 'pickatar_theme_bloc.dart';

abstract class PickatarThemeEvent extends Equatable {
  const PickatarThemeEvent();
}

class PickatarThemeChanged extends PickatarThemeEvent {
  const PickatarThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [PickatarThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
