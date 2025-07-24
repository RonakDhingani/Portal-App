import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/asset.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  SplashScreen({super.key});

  final SplashController loginController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage(
          AssetImg.splashLogoImg,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
