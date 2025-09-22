
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Idealmente, esta informação viria do pubspec.yaml dinamicamente.
    const appVersion = '1.0.0 (Build 1)';
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Trackie'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                // Adicione o seu logo aqui se tiver um
                // Image.asset('assets/logo.png', height: 80),
                const SizedBox(height: 16),
                Text(
                  'Trackie',
                  style: theme.textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(appVersion),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nossa Missão',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Levar acessibilidade inteligente a ambientes educacionais, industriais e ao dia a dia por meio de IA de ponta e hardware acessível.',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Licenças de Código Aberto'),
                  subtitle: const Text('Componentes que tornam o Trackie possível'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showLicensePage(context: context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.policy_outlined),
                  title: const Text('Política de Privacidade'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Adicionar navegação para a política de privacidade
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
