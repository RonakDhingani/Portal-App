import 'package:get/get.dart';
import 'package:inexture/controller/holidays_controller.dart';

class HolidaysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HolidaysController>(
      () => HolidaysController(),
    );
  }
}
