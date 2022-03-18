import 'package:flutter/services.dart';

import '../_constants.dart';
import '../manager/tecpal_ble_manager_implements.dart';

abstract class FlutterBLE {
  final TecpalManger _manager;

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

  FlutterBleLib(TecpalManger manager) : super._(manager);

  /// 这里延迟的任务
  Future<bool> isClientCreated() => _methodChannel
      .invokeMethod<bool>(MethodName.isClientCreated)
      .then((value) => value!);
}
