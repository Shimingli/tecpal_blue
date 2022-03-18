
import 'dart:convert';
import 'dart:typed_data';

import 'package:tecpal_blue/service.dart';
import 'package:tecpal_blue/src/_managers_for_classes.dart';
import 'package:tecpal_blue/src/base_entities.dart';

abstract class _CharacteristicMetadata {
  static const String uuid = "characteristicUuid";
  static const String id = "id";
  static const String isReadable = "isReadable";
  static const String isWritableWithResponse = "isWritableWithResponse";
  static const String isWritableWithoutResponse = "isWritableWithoutResponse";
  static const String isNotifiable = "isNotifiable";
  static const String isIndicatable = "isIndicatable";
  static const String value = "value";
}

class Characteristic extends InternalCharacteristic {
  /// The [Service] containing this characteristic.
  final Service service;

  final ManagerForCharacteristic _manager;

  /// The UUID of this characteristic.
  String uuid;

  /// True if this characteristic can be read.
  bool isReadable;

  /// True if this characteristic can be written with resposne.
  bool isWritableWithResponse;

  /// True if this characteristic can be written without resposne.
  bool isWritableWithoutResponse;

  /// True if this characteristic can be monitored via notifications.
  bool isNotifiable;

  /// True if this characteristic can be monitored via indications.
  bool isIndicatable;

  Characteristic.fromJson(Map<String, dynamic> jsonObject, Service service,
      ManagerForCharacteristic manager)
      : _manager = manager,
        service = service,
        uuid = jsonObject[_CharacteristicMetadata.uuid],
        isReadable = jsonObject[_CharacteristicMetadata.isReadable],
        isWritableWithResponse =
        jsonObject[_CharacteristicMetadata.isWritableWithResponse],
        isWritableWithoutResponse =
        jsonObject[_CharacteristicMetadata.isWritableWithoutResponse],
        isNotifiable = jsonObject[_CharacteristicMetadata.isNotifiable],
        isIndicatable = jsonObject[_CharacteristicMetadata.isIndicatable],
        super(jsonObject[_CharacteristicMetadata.id]);

}

class CharacteristicWithValue extends Characteristic {
  Uint8List value;

  CharacteristicWithValue.fromJson(
    Map<String, dynamic> jsonObject,
    Service service,
    ManagerForCharacteristic manager,
  ) : value = base64Decode(jsonObject[_CharacteristicMetadata.value]),
      super.fromJson(jsonObject, service, manager);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        super == other &&
            other is CharacteristicWithValue &&
            value.toString() == other.value.toString() &&
            runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return super.toString() +
        ' CharacteristicWithValue{value = ${value.toString()}';
  }
}
