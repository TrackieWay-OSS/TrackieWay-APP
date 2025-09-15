import 'package:flutter/material.dart';
import 'package:trackie_app/core/theme/app_theme.dart';
import 'package:trackie_app/features/installer/presentation/pages/setup_hub_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SetupHubPage(),
    );
  }
}