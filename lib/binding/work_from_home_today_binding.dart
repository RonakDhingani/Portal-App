import 'package:get/get.dart';

import '../controller/wrok_from_home_today_controller.dart';

class WorkFromHomeTodayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkFromHomeTodayController>(
          () => WorkFromHomeTodayController(),
    );
  }
}