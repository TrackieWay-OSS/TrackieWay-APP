import 'package:flutter/material.dart';

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistente Trackie'),
      ),
      body: const Center(
        child: Text(
          'A interface da câmera aparecerá aqui.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}