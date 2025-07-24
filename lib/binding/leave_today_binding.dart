import 'package:get/get.dart';
import 'package:inexture/controller/leave_today_controller.dart';

class LeaveTodayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveTodayController>(
          () => LeaveTodayController(),
    );
  }
}