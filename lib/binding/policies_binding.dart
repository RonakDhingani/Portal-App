import 'package:get/get.dart';
import 'package:inexture/controller/policies_controller.dart';

class PoliciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PoliciesController>(
          () => PoliciesController(),
    );
  }
}