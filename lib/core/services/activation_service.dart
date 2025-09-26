import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shake/shake.dart';
import 'package:trackie_app/features/settings/domain/entities/app_settings.dart';
import 'package:trackie_app/features/settings/presentation/bloc/settings_cubit.dart';

class ActivationService {
  final BuildContext _context;
  ShakeDetector? _shakeDetector;

  ActivationService(this._context) {
    _initialize();
  }

  void _initialize() {
    _context.read<SettingsCubit>().stream.listen(_handleSettingsChange);
    _handleSettingsChange(_context.read<SettingsCubit>().state);
  }

  void _handleSettingsChange(AppSettings settings) {
    if (settings.isShakeToStartEnabled && _shakeDetector == null) {
      _shakeDetector = ShakeDetector.autoStart(
        onPhoneShake: () {
          if (_context.read<SettingsCubit>().state.isShakeToStartEnabled) {
            debugPrint("Shake detectado! Ativando o assistente...");
            _triggerAssistant();
          }
        },
        shakeThresholdGravity: 1.7,
      );
      debugPrint("Serviço de Shake INICIADO.");
    } else if (!settings.isShakeToStartEnabled && _shakeDetector != null) {
      _shakeDetector?.stopListening();
      _shakeDetector = null;
      debugPrint("Serviço de Shake PARADO.");
    }
  }

  void _triggerAssistant() {
    if (_context.mounted) {
      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(
          content: Text('Assistente Trackie Ativado!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void dispose() {
    _shakeDetector?.stopListening();
    debugPrint("Serviço de ativação de Shake finalizado.");
  }
}