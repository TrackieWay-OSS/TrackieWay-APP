import 'package:flutter/material.dart';

class AccessibilitySettingsPage extends StatefulWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  State<AccessibilitySettingsPage> createState() =>
      _AccessibilitySettingsPageState();
}

class _AccessibilitySettingsPageState extends State<AccessibilitySettingsPage> {
  // Estado das configurações
  bool _wakeWordEnabled = true;
  bool _shakeToStartEnabled = false;
  bool _persistentNotificationEnabled = true;

  String _verbosityLevel = 'Médio';
  final List<String> _verbosityOptions = ['Baixo', 'Médio', 'Alto'];

  bool _spatialAudioEnabled = true;
  bool _earconsEnabled = false;

  bool _hapticPatternsEnabled = true;

  void _showSelectionDialog<T>({
    required BuildContext context,
    required String title,
    required List<T> options,
    required T currentSelection,
    required ValueChanged<T> onSelected,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title),
          children: options.map((option) {
            return SimpleDialogOption(
              onPressed: () {
                onSelected(option);
                Navigator.of(context).pop();
              },
              child: Text(option.toString()),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes de Acessibilidade'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle(context, 'Ativação e Comandos'),
          _buildSwitchTile(
            title: 'Ativar por Voz ("Ok Trackie")',
            subtitle: 'Inicie o assistente com um comando de voz.',
            value: _wakeWordEnabled,
            onChanged: (newValue) => setState(() => _wakeWordEnabled = newValue),
            icon: Icons.mic_none,
          ),
          _buildSwitchTile(
            title: 'Agitar para Iniciar',
            subtitle: 'Sacuda o aparelho para ativar o assistente.',
            value: _shakeToStartEnabled,
            onChanged: (newValue) => setState(() => _shakeToStartEnabled = newValue),
            icon: Icons.vibration,
          ),
          _buildSwitchTile(
            title: 'Notificação Persistente',
            subtitle: 'Acesso rápido na barra de notificações.',
            value: _persistentNotificationEnabled,
            onChanged: (newValue) => setState(() => _persistentNotificationEnabled = newValue),
            icon: Icons.notifications_active_outlined,
          ),
          const Divider(height: 32),
          _buildSectionTitle(context, 'Feedback de Áudio'),
          _buildSelectorTile(
            context: context,
            title: 'Nível de Detalhe da Fala',
            currentValue: _verbosityLevel,
            onTap: () {
              _showSelectionDialog(
                context: context,
                title: 'Selecione o Nível de Detalhe',
                options: _verbosityOptions,
                currentSelection: _verbosityLevel,
                onSelected: (newValue) => setState(() => _verbosityLevel = newValue),
              );
            },
          ),
          _buildSwitchTile(
            title: 'Áudio Espacial (3D)',
            subtitle: 'Sons e alertas virão da direção do objeto.',
            value: _spatialAudioEnabled,
            onChanged: (newValue) => setState(() => _spatialAudioEnabled = newValue),
            icon: Icons.spatial_audio_off_outlined,
          ),
          _buildSwitchTile(
            title: 'Ícones Sonoros (Earcons)',
            subtitle: 'Use sons sutis para eventos comuns.',
            value: _earconsEnabled,
            onChanged: (newValue) => setState(() => _earconsEnabled = newValue),
            icon: Icons.music_note_outlined,
          ),
          const Divider(height: 32),
          _buildSectionTitle(context, 'Feedback Tátil'),
          _buildSwitchTile(
            title: 'Padrões de Vibração',
            subtitle: 'Use vibrações distintas para alertas.',
            value: _hapticPatternsEnabled,
            onChanged: (newValue) => setState(() => _hapticPatternsEnabled = newValue),
            icon: Icons.waves_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSelectorTile({
    required BuildContext context,
    required String title,
    required String currentValue,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(currentValue),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon),
      ),
    );
  }
}

