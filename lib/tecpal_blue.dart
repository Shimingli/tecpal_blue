
import 'dart:async';

import 'package:flutter/services.dart';

class TecpalBlue {
  static const MethodChannel _channel = MethodChannel('tecpal_blue');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
