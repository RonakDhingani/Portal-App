import 'dart:async';

import 'package:get/get.dart';

import '../common_widget/global_value.dart';
import '../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 2), () async {
      if (accessToken == null || accessToken.isEmpty == true) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.mainHome);
      }
    });
  }
}
