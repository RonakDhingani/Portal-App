// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../routes/app_pages.dart';
import '../services/api_function.dart';
import '../services/firebase_operation.dart';
import '../utils/utility.dart';
import 'home_controller.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  bool isOldShow = false;
  bool isNewShow = false;
  bool isCnfNewShow = false;
  bool isLogOuting = false;
  bool isChangePass = false;
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();
  final TextEditingController cnfNewPasswordCtrl = TextEditingController();
  final UserService userService = UserService();
  final formKey = GlobalKey<FormState>();
  String errorTextNewCnfPass = '';
  String deviceName = '';

  @override
  void onInit() {
    getDeviceName().then((name) {
      log("Running on device: $name");
      deviceName = name;
    });
    super.onInit();
  }

  Future<void> logout() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiFunction.apiRequest(
      url: ApiUrl.logoutUrl,
      method: 'POST',
      data: dio.FormData.fromMap({
        "refresh": refreshToken.toString(),
      }),
      headers: {
        "Content-Type":
            'multipart/form-data; boundary=<calculated when request is sent>',
      },
      onSuccess: (value) {
        log(value.statusCode.toString());
        prefs.remove('accessToken');
        prefs.remove('refreshToken');
        prefs.remove('isScrollAlready');
        prefs.remove('isAdminUser');
        isAdminUser = false;
        userId = '';
        isLoading = false;
        update();
        if (WidgetsBinding.instance.lifecycleState != null) {
          WidgetsBinding.instance.removeObserver(Get.find<HomeController>());
        }
        Get.offAllNamed(Routes.login);
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => logout(),
        );
      },
      onError: (value) {
        print('Logout API Response : ${value.data.toString()}');
        isLoading = false;
        update();
      },
    );
  }

  Future<void> changePassword() async {
    isChangePass = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiFunction.apiRequest(
      url: ApiUrl.changePassword,
      method: 'PUT',
      data: dio.FormData.fromMap({
        "old_password": "${oldPasswordCtrl.text}",
        "password": "${newPasswordCtrl.text}",
        "password2": "${cnfNewPasswordCtrl.text}",
      }),
      onSuccess: (value) async {
        log(value.statusCode.toString());
        isChangePass = false;
        update();
        String? fireUserID = prefs.getString("storedUsername");
        String? docRefID = prefs.getString("docRefID");
        await userService.updateUser(
          docRefID: "$docRefID",
          fireUserName: fireUserFullName,
          fireUserID: "$fireUserID",
          password: newPasswordCtrl.text,
        );
        Get.offAllNamed(Routes.login);
        prefs.remove("accessToken");
        prefs.remove("refreshToken");
        prefs.remove("storedUsername");
        prefs.remove("storedPassword");
        prefs.remove("isAdminUser");
        prefs.remove("isScrollAlready");
        oldPasswordCtrl.clear();
        newPasswordCtrl.clear();
        cnfNewPasswordCtrl.clear();
        Utility.showFlushBar(
          text: value.data["message"].toString(),
          color: AppColors.greenn,
        ).then(
          (value) {
            Utility.showFlushBar(
              text: 'Please login with new password.',
            );
          },
        );
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => changePassword(),
        );
      },
      onError: (value) {
        log('API error Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  bool areAllRequiredFieldsFilled() {
    bool isOldFilled = oldPasswordCtrl.text.isNotEmpty;
    bool isNewFilled = newPasswordCtrl.text.isNotEmpty;
    bool isCnfNewFilled = cnfNewPasswordCtrl.text.isNotEmpty;

    return isOldFilled && isNewFilled && isCnfNewFilled;
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
    if (deviceName == "motorola moto g31" &&
        fireUserFullName == "Ronak Dhingani") {
      return true;
    } else {
      return false;
    }
  }
}
