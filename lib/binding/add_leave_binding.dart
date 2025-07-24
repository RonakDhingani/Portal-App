import 'package:get/get.dart';

import '../controller/add_leave_controller.dart';

class AddLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLeaveController>(
          () => AddLeaveController(),
    );
  }
}
