import 'package:flutter/services.dart';

/// @editor :
/// @description : mixins的中文意思是混入，就是在类中混入其他功能。 on只能用于被mixins标记的类，
/// 例如mixins X on A，意思是要mixins X的话，得先接口实现或者继承A。这里A可以是类，也可以是接口
/// @author : ShiMing
/// @created : 2022-03-23 16:42

void main() {
  // B b = B();
  // print(b.content);
  // b.a();

  A a = A();
  a.fun("main");

  B b = B();
  b.fun('main');
}

abstract class Test {
  final _methodChannel = const MethodChannel("");
}

class S extends Test with MA{
  var a = 2;

  fun(String from) => print('currentClassName:S  from:$from');
}

mixin MA on Test {
  @override
  fun(String from) {
    print('currentClassName:MA  from:$from');
  }
}

/// 可以导入 S中的变量 var
mixin MB on S {
  @override
  fun(String from) {
    print('currentClassName:MB  from:$from');
    print('currentClassName:MB  from:$_methodChannel');
  }
}
mixin MC on S {
  @override
  fun(String from) {
    print('currentClassName:MC  from:$from');
  }
}

/// 执行最后的类的方法，往前靠
class A extends S with MC, MA, MB {}

class B extends S with MB, MA {}
//
// class A {
//   String content = 'A Class';
//
//   void a(){
//     print("a");
//   }
// }
//
// class B with A{
//
// }
//
// class AA {
//   var b;
//   void a(){
//     print("a");
//   }
// }
//
//
// mixin X on AA{
//   void x(){
//     print("x");
//
//     print(b);
//   }
//
// }
