import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/features/devices/domain/entities/device_entity.dart';
import 'package:trackie_app/features/devices/presentation/bloc/devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  DevicesCubit() : super(const DevicesState());

  void startScan() async {
    emit(state.copyWith(isScanning: true, foundDevices: []));

    await Future.delayed(const Duration(seconds: 3));

    final mockDevices = [
      DeviceEntity(
        name: 'Trackie SpotWay',
        id: 'AB:12:CD:34:EF:56',
        rssi: -55,
        batteryLevel: 92,
        firmwareVersion: 'v1.1.0',
      ),
      DeviceEntity(
        name: 'Trackie RaspWay',
        id: 'FF:A1:B2:C3:D4:E5',
        rssi: -78,
        batteryLevel: 75,
        firmwareVersion: 'v1.3.2',
      ),
    ];

    emit(state.copyWith(isScanning: false, foundDevices: mockDevices));
  }

  void connectToDevice(DeviceEntity device) {
    final newConnectedDevice = device.copyWith(status: DeviceStatus.connected);
    emit(state.copyWith(connectedDevice: newConnectedDevice));
  }

  void disconnectDevice() {
    emit(state.copyWith(connectedDevice: DeviceEntity.empty));
  }
}

