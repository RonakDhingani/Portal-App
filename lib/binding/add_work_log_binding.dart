import 'package:get/get.dart';
import 'package:inexture/controller/add_work_log_controller.dart';

class AddWorkLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWorkLogController>(
      () => AddWorkLogController(),
    );
  }
}
