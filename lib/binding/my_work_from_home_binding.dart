import 'package:get/get.dart';

import '../controller/my_work_from_home_controller.dart';

class MyWorkFromHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWorkFromHomeController>(
      () => MyWorkFromHomeController(),
    );
  }
}
