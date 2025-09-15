import 'package:flutter/material.dart';

class AccessibilitySettingsPage extends StatefulWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  State<AccessibilitySettingsPage> createState() =>
      _AccessibilitySettingsPageState();
}

class _AccessibilitySettingsPageState extends State<AccessibilitySettingsPage> {
  double _speechRate = 0.5;
  double _pitch = 1.0;
  bool _hapticFeedback = true;
  String _selectedVoice = 'Voz Padrão (Feminina)';

  final List<String> _availableVoices = [
    'Voz Padrão (Feminina)',
    'Voz Padrão (Masculina)',
    'Voz Expressiva (Feminina)',
    'Voz Calma (Masculina)',
  ];

  void _playTestSound() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Testando voz com velocidade ${_speechRate.toStringAsFixed(1)} e tom ${_pitch.toStringAsFixed(1)}.',
        ),
        duration: const Duration(seconds: 2),
      ),
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
          _buildSectionTitle(context, 'Configurações de Voz'),
          const SizedBox(height: 8),
          _buildSliderTile(
            label: 'Velocidade da Fala',
            value: _speechRate,
            onChanged: (newValue) {
              setState(() => _speechRate = newValue);
            },
            min: 0.1,
            max: 1.0,
            divisions: 9,
          ),
          _buildSliderTile(
            label: 'Tom da Voz',
            value: _pitch,
            onChanged: (newValue) {
              setState(() => _pitch = newValue);
            },
            min: 0.5,
            max: 2.0,
            divisions: 15,
          ),
          _buildVoiceSelectorTile(context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton.icon(
              onPressed: _playTestSound,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Testar Voz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const Divider(height: 48),
          _buildSectionTitle(context, 'Feedback Tátil'),
          const SizedBox(height: 8),
          _buildSwitchTile(
            title: 'Vibração',
            subtitle: 'Ativar resposta tátil para alertas.',
            value: _hapticFeedback,
            onChanged: (newValue) {
              setState(() => _hapticFeedback = newValue);
            },
          ),
        ],
      ),
    );
  }

  void _showVoiceSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Selecione uma Voz'),
          children: _availableVoices.map((voice) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _selectedVoice = voice;
                });
                Navigator.of(context).pop();
              },
              child: Text(voice),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSliderTile({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required double min,
    required double max,
    required int divisions,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: value,
              onChanged: onChanged,
              min: min,
              max: max,
              divisions: divisions,
              label: (value).toStringAsFixed(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceSelectorTile(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Voz do Assistente',
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(_selectedVoice),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: () {
          _showVoiceSelectionDialog(context);
        },
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        secondary:
            Icon(value ? Icons.vibration : Icons.smartphone_sharp),
      ),
    );
  }
}