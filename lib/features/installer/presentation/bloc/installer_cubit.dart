import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/installer/domain/entities/component_entity.dart';
import 'package:trackie_app/features/installer/presentation/bloc/installer_state.dart';

class InstallerCubit extends Cubit<InstallerState> {
  InstallerCubit()
      : super(InstallerInitial(components: _getInitialComponents()));

  static List<DownloadableComponent> _getInitialComponents() {
    return [
      DownloadableComponent(
        title: 'TrackieLLM Core',
        description: 'Motor de Inteligência Artificial e Raciocínio.',
        size: '1.2 GB',
      ),
      DownloadableComponent(
        title: 'TrackieAssets',
        description: 'Modelos de visão, vozes e sons do sistema.',
        size: '450 MB',
      ),
      DownloadableComponent(
        title: 'Pacote de Idioma (PT-BR)',
        description: 'Suporte completo para o Português do Brasil.',
        size: '80 MB',
      ),
    ];
  }

  Future<void> downloadComponentByTitle(String title) async {
    _updateComponentState(title, ComponentStatus.downloading, 0.0);

    // MUDANÇA: A velocidade do download agora é mais rápida.
    // Se o download estiver mais rápido, significa que este código está a ser executado.
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 150)); // Era 250ms
      _updateComponentState(title, ComponentStatus.downloading, i / 10.0);
    }

    _updateComponentState(title, ComponentStatus.installed, 1.0);
  }

  Future<void> downloadAllComponents() async {
    final componentsToDownload = state.components
        .where((c) =>
            c.status == ComponentStatus.notInstalled ||
            c.status == ComponentStatus.error)
        .toList();

    if (componentsToDownload.isEmpty) return;

    emit(state.copyWith(isDownloadingAll: true, overallProgress: 0.0));

    int completed = 0;
    final total = componentsToDownload.length;

    for (final component in componentsToDownload) {
      await downloadComponentByTitle(component.title);
      completed++;
      emit(state.copyWith(overallProgress: completed / total));
    }

    emit(state.copyWith(isDownloadingAll: false));
  }

  void _updateComponentState(
    String title,
    ComponentStatus status,
    double progress,
  ) {
    final components = List<DownloadableComponent>.from(state.components);
    final index = components.indexWhere((c) => c.title == title);

    if (index != -1) {
      final oldComponent = components[index];
      components[index] = oldComponent.copyWith(
        status: status,
        downloadProgress: progress,
      );
      emit(state.copyWith(components: components));
    }
  }
}


