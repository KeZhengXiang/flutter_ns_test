import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'hello': '你好 世界',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
        }
      };
}

class GetXHomePage extends StatelessWidget {
  @override
  Widget build(context) {
    // 使用Get.put()实例化你的类，使其对当下的所有子路由可用。
    final Controller c = Get.put(Controller());
    final Controller2 c2 = Get.put(Controller2());
    return Scaffold(
        // 使用Obx(()=>每当改变计数时，就更新Text()。
        appBar: AppBar(title: Obx(() => Text("1、${c.count} \n2、 ${c2.count}"))),

        // 用一个简单的Get.to()即可代替Navigator.push那8行，无需上下文！
        body: Center(
            child: ElevatedButton(child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              c.increment();
              c2.increment();
              print("93204:--" + "1、${c.count}   2、 ${c2.count}");
            }));
  }
}

class Other extends StatelessWidget {
  // 你可以让Get找到一个正在被其他页面使用的Controller，并将它返回给你。
  final Controller c = Get.find();
  final Controller2 c2 = Get.find();

  @override
  Widget build(context) {
    // Get.removeRoute(route);
    // 访问更新后的计数变量
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Text("${c.count}"),
        Text("${c2.count}"),
        Text("${Get.previousRoute}"),
      ],
    )));
  }
}

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

class Controller2 extends GetxController {
  var count = 0.obs;

  increment() {
    print("000000");
    count -= 5;
  }
}
