import 'package:flutter/material.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Dispositivos'),
      ),
      body: const Center(
        child: Text(
          'A lista de dispositivos e o painel de controle aparecerão aqui.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}