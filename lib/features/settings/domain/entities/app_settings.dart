import 'package:equatable/equatable.dart';

/// Representa as configurações do aplicativo que podem ser ajustadas pelo usuário.
class AppSettings extends Equatable {
  const AppSettings({
    this.isDarkMode = false,
    this.speechRate = 1.0,
    this.isHapticFeedbackEnabled = true,
    this.isHighContrastMode = false,
    this.textScaleFactor = 1.0,
  });

  final bool isDarkMode;
  final double speechRate; // Velocidade da fala (0.5 = devagar, 1.0 = normal, 2.0 = rápido)
  final bool isHapticFeedbackEnabled; // Ativa/desativa a vibração
  final bool isHighContrastMode; // Ativa/desativa o modo de alto contraste
  final double textScaleFactor; // Fator de escala da fonte (1.0 = normal)

  AppSettings copyWith({
    bool? isDarkMode,
    double? speechRate,
    bool? isHapticFeedbackEnabled,
    bool? isHighContrastMode,
    double? textScaleFactor,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      speechRate: speechRate ?? this.speechRate,
      isHapticFeedbackEnabled:
          isHapticFeedbackEnabled ?? this.isHapticFeedbackEnabled,
      isHighContrastMode: isHighContrastMode ?? this.isHighContrastMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
        speechRate,
        isHapticFeedbackEnabled,
        isHighContrastMode,
        textScaleFactor,
      ];
}