import 'package:flutter_test/flutter_test.dart';

/// @editor :
/// @description :
/// @author : ShiMing
/// @created : 2022-03-21 17:22

void main() {
  test("aysnc * ", () async {
    int result = await doSomeLongTask();
    print(result); // prints '42' after waiting 1 second


    await for (int i in countForOneMinute()) {
      print(i); // prints 1 to 60, one integer per second
    }

    expect(result, 42);
  });


}
/// async给你一个Future
/// async*给你一个Stream。
Future<int> doSomeLongTask() async {
  await Future.delayed(const Duration(seconds: 1));
  return 42;
}
//
Stream<int> countForOneMinute() async* {
  for (int i = 1; i <= 60; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}
