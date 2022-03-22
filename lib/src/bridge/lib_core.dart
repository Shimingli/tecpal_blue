import 'package:flutter/services.dart';

import '../../_constants.dart';
import '../../ble_manager.dart';
import '../manager/internal_ble_manager.dart';

class FlutterBLE {
  final InternalBleManager _manager;

  FlutterBLE._(this._manager);

  final MethodChannel _methodChannel =
      const MethodChannel(ChannelName.FLUTTER_BLE_LIB);

  Future<void> cancelTransaction(String transactionId) async {
    await _methodChannel.invokeMethod(MethodName.cancelTransaction,
        <String, String>{ArgumentName.transactionId: transactionId});
    return;
  }
}

class FlutterBleLib extends FlutterBLE {
  final Stream<dynamic> _restoreStateEvents =
      const EventChannel(ChannelName.FLUTTER_BLE_LIB).receiveBroadcastStream();

  FlutterBleLib(InternalBleManager manager) : super._(manager);

  /// 延迟的任务
  Future<bool> isClientCreated() => _methodChannel
      .invokeMethod<bool>(MethodName.isClientCreated)
      .then((value) => value!);

  final Stream<dynamic> _adapterStateChanges =
  const EventChannel(ChannelName.adapterStateChanges)
      .receiveBroadcastStream();

  ///
  Stream<BluetoothState> observeBluetoothState(bool emitCurrentValue) async* {
    if (emitCurrentValue == true) {
      BluetoothState currentState = await state();
      yield currentState;
    }
    //async*方法内使用yield*,其后对象必须是Stream<T>对象
    yield* _adapterStateChanges.map(_mapToBluetoothState);
  }
  //单元素异步
  Future<BluetoothState> state() => _methodChannel
      .invokeMethod(MethodName.getState)
      .then(_mapToBluetoothState);


  BluetoothState _mapToBluetoothState(dynamic rawValue) {
    switch (rawValue) {
      case "Unknown":
        return BluetoothState.UNKNOWN;
      case "Unsupported":
        return BluetoothState.UNSUPPORTED;
      case "Unauthorized":
        return BluetoothState.UNAUTHORIZED;
      case "Resetting":
        return BluetoothState.RESETTING;
      case "PoweredOn":
        return BluetoothState.POWERED_ON;
      case "PoweredOff":
        return BluetoothState.POWERED_OFF;
      default:
        throw "Cannot map $rawValue to known bluetooth state";
    }
  }
}
