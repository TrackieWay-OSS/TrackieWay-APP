import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: const Center(
        child: Text(
          'As configurações de acessibilidade e do app aparecerão aqui.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}