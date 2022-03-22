
import 'package:tecpal_blue/peripheral.dart';

import '../../ble_manager.dart';
import '../bridge/lib_core.dart';

class InternalBleManager implements BleManager {
  late FlutterBleLib _bleLib;

  InternalBleManager() {
    _bleLib = FlutterBleLib(this);
  }

  @override
  Future<bool> isClientCreated() => _bleLib.isClientCreated();


  @override
  Future<BluetoothState> bluetoothState() {
    // TODO: implement bluetoothState
    throw UnimplementedError();
  }

  @override
  Future<void> cancelTransaction(String transactionId) {
    // TODO: implement cancelTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Peripheral>> connectedPeripherals(List<String> serviceUUIDs) {
    // TODO: implement connectedPeripherals
    throw UnimplementedError();
  }

  @override
  Peripheral createUnsafePeripheral(String peripheralId, {String? name}) {
    throw UnimplementedError();
  }

  @override
  Future<void> destroyClient() {
    // TODO: implement destroyClient
    throw UnimplementedError();
  }

  @override
  Future<void> disableRadio({String? transactionId}) {
    // TODO: implement disableRadio
    throw UnimplementedError();
  }

  @override
  Future<void> enableRadio({String? transactionId}) {
    // TODO: implement enableRadio
    throw UnimplementedError();
  }

  @override
  Future<List<Peripheral>> knownPeripherals(List<String> peripheralIdentifiers) {
    // TODO: implement knownPeripherals
    throw UnimplementedError();
  }

  @override
  Future<LogLevel> logLevel() {
    // TODO: implement logLevel
    throw UnimplementedError();
  }

  @override
  Stream<BluetoothState> observeBluetoothState(
      {bool emitCurrentValue = true}) =>
      _bleLib.observeBluetoothState(emitCurrentValue);

  @override
  Future<void> setLogLevel(LogLevel logLevel) {
    // TODO: implement setLogLevel
    throw UnimplementedError();
  }

  @override
  Future<void> stopPeripheralScan() {
    // TODO: implement stopPeripheralScan
    throw UnimplementedError();
  }

  @override
  Future<void> createClient({
    String? restoreStateIdentifier,
    RestoreStateAction? restoreStateAction,
  }) async {
    // if (restoreStateAction != null) {
    //   _bleLib.restoredState().then((devices) {
    //     restoreStateAction(devices);
    //   });
    // }
    // return _bleLib.createClient(restoreStateIdentifier);
    // TODO: IOS Shiming
  }
}
