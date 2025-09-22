import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  const AppSettings({
    this.isDarkMode = false,
    this.speechRate = 1.0,
    this.isHapticFeedbackEnabled = true,
    this.isHighContrastMode = false,
    this.textScaleFactor = 1.0,
    this.isShakeToStartEnabled = true,
  });

  final bool isDarkMode;
  final double speechRate;
  final bool isHapticFeedbackEnabled;
  final bool isHighContrastMode;
  final double textScaleFactor;
  final bool isShakeToStartEnabled;

  AppSettings copyWith({
    bool? isDarkMode,
    double? speechRate,
    bool? isHapticFeedbackEnabled,
    bool? isHighContrastMode,
    double? textScaleFactor,
    bool? isShakeToStartEnabled,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      speechRate: speechRate ?? this.speechRate,
      isHapticFeedbackEnabled:
          isHapticFeedbackEnabled ?? this.isHapticFeedbackEnabled,
      isHighContrastMode: isHighContrastMode ?? this.isHighContrastMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      isShakeToStartEnabled:
          isShakeToStartEnabled ?? this.isShakeToStartEnabled,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
        speechRate,
        isHapticFeedbackEnabled,
        isHighContrastMode,
        textScaleFactor,
        isShakeToStartEnabled,
      ];
}