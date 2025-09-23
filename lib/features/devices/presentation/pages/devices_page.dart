import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:trackie_app/features/devices/presentation/bloc/devices_cubit.dart';
import 'package:trackie_app/features/devices/presentation/bloc/devices_state.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos'),
        centerTitle: true,
      ),
      body: BlocConsumer<DevicesCubit, DevicesState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.connectionStatus == DeviceStatus.connected && state.connectedDevice != null) {
            return _buildConnectedView(context, state.connectedDevice!);
          } else {
            return _buildScanningView(context, state);
          }
        },
      ),
    );
  }

  // --- Widgets de Construção da UI ---

  Widget _buildConnectedView(BuildContext context, BluetoothDevice device) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.bluetooth_connected,
              size: 100, color: Colors.green.shade600),
          const SizedBox(height: 24),
          Text(
            'Conectado a:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            device.platformName.isNotEmpty ? device.platformName : 'Dispositivo Desconhecido',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            icon: const Icon(Icons.link_off),
            label: const Text('Desconectar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              context.read<DevicesCubit>().disconnect();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScanningView(BuildContext context, DevicesState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: state.isScanning
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                      )
                    : const Icon(Icons.search),
                label: Text(state.isScanning
                    ? 'Procurando...'
                    : 'Procurar Dispositivos'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: state.isScanning
                    ? null
                    : () => context.read<DevicesCubit>().startScan(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        if (state.isScanning && state.scanResults.isEmpty)
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Procurando por dispositivos próximos...'),
                ],
              ),
            ),
          )
        else if (!state.isScanning && state.scanResults.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                'Nenhum dispositivo encontrado.\nClique em "Procurar" para iniciar.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              itemCount: state.scanResults.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final result = state.scanResults[index];
                return _buildDeviceTile(context, result.device);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildDeviceTile(BuildContext context, BluetoothDevice device) {
    return ListTile(
      leading: const Icon(Icons.bluetooth, size: 30),
      title: Text(device.platformName.isNotEmpty ? device.platformName : 'Dispositivo Desconhecido'),
      subtitle: Text(device.remoteId.toString()),
      trailing: ElevatedButton(
        child: const Text('Conectar'),
        onPressed: () => context.read<DevicesCubit>().connectToDevice(device),
      ),
    );
  }
}

