import 'package:tecpal_blue/peripheral.dart';
import 'package:tecpal_blue/src/manager/internal_ble_manager.dart';


typedef RestoreStateAction = Function(List<Peripheral> peripherals);
/// Level of details library is to output in logs.
enum LogLevel { none, verbose, debug, info, warning, error }

abstract class BleManager {
  static BleManager? _instance;

  factory BleManager() {
    var instance = _instance;
    if (instance == null) {
      instance = InternalBleManager();
      _instance = instance;
    }

    return instance;
  }

  Future<void> cancelTransaction(String transactionId);

  Future<bool> isClientCreated();

  Future<void> createClient({
    String? restoreStateIdentifier,
    RestoreStateAction? restoreStateAction,
  });

  Future<void> destroyClient();

  Future<void> stopPeripheralScan();

  Future<void> setLogLevel(LogLevel logLevel);

  Future<LogLevel> logLevel();

  Future<void> enableRadio({String transactionId});

  Future<void> disableRadio({String transactionId});

  Future<BluetoothState> bluetoothState();

  Stream<BluetoothState> observeBluetoothState({bool emitCurrentValue = true});

  Future<List<Peripheral>> knownPeripherals(List<String> peripheralIdentifiers);


  Future<List<Peripheral>> connectedPeripherals(List<String> serviceUUIDs);

  Peripheral createUnsafePeripheral(String peripheralId, {String? name});
}

/// State of the Bluetooth Adapter.
enum BluetoothState {
  UNKNOWN,
  UNSUPPORTED,
  UNAUTHORIZED,
  POWERED_ON,
  POWERED_OFF,
  RESETTING,
}

abstract class ScanMode {
  static const int opportunistic = -1;
  static const int lowPower = 0;
  static const int balanced = 1;
  static const int lowLatency = 2;
}

abstract class CallbackType {
  static const int allMatches = 1;
  static const int firstMatch = 2;
  static const int matchLost = 4;
}
