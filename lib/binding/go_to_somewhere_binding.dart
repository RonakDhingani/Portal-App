import 'package:get/get.dart';

import '../controller/go_to_somewhere_controller.dart';

class GoToSomewhereBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoToSomewhereController>(
      () => GoToSomewhereController(),
    );
  }
}
