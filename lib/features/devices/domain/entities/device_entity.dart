import 'package:equatable/equatable.dart';

enum DeviceStatus { connected, disconnected, connecting }

class DeviceEntity extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final DeviceStatus status;
  final int? batteryLevel;
  final String? firmwareVersion;

  const DeviceEntity({
    required this.name,
    required this.id,
    required this.rssi,
    this.status = DeviceStatus.disconnected,
    this.batteryLevel,
    this.firmwareVersion,
  });

  static const empty = DeviceEntity(name: '', id: '', rssi: 0);

  DeviceEntity copyWith({
    String? name,
    String? id,
    int? rssi,
    DeviceStatus? status,
    int? batteryLevel,
    String? firmwareVersion,
  }) {
    return DeviceEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      rssi: rssi ?? this.rssi,
      status: status ?? this.status,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
    );
  }
  
  @override
  List<Object?> get props => [id, name, status, batteryLevel, firmwareVersion];
}

