import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/settings/domain/entities/app_settings.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit() : super(const AppSettings());

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void updateSpeechRate(double rate) {
    emit(state.copyWith(speechRate: rate));
  }

  void toggleHapticFeedback() {
    emit(state.copyWith(isHapticFeedbackEnabled: !state.isHapticFeedbackEnabled));
  }

  void toggleHighContrastMode() {
    emit(state.copyWith(isHighContrastMode: !state.isHighContrastMode));
  }

  void updateTextScaleFactor(double factor) {
    emit(state.copyWith(textScaleFactor: factor));
  }

  void toggleShakeToStart() {
    emit(state.copyWith(isShakeToStartEnabled: !state.isShakeToStartEnabled));
  }
}