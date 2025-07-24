import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/controller/profile_controller.dart';
import 'package:inexture/controller/services_controller.dart';
import 'package:inexture/controller/task_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_menu/star_menu.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../model/defaulter_count_model.dart';
import '../model/pending_worklog_time_entry_model.dart';
import '../model/stored_user_model.dart';
import '../model/user_personal_details_model.dart';
import '../model/user_profile_model.dart';
import '../routes/app_pages.dart';
import '../services/api_function.dart';
import '../services/firebase_operation.dart';
import '../utils/utility.dart';
import 'home_controller.dart';

class MainHomeController extends GetxController {
  int currentIndex = 0;
  bool isLoading = false;
  bool isMenuOpen = false;
  Color unSelectedItem = AppColors.blackk;
  Color selectedItem = AppColors.yelloww;
  UserProfileModel? userProfileModel;
  UserProfileDetailsModel? userProfileDetailsModel;
  PendingWorklogTimeEntryModel? pendingWorklogTimeEntryModel;
  DefaulterCountModel? defaulterCountModel;
  final storage = FlutterSecureStorage();

  final centerStarMenuController = StarMenuController();
  final containerKey = GlobalKey();

  final Connectivity connectivity = Connectivity();
  final UserService userService = UserService();
  @override
  void onInit() async {
    super.onInit();

    try {
      await getUserProfile();
      await getUserProfileDetails();
      await getPendingWorklogTimeEntry();
      await getDefaulterCount();
      await userService.getPremiumUserNames();
      Get.put(HomeController());
      Get.lazyPut<TaskController>(() => TaskController());
      Get.lazyPut<ServicesController>(() => ServicesController());
      Get.lazyPut<ProfileController>(() => ProfileController());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
    } catch (e) {
      print("Error during initialization: $e");
    }
  }

  final otherEntries = <Widget>[
    GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addWorkFromHome)?.then(
              (value) {
            if (value != null) {
              Utility.showFlushBar(text: value);
            }
          },
        );
      },
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackk,
              ),
              child: Icon(
                Icons.add_home_work_outlined,
                color: AppColors.yelloww,
              ),
            ),
            Text(
              'WFH',
              style: CommonText.style500S15.copyWith(
                color: AppColors.blackk,
              ),
            ),
          ],
        ),
      ),
    ),
    GestureDetector(
      onTap: () {
        Get.toNamed(Routes.timeEntry);
      },
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackk,
              ),
              child: Icon(
                Icons.access_time,
                color: AppColors.yelloww,
              ),
            ),
            Text(
              'Time Entry',
              style: CommonText.style500S15.copyWith(
                color: AppColors.blackk,
              ),
            ),
          ],
        ),
      ),
    ),
    GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addLeave)?.then(
          (value) {
            if (value != null) {
              Utility.showFlushBar(text: value);
            }
          },
        );
      },
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackk,
              ),
              child: Icon(
                Icons.add_home_outlined,
                color: AppColors.yelloww,
              ),
            ),
            Text(
              'Leave',
              style: CommonText.style500S15.copyWith(
                color: AppColors.blackk,
              ),
            ),
          ],
        ),
      ),
    ),
    GestureDetector(
      onTap: () {
        DateTime currentDate = DateTime.now();
        Get.toNamed(Routes.addWorkLog,
            arguments: {'date': currentDate.toString()})?.then(
              (value) {
            if (value != null) {
              Utility.showFlushBar(text: value);
            }
          },
        );
      },
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackk,
              ),
              child: Icon(
                Icons.add_task_outlined,
                color: AppColors.yelloww,
              ),
            ),
            Text(
              'Task',
              style: CommonText.style500S15.copyWith(
                color: AppColors.blackk,
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(),
    SizedBox(),
  ];

  Future<void> getUserProfile() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.userProfile,
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log('User Profile API Response : ${value.data.toString()}');
        userProfileModel = UserProfileModel.fromJson(value.data);
        gender = userProfileModel?.data?.gender;
        isAdminUser = userProfileModel?.data?.isAdminUser ?? false;
        setIsAdminUser(isAdminUser);
        permissionList.clear();
        permissionList.addAll(userProfileModel?.data?.permissions
                ?.map((entry) => entry.toString())
                .toList() ??
            []);
        getUserProfileDetails();
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getUserProfile(),
        );
      },
      onError: (value) {
        isLoading = false;
        update();
        log('User Profile API Response : ${value.data.toString()}');
      },
    );
  }

  Future<void> getUserProfileDetails() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.userProfileDetails,
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log('User Profile Details API Response : ${value.data.toString()}');
        userProfileDetailsModel = UserProfileDetailsModel.fromJson(value.data);
        userId = userProfileDetailsModel?.data?.id;
        userName = userProfileDetailsModel?.data?.firstName;
        fireUserFullName =
            "${userProfileDetailsModel?.data?.firstName} ${userProfileDetailsModel?.data?.lastName}";
        userRole = userProfileDetailsModel?.data?.roleName;
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getUserProfileDetails(),
        );
      },
      onError: (value) {
        isLoading = false;
        update();
        log('User Profile Details API Response : ${value.data.toString()}');
      },
    );
  }

  Future<void> getPendingWorklogTimeEntry() async {
    ApiFunction.apiRequest(
      url: ApiUrl.pendingWorklogTimeEntry,
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log('Pending Worklog Time Entry API Response : ${value.data.toString()}');
        pendingWorklogTimeEntryModel =
            PendingWorklogTimeEntryModel.fromJson(value.data);
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getPendingWorklogTimeEntry(),
        );
      },
      onError: (value) {
        log('Pending Worklog Time Entry API Response error: ${value.data.toString()}');
      },
    );
  }

  Future<void> getDefaulterCount() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.defaulterCount,
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log('Defaulter Count API Response : ${value.data.toString()}');
        defaulterCountModel = DefaulterCountModel.fromJson(value.data);
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getDefaulterCount(),
        );
      },
      onError: (value) {
        isLoading = false;
        update();
        log('Defaulter Count API Response error: ${value.data.toString()}');
      },
    );
  }

  Future<List<StoredUser>> getStoredUsers() async {
    String? raw = await storage.read(key: 'stored_users');
    if (raw == null) return [];
    List data = jsonDecode(raw);
    return data.map((e) => StoredUser.fromJson(e)).toList();
  }

  Future<void> setIsAdminUser(bool isAdminUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdminUser', isAdminUser);
    update();
  }
}
