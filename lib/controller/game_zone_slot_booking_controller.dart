import 'dart:developer';

import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';

import '../common_widget/api_url.dart';
import '../model/game_zone_slot_booking_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class GameZoneSlotBookingController extends GetxController {
  bool isLoading = false;
  bool isUpdated = false;
  GameZoneSlotBookingModel? gameZoneSlotBookingModel;
  int? gameIndex;
  String? gameName;

  @override
  void onInit() {
    getGamZoneSlotBooking();
    super.onInit();
  }

  GameZoneSlotBookingController() {
    final arguments = Get.arguments;
    gameIndex = arguments['gameIndex'];
    gameName = arguments['gameName'];
  }

  Future<void> getGamZoneSlotBooking() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.gameZoneSlotBooking}$gameIndex/',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Gam Zone Slot Booking API Response : ${value.data.toString()}');
        gameZoneSlotBookingModel =
            GameZoneSlotBookingModel.fromJson(value.data);
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getGamZoneSlotBooking(),
        );
      },
      onError: (value) {
        log('Gam Zone Slot Booking API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> slotDelete(int deleteSlotId) async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.gamezoneDelete}$deleteSlotId/',
      method: 'DELETE',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Gam Zone Slot Delete API Response : ${value.data.toString()}');
        getGamZoneSlotBooking();
        isUpdated = true;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => slotDelete(deleteSlotId),
        );
      },
      onError: (value) {
        log('Gam Zone Slot Delete API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }
}
