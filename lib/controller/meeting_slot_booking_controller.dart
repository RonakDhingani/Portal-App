import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inexture/model/meeting_area_list_model.dart' as meeting;
import 'package:inexture/model/teams_model.dart';

import '../common_widget/api_url.dart';
import '../common_widget/app_colors.dart';
import '../common_widget/global_value.dart';
import '../model/all_active_user_model.dart';
import '../model/pods_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class MeetingSlotBookingController extends GetxController {
  bool isLoading = false;
  bool isCreating = false;
  bool isCreatingButtonEnabled = false;
  bool isSelectAll = false;
  bool isShowMeetingArea = false;
  AllActiveUserModel? allActiveUserModel;
  List<Data>? data = [];
  List<Data>? selectedEmployee = [];
  List<PodsModel> podsModel = [];
  List<PodsModel> selectedPods = [];
  List<TeamsModal> teamsModal = [];
  List<TeamsModal> selectedTeam = [];
  meeting.MeetingAreaListModel? meetingAreaListModel;
  List<meeting.Data>? meetingAreaListData = [];
  List<meeting.Data>? selectedMeetingArea = [];
  String? startTime;
  String? endTime;
  int? hours;
  int? minutes;
  String totalDuration = "00:00";
  String? selectedDate;
  DateTime dateTime = DateTime.now();
  final meetingFormKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController totalDurationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    getAllUser();
    super.onInit();
  }

  Future<void> getAllUser() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.allActiveUser}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('all Active User API Response : ${value.data.toString()}');
        allActiveUserModel = AllActiveUserModel.fromJson(value.data);
        data = allActiveUserModel?.data ?? [];
        update();
        getPods();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getAllUser(),
        );
      },
      onError: (value) {
        log('Gam Zone Games API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getPods() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.pods}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('pods API Response : ${value.data.toString()}');
        podsModel = PodsModel.fromJsonList(value.data);
        update();
        getTeams();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getPods(),
        );
      },
      onError: (value) {
        log('pods API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getTeams() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.teams}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('teams API Response : ${value.data.toString()}');
        teamsModal = TeamsModal.fromJsonList(value.data);
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getTeams(),
        );
      },
      onError: (value) {
        log('teams API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getMeetingArea() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.meetingAreaAvailableList}?start_time=$startTime&end_time=$endTime&date=${Global.formatSelectedDate(dateController.text)}',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Meeting Area API Response : ${value.data.toString()}');
        isShowMeetingArea = true;
        meetingAreaListModel = meeting.MeetingAreaListModel.fromJson(value.data);
        meetingAreaListData = meetingAreaListModel?.data ?? [];
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getTeams(),
        );
      },
      onError: (value) {
        log('Meeting Area API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Future<void> createMeeting() async {
    isCreating = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.gamezone,
      method: 'POST',
      data: {
        "id": null,
        "meeting_area": selectedMeetingArea?.first.id,
        "start_time": startTimeController.text,
        "end_time": endTimeController.text,
        "duration": totalDuration,
        "all_employee": isSelectAll,
        "teams": selectedTeam.map((mA) => mA.id).toList(growable: true),
        "pods": selectedPods.map((mA) => mA.id).toList(growable: true),
        "employees": selectedEmployee?.map((e) => e.id).toList(growable: true),
        "non_employees": [],
        "description": descriptionController.text,
        "date": selectedDate,
        "event_choice": "Meeting"},
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Create Meeting API Response : ${value.data.toString()}');
        isShowMeetingArea = true;
        isCreating = false;
        update();
        Get.back(result: "Meeting Created");
      },
      onServerError: (p0) {
        isCreating = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getTeams(),
        );
      },
      onError: (value) {
        log('Create Meeting API Response : ${value.data.toString()}');
        isCreating = false;
        update();
      },
    );
  }

  bool updateButtonState() {
    if (dateController.text.isEmpty || startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty || descriptionController.text.isEmpty) {
      isCreatingButtonEnabled = false;
      update();
    } else {
      isCreatingButtonEnabled = true;
      update();
    }
    update();
    return isCreatingButtonEnabled;
  }

  void calculateDuration() {
    if (startTimeController.text.isEmpty || endTimeController.text.isEmpty) {
      log("Start time or end time is empty");
      return;
    }

    final startParts = startTimeController.text.split(':');
    final endParts = endTimeController.text.split(':');

    if (startParts.length != 2 || endParts.length != 2) {
      log("Invalid time format");
      return;
    }

    try {
      final startTime = DateTime(
        0,
        1,
        1,
        int.parse(startParts[0]),
        int.parse(startParts[1]),
      );
      final endTime = DateTime(
        0,
        1,
        1,
        int.parse(endParts[0]),
        int.parse(endParts[1]),
      );

      Duration duration = endTime.difference(startTime);

      // If the duration is negative, add a full day to ensure positive duration
      if (duration.isNegative) {
        duration += Duration(days: 1);
      }

      final hours = duration.inHours.toString().padLeft(2, '0');
      final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');

      totalDuration = "$hours:$minutes";
      update();
      log("Total Duration: $totalDuration");

    } catch (e) {
      log("Error parsing time: $e");
    }
  }


}
