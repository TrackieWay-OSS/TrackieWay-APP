import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/devices/domain/entities/device_entity.dart';
import 'package:trackie_app/features/devices/presentation/bloc/devices_cubit.dart';
import 'package:trackie_app/features/devices/presentation/bloc/devices_state.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DevicesCubit(),
      child: const DevicesView(),
    );
  }
}

class DevicesView extends StatelessWidget {
  const DevicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Dispositivos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConnectedDeviceCard(),
            const SizedBox(height: 24),
            _buildAvailableDevicesSection(),
            const SizedBox(height: 16),
            Expanded(child: _buildDeviceList()),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedDeviceCard() {
    return BlocBuilder<DevicesCubit, DevicesState>(
      buildWhen: (previous, current) =>
          previous.connectedDevice != current.connectedDevice,
      builder: (context, state) {
        final theme = Theme.of(context);
        final device = state.connectedDevice;
        final isConnected =
            device != null && device.status == DeviceStatus.connected;

        return Card(
          color: isConnected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceVariant,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      isConnected
                          ? Icons.bluetooth_connected
                          : Icons.bluetooth_disabled,
                      size: 40,
                      color: isConnected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isConnected
                                ? device!.name
                                : 'Nenhum Dispositivo Conectado',
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isConnected
                                ? 'Bateria: ${device!.batteryLevel}% | Firmware: ${device.firmwareVersion}'
                                : 'Procure por dispositivos para conectar.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isConnected) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () =>
                          context.read<DevicesCubit>().disconnectDevice(),
                      icon: const Icon(Icons.link_off),
                      label: const Text('Desconectar'),
                    ),
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvailableDevicesSection() {
    return BlocBuilder<DevicesCubit, DevicesState>(
      buildWhen: (previous, current) => previous.isScanning != current.isScanning,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dispositivos Próximos',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: state.isScanning
                  ? null
                  : () => context.read<DevicesCubit>().startScan(),
              child: state.isScanning
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Procurar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeviceList() {
    return BlocBuilder<DevicesCubit, DevicesState>(
      builder: (context, state) {
        if (state.isScanning) {
          return const Center(child: Text('Procurando...'));
        }

        if (state.foundDevices.isEmpty) {
          return const Center(child: Text('Nenhum dispositivo encontrado.'));
        }

        return ListView.builder(
          itemCount: state.foundDevices.length,
          itemBuilder: (context, index) {
            final device = state.foundDevices[index];
            return _buildDeviceTile(context, device);
          },
        );
      },
    );
  }

  Widget _buildDeviceTile(BuildContext context, DeviceEntity device) {
    final cubit = context.read<DevicesCubit>();
    final isConnectedToThisDevice = cubit.state.connectedDevice?.id == device.id;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: const Icon(Icons.headset_mic),
        title: Text(device.name),
        subtitle: Text('Sinal: ${device.rssi} dBm'),
        trailing: isConnectedToThisDevice
            ? const Chip(
                avatar: Icon(Icons.check_circle, color: Colors.green, size: 20),
                label: Text('Conectado'),
                padding: EdgeInsets.symmetric(horizontal: 8),
              )
            : ElevatedButton(
                onPressed: () => cubit.connectToDevice(device),
                child: const Text('Conectar'),
              ),
      ),
    );
  }
}

