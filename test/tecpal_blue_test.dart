import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tecpal_blue/tecpal_blue_lib.dart';

/// @editor :
/// @description :
/// @author : ShiMing
/// @created : 2022-03-21 15:25
void main() {
  const MethodChannel channel = MethodChannel('tecpal_blue');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });



  test('getPlatformVersion', () async {
    expect(await TecpalBlue.platformVersion, '42');
  });


}
