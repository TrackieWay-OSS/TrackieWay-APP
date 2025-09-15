import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/installer/domain/entities/component_entity.dart';
import 'package:trackie_app/features/installer/presentation/bloc/installer_cubit.dart';
import 'package:trackie_app/features/installer/presentation/bloc/installer_state.dart';
import 'package:trackie_app/features/installer/presentation/pages/accessibility_settings_page.dart';

class SetupHubPage extends StatelessWidget {
  const SetupHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InstallerCubit(),
      child: const SetupHubView(),
    );
  }
}

class SetupHubView extends StatelessWidget {
  const SetupHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trackie Installer'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.accessibility_new),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AccessibilitySettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<InstallerCubit, InstallerState>(
        builder: (context, state) {
          final areAllComponentsInstalled =
              state.components.every((c) => c.status == ComponentStatus.installed);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionTitle(context, 'Componentes Necessários'),
                const SizedBox(height: 12),
                if (!areAllComponentsInstalled)
                  _buildDownloadAllButton(context, state),
                if (state.isDownloadingAll)
                  _buildOverallProgress(context, state),
                Expanded(child: _buildComponentList(context, state.components)),
                const SizedBox(height: 16),
                _buildStartButton(context, areAllComponentsInstalled),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDownloadAllButton(BuildContext context, InstallerState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton.icon(
        onPressed: state.isDownloadingAll
            ? null
            : () => context.read<InstallerCubit>().downloadAllComponents(),
        icon: state.isDownloadingAll
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Icon(Icons.download),
        label: const Text('Baixar Todos'),
      ),
    );
  }

  Widget _buildOverallProgress(BuildContext context, InstallerState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text('Progresso Geral', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: state.overallProgress,
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentList(
      BuildContext context, List<DownloadableComponent> components) {
    return ListView.separated(
      itemCount: components.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final component = components[index];
        return _buildComponentTile(context, component);
      },
    );
  }

  Widget _buildComponentTile(
      BuildContext context, DownloadableComponent component) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(component.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle:
                  Text('${component.description}\nTamanho: ${component.size}'),
              trailing: _buildTrailingWidget(context, component),
              isThreeLine: true,
            ),
            if (component.status == ComponentStatus.downloading)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: component.downloadProgress),
                    const SizedBox(height: 4),
                    Text('${(component.downloadProgress * 100).toInt()}%'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailingWidget(
      BuildContext context, DownloadableComponent component) {
    final cubit = context.read<InstallerCubit>();
    final isDownloadingAll = cubit.state.isDownloadingAll;

    switch (component.status) {
      case ComponentStatus.notInstalled:
        return ElevatedButton(
          onPressed: isDownloadingAll
              ? null
              : () => cubit.downloadComponent(component),
          child: const Text('Baixar'),
        );
      case ComponentStatus.downloading:
        return SizedBox(
          width: 90,
          child: Center(
            child: Text(
              'Baixando...',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        );
      case ComponentStatus.installed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 32);
      case ComponentStatus.error:
        return Tooltip(
          message: 'Tentar Novamente',
          child: IconButton(
            icon: const Icon(Icons.error, color: Colors.red, size: 32),
            onPressed: isDownloadingAll
                ? null
                : () => cubit.downloadComponent(component),
          ),
        );
    }
  }

  Widget _buildStartButton(BuildContext context, bool areAllComponentsInstalled) {
    return ElevatedButton.icon(
      onPressed: areAllComponentsInstalled ? () {} : null,
      icon: const Icon(Icons.rocket_launch),
      label: const Text('Iniciar Assistente'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

