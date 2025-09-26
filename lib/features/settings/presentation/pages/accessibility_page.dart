import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:app_settings/app_settings.dart' as device_settings;
import 'package:trackie_app/features/settings/domain/entities/app_settings.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acessibilidade'),
      ),
      body: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, state) {
          final settingsCubit = context.read<SettingsCubit>();
          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              _buildSectionTitle(context, 'Ativação Rápida'),
              _buildShakeToStartSwitch(context, state, settingsCubit),
              const Divider(),
              _buildSectionTitle(context, 'Leitura de Tela'),
              Semantics(
                button: true,
                label: 'Abrir configurações do leitor de tela',
                hint:
                    'Ajuste o TalkBack (Android) ou VoiceOver (iOS) no seu dispositivo.',
                child: ListTile(
                  title: const Text('Abrir configurações do leitor de tela'),
                  subtitle: const Text(
                      'Ajuste o TalkBack ou VoiceOver no seu dispositivo.'),
                  leading: const Icon(Icons.record_voice_over),
                  onTap: () => device_settings.AppSettings.openAppSettings(
                    type: device_settings.AppSettingsType.accessibility,
                  ),
                ),
              ),
              const Divider(),
              _buildSectionTitle(context, 'Voz do Assistente'),
              _buildSpeechRateSlider(context, state, settingsCubit),
              const Divider(),
              _buildSectionTitle(context, 'Interação'),
              _buildHapticFeedbackSwitch(context, state, settingsCubit),
              const Divider(),
              _buildSectionTitle(context, 'Visual'),
              _buildHighContrastSwitch(context, state, settingsCubit),
              _buildFontSizeSlider(context, state, settingsCubit),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildShakeToStartSwitch(
      BuildContext context, AppSettings state, SettingsCubit cubit) {
    return SwitchListTile(
      title: const Text('Agitar para Iniciar'),
      subtitle: const Text('Sacuda o celular para ativar o assistente.'),
      value: state.isShakeToStartEnabled,
      onChanged: (_) => cubit.toggleShakeToStart(),
      secondary: const Icon(Icons.vibration),
    );
  }

  Widget _buildSpeechRateSlider(
      BuildContext context, AppSettings state, SettingsCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Velocidade da fala'),
          subtitle: Text('Ajuste a velocidade da voz do assistente.'),
        ),
        Semantics(
          label: 'Controle deslizante para a velocidade da fala',
          value:
              '${(state.speechRate * 100).toStringAsFixed(0)} por cento',
          child: Slider(
            value: state.speechRate,
            min: 0.5,
            max: 2.0,
            divisions: 6,
            label: '${(state.speechRate * 100).toStringAsFixed(0)}%',
            onChanged: (value) => cubit.updateSpeechRate(value),
          ),
        ),
      ],
    );
  }

  Widget _buildHapticFeedbackSwitch(
      BuildContext context, AppSettings state, SettingsCubit cubit) {
    return SwitchListTile(
      title: const Text('Retorno tátil'),
      subtitle: const Text('Vibrar ao tocar em botões e controles.'),
      value: state.isHapticFeedbackEnabled,
      onChanged: (_) => cubit.toggleHapticFeedback(),
      secondary: const Icon(Icons.vibration),
    );
  }

  Widget _buildHighContrastSwitch(
      BuildContext context, AppSettings state, SettingsCubit cubit) {
    return SwitchListTile(
      title: const Text('Modo de alto contraste'),
      subtitle: const Text('Aumenta o contraste das cores para melhor leitura.'),
      value: state.isHighContrastMode,
      onChanged: (_) => cubit.toggleHighContrastMode(),
      secondary: const Icon(Icons.contrast),
    );
  }

  Widget _buildFontSizeSlider(
      BuildContext context, AppSettings state, SettingsCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Tamanho da fonte'),
          subtitle: Text('Aumente o tamanho do texto em todo o aplicativo.'),
        ),
        Semantics(
          label: 'Controle deslizante para o tamanho da fonte',
          value:
              '${(state.textScaleFactor * 100).toStringAsFixed(0)} por cento',
          child: Slider(
            value: state.textScaleFactor,
            min: 0.8,
            max: 2.0,
            divisions: 6,
            label: '${(state.textScaleFactor * 100).toStringAsFixed(0)}%',
            onChanged: (value) => cubit.updateTextScaleFactor(value),
          ),
        ),
      ],
    );
  }
}