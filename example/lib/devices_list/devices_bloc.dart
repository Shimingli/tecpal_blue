import 'dart:async';
import 'dart:io';
import 'package:tecpal_blue/ble_manager.dart';
import "package:tecpal_blue/src/model/ble_device.dart";
import "package:tecpal_blue/src/model/scan_result.dart";
import 'package:tecpal_blue/tecpal_blue_lib.dart';
import 'package:rxdart/rxdart.dart';
import '../repository/device_repository.dart';
import 'package:permission_handler/permission_handler.dart';

/// fluuter clean
class DevicesBloc {
  final List<BleDevice> bleDevices = <BleDevice>[];

  BehaviorSubject<List<BleDevice>> _visibleDevicesController =
      BehaviorSubject<List<BleDevice>>.seeded(<BleDevice>[]);

  StreamController<BleDevice> _devicePickerController =
      StreamController<BleDevice>();

  StreamSubscription<ScanResult>? _scanSubscription;
  StreamSubscription<BleDevice>? _devicePickerSubscription;

  ValueStream<List<BleDevice>> get visibleDevices =>
      _visibleDevicesController.stream;

  Sink<BleDevice> get devicePicker => _devicePickerController.sink;

  final DeviceRepository _deviceRepository;
  final BleManager _bleManager;

  Stream<BleDevice> get pickedDevice => _deviceRepository.pickedDevice
      .skipWhile((bleDevice) => bleDevice == null)
      .cast<BleDevice>();

  DevicesBloc({DeviceRepository? deviceRepository, BleManager? bleManager})
      : _deviceRepository = deviceRepository ?? DeviceRepository(),
        _bleManager = bleManager ?? BleManager();

  void _handlePickedDevice(BleDevice bleDevice) {
    _deviceRepository.pickDevice(bleDevice);
  }

  void dispose() {
    _devicePickerSubscription?.cancel();
    _visibleDevicesController.close();
    _devicePickerController.close();
    _scanSubscription?.cancel();
  }

  /// 1、检查权限
  /// 2、打开蓝牙
  /// 3、开始扫描
  void init() {
    bleDevices.clear();

    maybeCreateClient()
        .then((_) => _checkPermissions())
        .catchError((e) => _noPermissions())
        .then((_) => _waitForBluetoothPoweredOn())
        .catchError((e) => LogUtils.Sming(" _waitForBluetoothPoweredOn error "))
        .then((_) => _startScan())
        .catchError((e) => LogUtils.Sming(" _startScan error "));

    if (_visibleDevicesController.isClosed) {
      _visibleDevicesController =
          BehaviorSubject<List<BleDevice>>.seeded(<BleDevice>[]);
    }

    if (_devicePickerController.isClosed) {
      _devicePickerController = StreamController<BleDevice>();
    }

    _devicePickerSubscription =
        _devicePickerController.stream.listen(_handlePickedDevice);
  }

  Future<void> maybeCreateClient() async {
    final clientAlreadyExists = await _bleManager.isClientCreated();

    if (clientAlreadyExists) {
      return Future.value();
    }
    // ios 检查参数是否可用
    return _bleManager
        .createClient(
            restoreStateIdentifier: "example-restore-state-identifier",
            restoreStateAction: (peripherals) {
              peripherals.forEach((peripheral) {});
            })
        .catchError((e) {});
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      var locGranted = await Permission.location.isGranted;
      LogUtils.Sming(locGranted.toString());
      if (locGranted == false) {
        locGranted = (await Permission.location.request()).isGranted;
      }
      if (locGranted == false) {
        return Future.error(Exception("Location permission not granted"));
      }
    }
  }

  /// 这个是一个异步任务，一定要等到 user 打开蓝牙的开关之后，才能继续下一步的动作
  /// 等到user 同意打开蓝牙，才能进行到下一步
  /// 如果user 禁止了蓝牙的，那么就会fail，
  /// 请看测试类 completer_test.dart
  Future<void> _waitForBluetoothPoweredOn() async {
    Completer completer = Completer();
    StreamSubscription<BluetoothState>? subscription;
    subscription = _bleManager
        .observeBluetoothState(emitCurrentValue: true)
        .listen((bluetoothState) async {
      //BluetoothState.POWERED_ON  打开
      LogUtils.Sming(" bluetoothState 蓝牙的状态 " + bluetoothState.toString());
      if (bluetoothState == BluetoothState.POWERED_OFF) {
        _bleManager.enableRadio();
      } else if (bluetoothState == BluetoothState.POWERED_ON &&
          !completer.isCompleted) {
        await subscription?.cancel();
        completer.complete();
      }
    });
    return completer.future;
  }

  void _startScan() {
    LogUtils.Sming("_startScan");
    _scanSubscription = _bleManager.startPeripheralScan().listen((scanResult) {
      var bleDevice = BleDevice(scanResult);
      if (!bleDevices.contains(bleDevice)) {
        bleDevices.add(bleDevice);
        _visibleDevicesController.add(bleDevices.sublist(0));
      }
    });
  }

  Future<void> refresh() async {
    await _bleManager.stopPeripheralScan();
    await _scanSubscription?.cancel();
    bleDevices.clear();

    _visibleDevicesController.add(bleDevices.sublist(0));

    await _checkPermissions()
        .then((_) => _startScan())
        .catchError((e) => LogUtils.Sming("_checkPermissions"));
  }

  ///使用async开启一个异步开始处理，使用await来等待处理结果，如处理一个网络请求
  Future<void> _noPermissions() async {
    LogUtils.Sming(" _checkPermissions error 没有给与权限 ");
    if (await Permission.location.request().isDenied) {
      await Permission.location.request();
    }
  }
}
