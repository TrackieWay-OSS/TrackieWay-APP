import 'package:flutter/material.dart';
import 'package:trackie_app/features/settings/presentation/pages/about_page.dart';
import 'package:trackie_app/features/settings/presentation/pages/accessibility_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings_accessibility),
            title: const Text('Acessibilidade'),
            onTap: () {
              // Navega para a nova página de Acessibilidade
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccessibilityPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}