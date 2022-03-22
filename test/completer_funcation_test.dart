import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

/// @editor :
/// @description :
/// @author : ShiMing
/// @created : 2022-03-21 15:26

void main() {

  /// Completer允许你做某个异步事情的时候，调用c.complete(value)方法来传入最后要返回的值。
  test("Completer fun", () async {
    //given
    Completer c = Completer();
    for (var i = 0; i < 1000; i++) {
      /// 后面执行
      if (i == 900 && c.isCompleted == false) {
        c.completeError('error in $i');
      }
      ///
      if (i == 800 && c.isCompleted == false) {
        c.complete('complete in $i');
      }
    }
    ///最后通过c.future的返回值来得到结果
    //when
    String res = await c.future;
    try {
      //then
      expect('complete in 800', res);
    } catch (e) {
      //then
      expect('complete in 700', res);
    }

  });
}