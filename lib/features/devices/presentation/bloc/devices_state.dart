import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

enum DeviceStatus { disconnected, connecting, connected, error }

class DevicesState extends Equatable {
  final bool isScanning;
  final List<ScanResult> scanResults;
  final BluetoothDevice? connectedDevice;
  final DeviceStatus connectionStatus;
  final String? errorMessage;

  const DevicesState({
    this.isScanning = false,
    this.scanResults = const [],
    this.connectedDevice,
    this.connectionStatus = DeviceStatus.disconnected,
    this.errorMessage,
  });

  DevicesState copyWith({
    bool? isScanning,
    List<ScanResult>? scanResults,
    BluetoothDevice? connectedDevice,
    DeviceStatus? connectionStatus,
    String? errorMessage,
  }) {
    return DevicesState(
      isScanning: isScanning ?? this.isScanning,
      scanResults: scanResults ?? this.scanResults,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isScanning,
        scanResults,
        connectedDevice,
        connectionStatus,
        errorMessage,
      ];
}
