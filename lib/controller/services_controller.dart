import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_string.dart';

import '../routes/app_pages.dart';
import 'main_home_controller.dart';

class ServicesController extends GetxController {
  String deviceName = '';
  bool isShowUserNamePass = false;
  List<ServiceItem> services = [];
  String userFullName = '';

  @override
  void onInit() {
    super.onInit();
    initServices();
  }

  Future<void> initServices() async {
    final mainController = Get.find<MainHomeController>();

    while (mainController.userProfileModel?.data == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final userData = mainController.userProfileModel?.data;
    userFullName = "${userData?.firstName} ${userData?.lastName}";

    deviceName = await getDeviceName();
    log("Running on device: $deviceName");

    isShowUserNamePass = showUserNamePass();

    services = [
      ServiceItem(name: AppString.leave, icon: TablerIcons.calendar_time),
      ServiceItem(name: AppString.wfh, icon: TablerIcons.building_community),
      ServiceItem(name: AppString.holidays, icon: TablerIcons.beach),
      ServiceItem(name: AppString.policies, icon: TablerIcons.bulb),
      ServiceItem(name: AppString.project, icon: TablerIcons.briefcase_2),
      ServiceItem(name: AppString.taskDashBoard, icon: TablerIcons.checklist),
      ServiceItem(name: AppString.timeEntry, icon: TablerIcons.file_time),
      ServiceItem(
          name: AppString.venueBooking, icon: TablerIcons.brand_airtable),
      if (isShowUserNamePass)
        ServiceItem(
            name: AppString.premiumUsers, icon: TablerIcons.users_group),
    ];

    update();
  }

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return '${iosInfo.name} (${iosInfo.model})';
    } else {
      return 'Unknown Device';
    }
  }

  bool showUserNamePass() {
    if (deviceName == "motorola moto g31" && userFullName == "Ronak Dhingani") {
      return true;
    } else {
      return false;
    }
  }

  void navigateToService(String serviceName) {
    switch (serviceName) {
      case AppString.leave:
        Get.toNamed(Routes.leave);
        break;
      case AppString.wfh:
        Get.toNamed(Routes.myWorkFromHome);
        break;
      case AppString.holidays:
        Get.toNamed(Routes.holidays);
        break;
      case AppString.policies:
        Get.toNamed(Routes.policies);
        break;
      case AppString.project:
        Get.toNamed(Routes.project);
        break;
      case AppString.taskDashBoard:
        Get.toNamed(Routes.taskDashBoard);
        break;
      case AppString.timeEntry:
        Get.toNamed(Routes.timeEntry);
        break;
      case AppString.venueBooking:
        Get.toNamed(Routes.gameZone);
        break;
      case AppString.premiumUsers:
        Get.toNamed(Routes.premiumUsers);
        break;
      default:
        break;
    }
  }
}

class ServiceItem {
  final String name;
  final IconData icon;

  ServiceItem({required this.name, required this.icon});
}
