part of 'theme_cubit.dart';

sealed class ThemeCubitState extends Equatable {
  final ThemeMode themeMode;
  const ThemeCubitState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

final class ThemeCubitInitial extends ThemeCubitState {
  const ThemeCubitInitial() : super(ThemeMode.system);
}

final class ThemeUpdated extends ThemeCubitState {
  const ThemeUpdated(super.themeMode);
}
