import 'package:get/get.dart';

import '../controller/game_booking_controller.dart';

class GameBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameBookingController>(
      () => GameBookingController(),
    );
  }
}
