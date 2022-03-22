import 'dart:async';

import 'package:flutter/material.dart';
import "package:tecpal_blue/src/model/ble_device.dart" show BleDevice;

import 'devices_bloc.dart';
import 'devices_bloc_provider.dart';

typedef DeviceTapListener = void Function();

class DevicesListScreen extends StatefulWidget {
  @override
  State<DevicesListScreen> createState() => DeviceListScreenState();
}

class DeviceListScreenState extends State<DevicesListScreen> {
  DevicesBloc? _devicesBloc;
  StreamSubscription<BleDevice>? _appStateSubscription;
  bool _shouldRunOnResume = true;

  //当widget 第一次插入到wigdet 树的时候，就会调用，但是对于每一个 state对象来说，只会调用一次
  //initState：当 widget 第一次插入到 widget 树时会被调用，对于每一个State对象，Flutter
  // 框架只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。
  // 不能在该回调中调用BuildContext.dependOnInheritedWidgetOfExactType（该方法用于在 widget
  // 树上获取离当前 widget 最近的一个父级InheritedWidget，关于InheritedWidget我们将在后面章节介绍），
  // 原因是在初始化完成后， widget 树中的InheritFrom widget也可能会发生变化，所以正确的做法应该在在build（）
  // 方法或didChangeDependencies()中调用它。
  @override
  void initState() {
    super.initState();
  }

  //在 initState的喉，立刻调用，当 inher itedwidget rebuild 喉，也会调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //这里是开始执行 1
    if (_devicesBloc == null) {
      _devicesBloc = DevicesBlocProvider.of(context);
      if (_shouldRunOnResume) {
        _shouldRunOnResume = false;
        _onResume();
      }
    }
  }

  @override
  void didUpdateWidget(DevicesListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _onPause() {
    _appStateSubscription?.cancel();
    _devicesBloc?.dispose();
  }

  void _onResume() {
    final devicesBloc = _devicesBloc;
    if (devicesBloc == null) {
      return;
    }
    devicesBloc.init();
    _appStateSubscription = devicesBloc.pickedDevice.listen((bleDevice) async {
      _onPause();
      //点击时间去到得 details
      await Navigator.pushNamed(context, "/details");
      setState(() {
        _shouldRunOnResume = true;
      });
    });
  }

  // 绘制界面，当setState喉 会被调用
  @override
  Widget build(BuildContext context) {
    //这里是开始执行 2
    if (_shouldRunOnResume) {
      _shouldRunOnResume = false;
      _onResume();
    }
    final devicesBloc = _devicesBloc;
    if (devicesBloc == null) {
      throw Exception();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth devices'),
      ),
      body: StreamBuilder<List<BleDevice>>(
        initialData:
            devicesBloc.visibleDevices.valueWrapper?.value ?? <BleDevice>[],
        stream: devicesBloc.visibleDevices,
        builder: (context, snapshot) => RefreshIndicator(
          onRefresh: devicesBloc.refresh,
          child: DevicesList(devicesBloc, snapshot.data),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _onPause();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void reassemble() {
    super.reassemble();
  }
}

class DevicesList extends ListView {
  DevicesList(DevicesBloc devicesBloc, List<BleDevice>? devices)
      : super.separated(
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  height: 0,
                  indent: 0,
                ),
            itemCount: devices?.length ?? 0,
            itemBuilder: (context, i) {
              return _buildRow(context, devices![i],
                  _createTapListener(devicesBloc, devices[i]));
            });

  static DeviceTapListener _createTapListener(
      DevicesBloc devicesBloc, BleDevice bleDevice) {
    return () {
      devicesBloc.devicePicker.add(bleDevice);
    };
  }

  static Widget _buildAvatar(BuildContext context, BleDevice device) {
    switch (device.category) {
      // case DeviceCategory.sensorTag:
      //   return CircleAvatar(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Image.asset('assets/ti_logo.png'),
      //       ),
      //       backgroundColor: Theme.of(context).accentColor);
      // case DeviceCategory.hex:
      //   return CircleAvatar(
      //       child: CustomPaint(painter: HexPainter(), size: Size(20, 24)),
      //       backgroundColor: Colors.black);
      // case DeviceCategory.other:
      default:
        return CircleAvatar(
            child: Icon(Icons.bluetooth),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white);
    }
  }

  static Widget _buildRow(BuildContext context, BleDevice device,
      DeviceTapListener deviceTapListener) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: _buildAvatar(context, device),
      ),
      title: Text(device.name),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Icon(Icons.chevron_right, color: Colors.grey),
      ),
      subtitle: Column(
        children: <Widget>[
          Text(
            device.id.toString(),
            style: TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      onTap: deviceTapListener,
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 12),
    );
  }
}
