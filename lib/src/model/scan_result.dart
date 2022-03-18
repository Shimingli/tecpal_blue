import 'dart:convert';
import 'dart:typed_data';

import '../../peripheral.dart';
import '../_managers_for_classes.dart';

abstract class _ScanResultMetadata {
  static const String rssi = "rssi";
  static const String manufacturerData = "manufacturerData";
  static const String serviceData = "serviceData";
  static const String serviceUuids = "serviceUUIDs";
  static const String localName = "localName";
  static const String txPowerLevel = "txPowerLevel";
  static const String solicitedServiceUuids = "solicitedServiceUUIDs";
  static const String isConnectable = "isConnectable";
  static const String overflowServiceUuids = "overflowServiceUUIDs";
}
/// 蓝牙扫描结果
class ScanResult {
  final Peripheral peripheral;

  final int rssi;

  /// ios 使用， 外围设备是否可以连接
  final bool? isConnectable;

  ///  ios 使用， UUIDs
  final List<String> overflowServiceUuids;

  /// 外设通告的数据包。
  final AdvertisementData advertisementData;
  
  ScanResult._(
    this.peripheral, 
    this.rssi,
    this.advertisementData,
    {this.isConnectable, 
    List<String>? overflowServiceUuids, 
  }) : overflowServiceUuids = overflowServiceUuids ?? <String>[];


  factory ScanResult.fromJson(
    Map<String, dynamic?> json, 
    ManagerForPeripheral manager
  ) {
    assert(json[_ScanResultMetadata.rssi] is int);
    return ScanResult._(
      Peripheral.fromJson(json, manager), 
      json[_ScanResultMetadata.rssi],
      AdvertisementData._fromJson(json),
      isConnectable: json[_ScanResultMetadata.isConnectable],
      overflowServiceUuids: json[_ScanResultMetadata.overflowServiceUuids]
    );
  }
}

/// Data advertised by the [Peripheral]: power level, local name,
/// manufacturer's data, advertised [Service]s
class AdvertisementData {
  /// The manufacturer data of the peripheral.
  final Uint8List? manufacturerData;

  /// A dictionary that contains service-specific advertisement data.
  final Map<String, Uint8List>? serviceData;

  /// A list of service UUIDs.
  final List<String>? serviceUuids;

  /// The local name of the [Peripheral]. Might be different than
  /// [Peripheral.name].
  final String? localName;

  /// The transmit power of the peripheral.
  final int? txPowerLevel;

  /// A list of solicited service UUIDs.
  final List<String>? solicitedServiceUuids;

  AdvertisementData._fromJson(Map<String, dynamic> json)
      : manufacturerData =
            _decodeBase64OrNull(json[_ScanResultMetadata.manufacturerData]),
        serviceData =
            _getServiceDataOrNull(json[_ScanResultMetadata.serviceData]),
        serviceUuids =
            _mapToListOfStringsOrNull(json[_ScanResultMetadata.serviceUuids]),
        localName = json[_ScanResultMetadata.localName],
        txPowerLevel = json[_ScanResultMetadata.txPowerLevel],
        solicitedServiceUuids =
          _mapToListOfStringsOrNull(
            json[_ScanResultMetadata.solicitedServiceUuids]
          );

  static Map<String, Uint8List>? _getServiceDataOrNull(
      Map<String, dynamic>? serviceData) {
    return serviceData?.map(
      (key, value) => MapEntry(key, base64Decode(value)),
    );
  }

  static Uint8List? _decodeBase64OrNull(String? base64Value) {
    if (base64Value != null) {
      return base64.decode(base64Value);
    } else {
      return null;
    }
  }

  static List<String>? _mapToListOfStringsOrNull(List<dynamic>? values) =>
      values?.cast<String>();
}
