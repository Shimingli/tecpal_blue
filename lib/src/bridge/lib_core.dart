// part of _internal;

import 'package:flutter/services.dart';

import '../../_constants.dart';
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
}
