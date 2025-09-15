import 'package:flutter/material.dart';
import 'package:trackie_app/features/installer/presentation/pages/accessibility_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.accessibility_new),
              title: const Text('Ajustes de Acessibilidade'),
              subtitle: const Text('Configure a voz e o feedback tátil'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AccessibilitySettingsPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre o Trackie'),
              subtitle: const Text('Versão 1.0.0'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegação para a tela "Sobre" (a ser criada no futuro)
              },
            ),
          ),
        ],
      ),
    );
  }
}
