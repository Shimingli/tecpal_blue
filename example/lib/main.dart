import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tecpal_blue/ble_manager.dart';
import 'package:tecpal_blue/tecpal_blue_lib.dart';

import 'ButtonView.dart';
import 'devices_list/devices_bloc.dart';
import 'devices_list/devices_bloc_provider.dart';
import "package:tecpal_blue/src/model/ble_device.dart" show BleDevice;

import 'devices_list/devices_list_view.dart';


void main() {
  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState1();
}


class _MyAppState1 extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    TecpalBlue.logSming("hello log");
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBleLib example',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A3D91),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFCC0000)),
      ),
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (context) => DevicesBlocProvider(child: DevicesListScreen()),
        "/details": (context) => DevicesBlocProvider(child: DevicesListScreen())
      },
      navigatorObservers: [routeObserver],
    );
  }


  final BleManager _bleManager = BleManager();

  /// 检查权限 检查蓝牙的开关，如果是关了的 记得打开  开始扫描
  Future<void> createClient() async {
    final clientAlreadyExists = await _bleManager.isClientCreated();
    if (clientAlreadyExists) {
      TecpalBlue.logSming(" clientAlreadyExists ");
      return Future.value();
    } else {
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


class MyAppOld extends StatefulWidget {
  const MyAppOld({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DevicesBloc? _devicesBloc;
  StreamSubscription<BleDevice>? _appStateSubscription;
  String _platformVersion = 'Unknown';
  bool _shouldRunOnResume = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    TecpalBlue.logSming("hello log");
  }

  //在 initState的喉，立刻调用，当 inher itedwidget rebuild 喉，也会调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_devicesBloc == null) {
      _devicesBloc = DevicesBlocProvider.of(context);
      if (_shouldRunOnResume) {
        _shouldRunOnResume = false;
        _onResume();
      }
    }
  }

  void _onResume() {
    final devicesBloc = _devicesBloc;
    if (devicesBloc == null) {
      return;
    }
    devicesBloc.init();
    _appStateSubscription = devicesBloc.pickedDevice.listen((bleDevice) async {
      _onPause();
      await Navigator.pushNamed(context, "/details");
      setState(() {
        _shouldRunOnResume = true;
      });
    });
  }

  void _onPause() {
    _appStateSubscription?.cancel();
    _devicesBloc?.dispose();
  }

  @override
  void dispose() {
    _onPause();
    super.dispose();
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
    } else {
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
