import 'package:get/get.dart';

import '../controller/game_zone_controller.dart';

class GameZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameZoneController>(
      () => GameZoneController(),
    );
  }
}

