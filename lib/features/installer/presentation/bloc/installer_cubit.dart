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

  Future<void> downloadComponent(DownloadableComponent component) async {
    final components = List<DownloadableComponent>.from(state.components);
    final componentIndex =
        components.indexWhere((c) => c.title == component.title);
    if (componentIndex == -1) return;

    components[componentIndex].status = ComponentStatus.downloading;
    components[componentIndex].downloadProgress = 0.0;
    _emitLoadingState();

    try {
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 300));

        if (component.title.contains('TrackieAssets') && i > 5) {
          throw Exception('Simulated network error');
        }
        
        components[componentIndex].downloadProgress = i / 10.0;
        _emitLoadingState();
      }
      components[componentIndex].status = ComponentStatus.installed;
    } catch (e) {
      components[componentIndex].status = ComponentStatus.error;
    } finally {
      _emitLoadingState();
    }
  }

  Future<void> downloadAllComponents() async {
    final componentsToDownload = state.components
        .where((c) => c.status != ComponentStatus.installed)
        .toList();
    if (componentsToDownload.isEmpty) return;
    
    emit(InstallerLoading(
        components: state.components,
        isDownloadingAll: true,
        overallProgress: 0.0));

    int completed = 0;
    final total = componentsToDownload.length;

    for (final component in componentsToDownload) {
      await downloadComponent(component);
       if (state.components.any((c) => c.status == ComponentStatus.error)) {
        break; 
      }
      completed++;
      emit(InstallerLoading(
          components: state.components,
          isDownloadingAll: true,
          overallProgress: completed / total));
    }
    
    emit(InstallerLoading(
        components: state.components,
        isDownloadingAll: false,
        overallProgress: state.overallProgress));
  }

  void _emitLoadingState() {
    emit(InstallerLoading(
      components: state.components,
      isDownloadingAll: state.isDownloadingAll,
      overallProgress: state.overallProgress,
    ));
  }
}
