import 'package:flutter/widgets.dart';

import 'devices_bloc.dart';

/// InheritedWidget是flutter中一个非常重要的组件，
/// 其功能是数据共享。我们只要在widget树的根或者某个widget中，
/// 使用InheritedWidget进行了数据共享，
/// 那么在其后面的子widget中都可以使用其中的共享数据
class DevicesBlocProvider extends InheritedWidget {
  final DevicesBloc _devicesBloc;

  DevicesBlocProvider({
    Key? key,
    DevicesBloc? devicesBloc,
    required Widget child,
  })  : _devicesBloc = devicesBloc ?? DevicesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DevicesBloc of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DevicesBlocProvider>()
      !._devicesBloc;
}
