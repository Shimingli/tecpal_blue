import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tecpal_blue/tecpal_blue.dart';

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
