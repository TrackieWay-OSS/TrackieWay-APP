import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/settings/domain/entities/app_settings.dart';
import 'package:trackie_app/features/settings/presentation/bloc/settings_cubit.dart';

class AccessibilitySettingsPage extends StatelessWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, AppSettings>(
      builder: (context, settings) {
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
                context: context,
                title: 'Ativar por Voz ("Ok Trackie")',
                subtitle: 'Inicie o assistente com um comando de voz.',
                value: settings.wakeWordEnabled,
                onChanged: (newValue) =>
                    context.read<SettingsCubit>().setWakeWord(newValue),
                icon: Icons.mic_none,
              ),
              _buildSwitchTile(
                context: context,
                title: 'Agitar para Iniciar',
                subtitle: 'Sacuda o aparelho para ativar o assistente.',
                value: settings.shakeToStartEnabled,
                onChanged: (newValue) =>
                    context.read<SettingsCubit>().setShakeToStart(newValue),
                icon: Icons.vibration,
              ),
              _buildSwitchTile(
                context: context,
                title: 'Notificação Persistente',
                subtitle: 'Acesso rápido na barra de notificações.',
                value: settings.persistentNotificationEnabled,
                onChanged: (newValue) => context
                    .read<SettingsCubit>()
                    .setPersistentNotification(newValue),
                icon: Icons.notifications_active_outlined,
              ),
              const Divider(height: 32),
              _buildSectionTitle(context, 'Feedback de Áudio'),
              _buildSelectorTile(
                context: context,
                title: 'Nível de Detalhe da Fala',
                currentValue: settings.verbosityLevel,
                onTap: () {
                  _showSelectionDialog(
                    context: context,
                    title: 'Selecione o Nível de Detalhe',
                    options: ['Baixo', 'Médio', 'Alto'],
                    currentSelection: settings.verbosityLevel,
                    onSelected: (newValue) => context
                        .read<SettingsCubit>()
                        .setVerbosityLevel(newValue),
                  );
                },
              ),
              _buildSwitchTile(
                context: context,
                title: 'Áudio Espacial (3D)',
                subtitle: 'Sons e alertas virão da direção do objeto.',
                value: settings.spatialAudioEnabled,
                onChanged: (newValue) =>
                    context.read<SettingsCubit>().setSpatialAudio(newValue),
                icon: Icons.spatial_audio_off_outlined,
              ),
              _buildSwitchTile(
                context: context,
                title: 'Ícones Sonoros (Earcons)',
                subtitle: 'Use sons sutis para eventos comuns.',
                value: settings.earconsEnabled,
                onChanged: (newValue) =>
                    context.read<SettingsCubit>().setEarcons(newValue),
                icon: Icons.music_note_outlined,
              ),
              const Divider(height: 32),
              _buildSectionTitle(context, 'Feedback Tátil'),
              _buildSwitchTile(
                context: context,
                title: 'Padrões de Vibração',
                subtitle: 'Use vibrações distintas para alertas.',
                value: settings.hapticPatternsEnabled,
                onChanged: (newValue) =>
                    context.read<SettingsCubit>().setHapticPatterns(newValue),
                icon: Icons.waves_outlined,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSelectionDialog({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String currentSelection,
    required ValueChanged<String> onSelected,
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
    required BuildContext context,
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

