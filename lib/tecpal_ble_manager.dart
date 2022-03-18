
// part of tecpal_blue;

import 'package:tecpal_blue/peripheral.dart';

import 'ble_manager.dart';

/// /// 回调用于通知系统恢复的外围设备。 ios
// typedef RestoreStateAction = Function(List<Peripheral> peripherals);

/// ble 管理类  feiqi
abstract class BaseTecpalBLEManager{

  /// 检查本地设备能否创建BLE设备
  Future<bool> isClientCreated();


  /// ios
  Future<void> createClient({
    String? restoreStateIdentifier,
    RestoreStateAction? restoreStateAction,
  });

}
