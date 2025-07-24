import 'package:get/get.dart';

import '../controller/main_home_controller.dart';


class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainHomeController>(
          () => MainHomeController(),
    );
  }
}