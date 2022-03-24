library _internal;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tecpal_blue/_constants.dart';
import 'package:tecpal_blue/ble_manager.dart';
import 'package:tecpal_blue/src/error/ble_error.dart';

import 'package:tecpal_blue/src/manager/internal_ble_manager.dart';
import 'package:tecpal_blue/src/model/scan_result.dart';


part 'bridge/bluetooth_state_mixin.dart';

part 'bridge/lib_core.dart';

part 'bridge/scanning_mixin.dart';
