import 'package:collection/collection.dart';
import 'package:tecpal_blue/src/model/scan_result.dart';

import '../../peripheral.dart';

class BleDevice {
  // lib 中的类
  final Peripheral peripheral;
  final String name;
  final DeviceCategory category;

  String get id => peripheral.identifier;

  BleDevice(ScanResult scanResult)
      : peripheral = scanResult.peripheral,
        name = scanResult.name,
        category = scanResult.category;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(other) =>
      other is BleDevice &&
      compareAsciiLowerCase(this.name, other.name) == 0 &&
      this.id == other.id;

  @override
  String toString() {
    return 'BleDevice{name: $name}';
  }
}
/// 设备类别
/// SensorTag 开箱即可使用，带有 iOS 和 Android 应用，无需编程经验即可开始使用。
enum DeviceCategory { sensorTag, hex, other }

extension on ScanResult {
  String get name =>
      peripheral.name ?? advertisementData.localName ?? "Unknown";

  DeviceCategory get category {
    if (name == "SensorTag") {
      return DeviceCategory.sensorTag;
    } else if (name.startsWith("Hex")) {
      return DeviceCategory.hex;
    } else {
      return DeviceCategory.other;
    }
  }
}
