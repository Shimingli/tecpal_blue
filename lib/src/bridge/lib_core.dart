part of _internal;


class FlutterBLE {
  final InternalBleManager _manager;
  var aa=0;
  FlutterBLE._(this._manager);

  final MethodChannel _methodChannel = const MethodChannel(ChannelName.FLUTTER_BLE_LIB);

  Future<void> cancelTransaction(String transactionId) async {
    await _methodChannel.invokeMethod(MethodName.cancelTransaction,
        <String, String>{ArgumentName.transactionId: transactionId});
    return;
  }
}

class FlutterBleLib extends FlutterBLE with ScanningMixin, BluetoothStateMixin {
  FlutterBleLib(InternalBleManager manager) : super._(manager);

  /// 延迟的任务
  Future<bool> isClientCreated() => _methodChannel
      .invokeMethod<bool>(MethodName.isClientCreated)
      .then((value) => value!);

  Future<void> createClient(String? restoreStateIdentifier) async {
    await _methodChannel.invokeMethod(
        MethodName.createClient, <String, String?>{
      ArgumentName.restoreStateIdentifier: restoreStateIdentifier
    });
  }

  Future<void> destroyClient() async {
    await _methodChannel.invokeMethod(MethodName.destroyClient);
  }
}