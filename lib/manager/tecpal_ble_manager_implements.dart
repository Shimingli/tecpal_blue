import 'package:tecpal_blue/manager/tecpal_ble_manager.dart';

import '../bridge/lib_core.dart';

class TecpalManger implements BaseTecpalBLEManager {
  late FlutterBleLib _bleLib;

  TecpalManger() {
    _bleLib = FlutterBleLib(this);
  }

  @override
  Future<bool> isClientCreated() => _bleLib.isClientCreated();
}
