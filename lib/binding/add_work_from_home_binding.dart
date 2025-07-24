import 'package:get/get.dart';

import '../controller/add_work_from_home_controller.dart';

class AddWorkFromHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWorkFromHomeController>(
      () => AddWorkFromHomeController(),
    );
  }
}
