import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../model/game_zone_user_model.dart';
import '../model/slot_booked_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class GameBookingController extends GetxController with WidgetsBindingObserver {
  bool isLoading = false;
  bool isCreating = false;
  bool isSubmitButtonEnabled = false;
  List<GameZoneUserModel> gameZoneUserModel = [];
  List<GameZoneUserModel> selectUsers = [];
  SlotBookedModel? slotBookedModel;
  String? toDaysDate;
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? startTimeUse;
  String? endTimeUse;
  int? gameIndex;
  String? gameName;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    toDaysDate = getCurrentDate();
    getGamUser();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    startTimeController.dispose();
    endTimeController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  GameBookingController() {
    final arguments = Get.arguments;
    gameIndex = arguments['gameIndex'];
    gameName = arguments['gameName'];
    startTimeController.text = arguments['startTime'];
    endTimeController.text = arguments['endTime'];
    startTimeUse = arguments['startTimeUse'];
    endTimeUse = arguments['endTimeUse'];
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> getGamUser() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.gameUsers}$toDaysDate/',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Gam Users API Response : ${value.data.toString()}');
        gameZoneUserModel = GameZoneUserModel.fromJsonList(value.data);
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getGamUser(),
        );
      },
      onError: (value) {
        log('Gam Users API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> bookingGameSlot() async {
    isCreating = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.gamezone,
      method: 'POST',
      data: {
        "id": null,
        "game": "$gameIndex",
        "start_time": startTimeUse,
        "end_time": endTimeUse,
        "duration": "00:15:00",
        "employees": selectUsers.map((item) => item.id).toList(growable: true),
        "non_employees": [],
        "description": descriptionController.text.isEmpty == true
            ? null
            : descriptionController.text,
        "date": "$toDaysDate",
        "event_choice": "Game"
      },
      onSuccess: (value) {
        log('slot Booked API Response : ${value.data.toString()}');
        slotBookedModel = SlotBookedModel.fromJson(value.data);
        slotBookedId = slotBookedModel?.data?.id;
        isCreating = false;
        update();
        Get.back(result: "Slot Booked");
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getGamUser(),
        );
      },
      onError: (value) {
        log('slot Booked API Response : ${value.data.toString()}');
        isCreating = false;
        update();
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
      },
    );
  }

  bool updateButtonState() {
    if (selectUsers.length >= 2) {
      isSubmitButtonEnabled = true;
      update();
    } else {
      isSubmitButtonEnabled = false;
      update();
    }
    return isSubmitButtonEnabled;
  }
}
