import 'package:get/get.dart';

import '../controller/time_entry_controller.dart';

class TimeEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeEntryController>(
      () => TimeEntryController(),
    );
  }
}
