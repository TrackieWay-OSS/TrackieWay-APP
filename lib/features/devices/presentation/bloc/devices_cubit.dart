import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  DevicesCubit() : super(const DevicesState());

  Future<void> startScan() async {
    if (state.isScanning) return;

    // Verifica se o Bluetooth está ligado
    if (await FlutterBluePlus.adapterState.first != BluetoothAdapterState.on) {
      emit(state.copyWith(errorMessage: 'Por favor, ative o Bluetooth.'));
      return;
    }

    emit(state.copyWith(isScanning: true, scanResults: [], errorMessage: null));

    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      // Correção: Filtra para mostrar apenas dispositivos com nome "Trackie"
      final filteredResults = results
          .where((r) =>
              r.device.platformName.toLowerCase().startsWith('trackie'))
          .toList();
      emit(state.copyWith(scanResults: filteredResults));
    });

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    // Quando o scan termina, o próprio pacote para.
    emit(state.copyWith(isScanning: false));
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (state.connectionStatus == DeviceStatus.connecting) return;

    emit(state.copyWith(connectionStatus: DeviceStatus.connecting));

    _connectionSubscription = device.connectionState.listen((connectionState) {
      if (connectionState == BluetoothConnectionState.connected) {
        emit(state.copyWith(
          connectionStatus: DeviceStatus.connected,
          connectedDevice: device,
          scanResults: [], // Limpa os resultados após conectar
        ));
      } else if (connectionState == BluetoothConnectionState.disconnected) {
        disconnect(); // Garante que o estado seja limpo
      }
    });

    try {
      await device.connect(timeout: const Duration(seconds: 15));
    } catch (e) {
      emit(state.copyWith(
        connectionStatus: DeviceStatus.error,
        errorMessage: 'Falha ao conectar ao dispositivo.',
      ));
    }
  }

  Future<void> disconnect() async {
    await state.connectedDevice?.disconnect();
    await _connectionSubscription?.cancel();
    emit(const DevicesState()); // Reseta para o estado inicial
  }

  @override
  Future<void> close() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    FlutterBluePlus.stopScan();
    return super.close();
  }
}

