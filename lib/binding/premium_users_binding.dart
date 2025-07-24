import 'package:get/get.dart';

import '../controller/premium_users_controller.dart';

class PremiumUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PremiumUsersController>(
      () => PremiumUsersController(),
    );
  }
}
