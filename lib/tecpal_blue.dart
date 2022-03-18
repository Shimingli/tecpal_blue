import 'dart:async';

import 'package:flutter/services.dart';

import '_constants.dart';


class TecpalBlue {
  static const MethodChannel _channel = MethodChannel(ChannelName.FLUTTER_BLE_LIB);

  static const EventChannel _stateChannel = EventChannel(ChannelName.FLUTTER_BLE_LIB_TEST);

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void logSming(String log) async {
    final receiveBroadcastStream = _stateChannel.receiveBroadcastStream()
        .listen((event) {
      print('Sming dasfdsfsddsaf ' +event.toString());
    });
    await _channel.invokeMethod(MethodName.LOG_SMING, log);
  }



}
