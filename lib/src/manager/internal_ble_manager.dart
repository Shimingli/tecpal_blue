import 'dart:typed_data';

import 'package:tecpal_blue/characteristic.dart';
import 'package:tecpal_blue/descriptor.dart';
import 'package:tecpal_blue/peripheral.dart';
import 'package:tecpal_blue/service.dart';
import 'package:tecpal_blue/src/_internal.dart';
import 'package:tecpal_blue/src/model/scan_result.dart';

import '../../ble_manager.dart';
import '../_managers_for_classes.dart';

class InternalBleManager implements BleManager , ManagerForPeripheral {
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
  Future<void> enableRadio({String? transactionId}) =>
      _bleLib.enableRadio(transactionId ?? "111");

  @override
  Future<List<Peripheral>> knownPeripherals(
      List<String> peripheralIdentifiers) {
    // TODO: implement knownPeripherals
    throw UnimplementedError();
  }

  @override
  Future<LogLevel> logLevel() {
    // TODO: implement logLevel
    throw UnimplementedError();
  }

  // @override
  // Stream<BluetoothState> observeBluetoothState(
  //         {bool emitCurrentValue = true}) =>
  //     _bleLib.observeBluetoothState(emitCurrentValue);

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

  @override
  Stream<ScanResult> startPeripheralScan({
    int scanMode = ScanMode.lowPower,
    int callbackType = CallbackType.allMatches,
    List<String> uuids = const [],
    bool allowDuplicates = false,
  }) =>
      _bleLib.startDeviceScan(scanMode, callbackType, uuids, allowDuplicates);

  @override
  Future<List<Characteristic>> characteristics(Peripheral peripheral, String serviceUuid) {
    // TODO: implement characteristics
    throw UnimplementedError();
  }

  // @override
  // Future<void> connectToPeripheral(
  //     String identifier, {
  //       required bool isAutoConnect,
  //       required int requestMtu,
  //       required bool refreshGatt,
  //       Duration? timeout,
  //     }) async =>
  //     _bleLib.connectToPeripheral(
  //         identifier, isAutoConnect, requestMtu, refreshGatt, timeout);
  @override
  Future<List<Descriptor>> descriptorsForPeripheral(Peripheral peripheral, String serviceUuid, String characteristicUuid) {
    // TODO: implement descriptorsForPeripheral
    throw UnimplementedError();
  }

  @override
  Future<void> disconnectOrCancelPeripheralConnection(String peripheralIdentifier) {
    // TODO: implement disconnectOrCancelPeripheralConnection
    throw UnimplementedError();
  }

  @override
  Future<void> discoverAllServicesAndCharacteristics(Peripheral peripheral, String transactionId) {
    // TODO: implement discoverAllServicesAndCharacteristics
    throw UnimplementedError();
  }

  @override
  Future<bool> isPeripheralConnected(String peripheralIdentifier) {
    // TODO: implement isPeripheralConnected
    throw UnimplementedError();
  }

  @override
  Stream<CharacteristicWithValue> monitorCharacteristicForDevice(Peripheral peripheral, String serviceUuid, String characteristicUuid, String transactionId) {
    // TODO: implement monitorCharacteristicForDevice
    throw UnimplementedError();
  }

  @override
  Stream<PeripheralConnectionState> observePeripheralConnectionState(String peripheralIdentifier, bool emitCurrentValue, bool completeOnDisconnect) {
    // TODO: implement observePeripheralConnectionState
    throw UnimplementedError();
  }

  @override
  Future<CharacteristicWithValue> readCharacteristicForDevice(Peripheral peripheral, String serviceUuid, String characteristicUuid, String transactionId) {
    // TODO: implement readCharacteristicForDevice
    throw UnimplementedError();
  }

  @override
  Future<DescriptorWithValue> readDescriptorForPeripheral(Peripheral peripheral, String serviceUuid, String characteristicUuid, String descriptorUuid, String transactionId) {
    // TODO: implement readDescriptorForPeripheral
    throw UnimplementedError();
  }

  @override
  Future<int> requestMtu(Peripheral peripheral, int mtu, String transactionId) {
    // TODO: implement requestMtu
    throw UnimplementedError();
  }

  @override
  Future<int> rssi(Peripheral peripheral, String transactionId) {
    // TODO: implement rssi
    throw UnimplementedError();
  }

  @override
  Future<List<Service>> services(Peripheral peripheral) {
    // TODO: implement services
    throw UnimplementedError();
  }

  @override
  Future<Characteristic> writeCharacteristicForDevice(Peripheral peripheral, String serviceUuid, String characteristicUuid, Uint8List value, bool withResponse, String transactionId) {
    // TODO: implement writeCharacteristicForDevice
    throw UnimplementedError();
  }

  @override
  Future<Descriptor> writeDescriptorForPeripheral(Peripheral peripheral, String serviceUuid, String characteristicUuid, String descriptorUuid, Uint8List value, String transactionId) {
    // TODO: implement writeDescriptorForPeripheral
    throw UnimplementedError();
  }

  @override
  Future<void> connectToPeripheral(String peripheralIdentifier, {required bool isAutoConnect, required int requestMtu, required bool refreshGatt, Duration? timeout}) {
    // TODO: implement connectToPeripheral
    throw UnimplementedError();
  }

  @override
  Stream<BluetoothState> observeBluetoothState(
      {bool emitCurrentValue = true}) =>
      _bleLib.observeBluetoothState(emitCurrentValue);
}
