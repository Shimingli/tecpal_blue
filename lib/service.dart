import 'package:tecpal_blue/peripheral.dart';
import 'package:tecpal_blue/src/_managers_for_classes.dart';
import 'package:tecpal_blue/src/base_entities.dart';

abstract class _ServiceMetadata {
  static const String uuid = "serviceUuid";
  static const String id = "serviceId";
}

class Service extends InternalService {
  /// [Peripheral] containing this service.
  Peripheral peripheral;

  final ManagerForService _manager;

  /// The UUID of this service.
  String uuid;

  Service.fromJson(
    Map<String, dynamic> jsonObject,
    Peripheral peripheral,
    this._manager,
  ) : peripheral = peripheral,
      uuid = jsonObject[_ServiceMetadata.uuid],
      super(jsonObject[_ServiceMetadata.id]);

  @override
  String toString() {
    return 'Service{peripheralId: ${peripheral.identifier}, uuid: $uuid}';
  }
}
