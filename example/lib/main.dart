import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tecpal_blue/ble_manager.dart';
import 'package:tecpal_blue/tecpal_blue_lib.dart';

import 'ButtonView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    TecpalBlue.logSming("hello log");
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await TecpalBlue.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: _createAutoTestControlPanel(),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text('Running on: $_platformVersion\n'),
            )
          ]),
        ),
      ),
    );
  }

  Widget _createAutoTestControlPanel() {
    return Row(
      children: <Widget>[
        ButtonView("开始", action: createClient),
      ],
    );
  }

  final BleManager _bleManager = BleManager();


  /// 检查权限 检查蓝牙的开关，如果是关了的 记得打开  开始扫描
  Future<void> createClient() async {


    final clientAlreadyExists = await _bleManager.isClientCreated();
    if (clientAlreadyExists) {
      TecpalBlue.logSming(" clientAlreadyExists ");
      return Future.value();
    }else {
      TecpalBlue.logSming(" clientAlready Not Exists ");
    }
    TecpalBlue.logSming(" go this  ");
    return _bleManager
        .createClient(
            restoreStateIdentifier: "example-restore-state-identifier",
            restoreStateAction: (peripherals) {
              peripherals.forEach((peripheral) {});
            })
        .catchError((e) {
      return TecpalBlue.logSming("catchError");
    });
  }
}
