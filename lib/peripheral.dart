part of flutter_ble_lib;


abstract class _PeripheralMetadata {
  static const name = "name";
  static const identifier = "id";
}

class Peripheral {
  static const int NO_MTU_NEGOTIATION = 0;
  String? name;
}

enum PeripheralConnectionState {
  connecting,
  connected,
  disconnected,
  disconnecting
}
