import 'package:get/get.dart';

import '../controller/upcoming_leave_controller.dart';

class UpcomingLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingLeaveController>(
      () => UpcomingLeaveController(),
    );
  }
}
