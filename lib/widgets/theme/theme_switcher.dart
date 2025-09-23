import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/theme/theme_cubit.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      builder: (context, state) {
        final themeMode = (state is ThemeUpdated)
            ? state.themeMode
            : ThemeMode.system;

        return Switch(
          value: themeMode == ThemeMode.dark,
          onChanged: (value) {
            final newMode = value ? ThemeMode.dark : ThemeMode.light;
            context.read<ThemeCubit>().setTheme(newMode);
          },
        );
      },
    );
  }
}
