import 'package:equatable/equatable.dart';
import 'package:trackie_app/features/devices/domain/entities/device_entity.dart';

class DevicesState extends Equatable {
  final List<DeviceEntity> foundDevices;
  final DeviceEntity? connectedDevice;
  final bool isScanning;

  const DevicesState({
    this.foundDevices = const [],
    this.connectedDevice,
    this.isScanning = false,
  });

  DevicesState copyWith({
    List<DeviceEntity>? foundDevices,
    DeviceEntity? connectedDevice,
    bool? isScanning,
  }) {
    return DevicesState(
      foundDevices: foundDevices ?? this.foundDevices,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      isScanning: isScanning ?? this.isScanning,
    );
  }

  @override
  List<Object?> get props => [foundDevices, connectedDevice, isScanning];
}
