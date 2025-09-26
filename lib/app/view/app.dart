import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/app/view/nav_page.dart';
import 'package:trackie_app/core/theme/app_theme.dart';
import 'package:trackie_app/features/settings/presentation/bloc/settings_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, dynamic>(
        builder: (context, state) {
          // Determina qual tema usar com base no estado
          final bool useHighContrast = state.isHighContrastMode;
          final bool isDarkMode = state.isDarkMode;
          
          ThemeData theme;
          if (useHighContrast) {
            theme = isDarkMode 
                ? AppTheme.highContrastDarkTheme 
                : AppTheme.highContrastLightTheme;
          } else {
            theme = isDarkMode 
                ? AppTheme.darkTheme 
                : AppTheme.lightTheme;
          }

          return MaterialApp(
            theme: theme,
            home: const NavPage(),
            // Aplica o fator de escala de texto
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(state.textScaleFactor),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}