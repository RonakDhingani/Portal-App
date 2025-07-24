import 'package:get/get.dart';

import '../controller/task_dashboard_controller.dart';

class TaskDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDashboardController>(
      () => TaskDashboardController(),
    );
  }
}
