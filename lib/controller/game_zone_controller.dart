// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/global_value.dart';

import '../common_widget/api_url.dart';
import '../common_widget/asset.dart';
import '../model/game_zone_booked_slot_model.dart';
import '../model/game_zone_games_model.dart';
import '../model/meeting_slot_booked_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class GameZoneController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isLoading = false;
  bool isExpand = false;
  List<GameZoneGamesModel>? gameZoneGamesModel;
  GamZoneBookedSlotModel? gamZoneBookedSlotModel;
  MeetingSlotBookedModel? meetingSlotBookedModel;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Game Zone',
    ),
    Tab(text: 'Meeting'),
  ];
  late TabController controller;

  @override
  void onInit() {
    controller = TabController(vsync: this, length: myTabs.length);
    controller.addListener(
      () {
        update();
      },
    );
    getGameZoneGames();
    super.onInit();
  }

  Future<void> getGameZoneGames() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.gameZoneGames}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Game Zone Games API Response : ${value.data.toString()}');
        gameZoneGamesModel = GameZoneGamesModel.fromJsonList(value.data);
        update();
        getGameZoneBookedSlot();
        getMeetingBookedSlot();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getGameZoneGames(),
        );
      },
      onError: (value) {
        log('Game Zone Games API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getGameZoneBookedSlot({
    bool? isShowLoading = false,
  }) async {
    if (isShowLoading == true) {
      isLoading = true;
      update();
    }
    ApiFunction.apiRequest(
      url: '${ApiUrl.gameZoneBookedSlot}Game&search=&ordering=-start_time',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Game Zone Booked Slot API Response : ${value.data.toString()}');
        gamZoneBookedSlotModel = GamZoneBookedSlotModel.fromJson(value.data);
        if (isShowLoading == true) {
          isLoading = false;
        }
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getGameZoneBookedSlot(),
        );
      },
      onError: (value) {
        log('Game Zone Booked Slot API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getMeetingBookedSlot() async {
    ApiFunction.apiRequest(
      url:
          '${ApiUrl.gameZoneBookedSlot}Meeting&date=${Global.formattedCurrentDate}&search=&ordering=-id&filters=%5B%5D&filterModes',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Meeting Booked Slot API Response : ${value.data.toString()}');
        meetingSlotBookedModel = MeetingSlotBookedModel.fromJson(value.data);
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getMeetingBookedSlot(),
        );
      },
      onError: (value) {
        log('Meeting Booked Slot API Response : ${value.data.toString()}');
        log('Status Message: ${value.statusMessage}');
        isLoading = false;
        update();
      },
    );
  }

  String assetImage(String imgName) {
    var image;
    switch (imgName) {
      case 'Chess':
        image = AssetImg.chessImg;
        break;
      case 'Carrom':
        image = AssetImg.carromImg;
        break;
      case 'Table Tennis':
        image = AssetImg.tableTennisImg;
        break;
      default:
        break;
    }
    return image;
  }

  MeetingStatus getVenueStatus(String startTimeStr, String endTimeStr) {
    final now = DateTime.now();

    final partsStart = startTimeStr.trim().split(":");
    final partsEnd = endTimeStr.trim().split(":");

    final startTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(partsStart[0]),
        int.parse(partsStart[1]),
        int.parse(partsStart[2]));

    final endTime = DateTime(now.year, now.month, now.day,
        int.parse(partsEnd[0]), int.parse(partsEnd[1]), int.parse(partsEnd[2]));

    if (now.isBefore(startTime)) {
      return MeetingStatus.notStarted;
    } else if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return MeetingStatus.ongoing;
    } else {
      return MeetingStatus.disabled;
    }
  }
}

enum MeetingStatus {
  notStarted,
  ongoing,
  disabled,
}
