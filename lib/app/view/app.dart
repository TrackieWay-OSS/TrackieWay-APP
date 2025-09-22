import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/app/view/nav_page.dart';
import 'package:trackie_app/core/theme/app_theme.dart';
import 'package:trackie_app/features/settings/domain/entities/app_settings.dart';
import 'package:trackie_app/features/settings/presentation/bloc/settings_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // É importante ter o BlocProvider envolvendo o MaterialApp
    // para que o estado esteja disponível em todo o app.
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, settings) {
          
          // Lógica de seleção de tema corrigida
          ThemeData lightTheme;
          ThemeData darkTheme;

          if (settings.isHighContrastMode) {
            lightTheme = AppTheme.highContrastLightTheme;
            darkTheme = AppTheme.highContrastDarkTheme;
          } else {
            lightTheme = AppTheme.lightTheme;
            darkTheme = AppTheme.darkTheme;
          }

          return MaterialApp(
            title: 'Trackie',
            debugShowCheckedModeBanner: false,
            
            // Temas são aplicados aqui
            theme: lightTheme,
            darkTheme: darkTheme,

            // A configuração de modo escuro do usuário é usada para determinar o tema
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            
            home: const NavPage(),
            
            // Aplica o fator de escala de texto dinamicamente
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(settings.textScaleFactor),
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