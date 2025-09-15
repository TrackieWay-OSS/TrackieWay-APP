import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool wakeWordEnabled;
  final bool shakeToStartEnabled;
  final bool persistentNotificationEnabled;
  final String verbosityLevel;
  final bool spatialAudioEnabled;
  final bool earconsEnabled;
  final bool hapticPatternsEnabled;

  const AppSettings({
    this.wakeWordEnabled = true,
    this.shakeToStartEnabled = false,
    this.persistentNotificationEnabled = true,
    this.verbosityLevel = 'Médio',
    this.spatialAudioEnabled = true,
    this.earconsEnabled = false,
    this.hapticPatternsEnabled = true,
  });

  AppSettings copyWith({
    bool? wakeWordEnabled,
    bool? shakeToStartEnabled,
    bool? persistentNotificationEnabled,
    String? verbosityLevel,
    bool? spatialAudioEnabled,
    bool? earconsEnabled,
    bool? hapticPatternsEnabled,
  }) {
    return AppSettings(
      wakeWordEnabled: wakeWordEnabled ?? this.wakeWordEnabled,
      shakeToStartEnabled: shakeToStartEnabled ?? this.shakeToStartEnabled,
      persistentNotificationEnabled:
          persistentNotificationEnabled ?? this.persistentNotificationEnabled,
      verbosityLevel: verbosityLevel ?? this.verbosityLevel,
      spatialAudioEnabled: spatialAudioEnabled ?? this.spatialAudioEnabled,
      earconsEnabled: earconsEnabled ?? this.earconsEnabled,
      hapticPatternsEnabled:
          hapticPatternsEnabled ?? this.hapticPatternsEnabled,
    );
  }

  @override
  List<Object?> get props => [
        wakeWordEnabled,
        shakeToStartEnabled,
        persistentNotificationEnabled,
        verbosityLevel,
        spatialAudioEnabled,
        earconsEnabled,
        hapticPatternsEnabled,
      ];
}
