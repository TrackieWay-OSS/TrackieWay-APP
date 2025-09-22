import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/settings/domain/entities/app_settings.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit() : super(const AppSettings());

  void setWakeWord(bool isEnabled) =>
      emit(state.copyWith(wakeWordEnabled: isEnabled));
  void setShakeToStart(bool isEnabled) =>
      emit(state.copyWith(shakeToStartEnabled: isEnabled));
  void setPersistentNotification(bool isEnabled) =>
      emit(state.copyWith(persistentNotificationEnabled: isEnabled));
  void setVerbosityLevel(String level) =>
      emit(state.copyWith(verbosityLevel: level));
  void setSpatialAudio(bool isEnabled) =>
      emit(state.copyWith(spatialAudioEnabled: isEnabled));
  void setEarcons(bool isEnabled) => emit(state.copyWith(earconsEnabled: isEnabled));
  void setHapticPatterns(bool isEnabled) =>
      emit(state.copyWith(hapticPatternsEnabled: isEnabled));
}
