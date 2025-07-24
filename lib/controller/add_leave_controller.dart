// ignore_for_file: unnecessary_string_interpolations

import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/model/all_active_user_model.dart';
import 'package:inexture/model/error_model.dart';
import 'package:inexture/utils/utility.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../model/create_leave_model.dart';
import '../model/date_duration_model.dart';
import '../model/holiday_date_model.dart';
import '../model/variable_leave_settings_model.dart';
import '../model/work_from_home_request_to_model.dart';
import '../services/api_function.dart';

class Item {
  final String name;
  final int id;

  Item({required this.name, required this.id});
}

class AddLeaveController extends GetxController {
  bool isLoading = false;
  bool isAdhoc = false;
  bool isAddOnLeave = false;
  bool isEnabled = false;
  bool isSubmitting = false;
  bool isDateDurationLoading = false;
  bool isAvailabilityOnPhone = false;
  bool isAvailabilityInCity = false;
  bool isSubmitButtonEnabled = false;

  String selectedDayType = 'full';
  String selectedHalfTime = '';
  String itemSelected = '';
  String countryCode = '91';
  var startDate;
  var endDate;
  var returnDate;
  String? addOnLeaveID;
  AllActiveUserModel? allActiveUserModel;
  DateDurationModel? dateDurationModel;
  CreateLeaveModel? createLeaveModel;
  ErrorModel? errorModel;
  WorkFromHomeRequestToModel? workFromHomeRequestToModel;
  VariableLeaveSettingsModel? variableLeaveSettingsModel;
  List<HolidayDateModel> holidayDateModels = [];
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController totalDayController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController requestController = TextEditingController();
  final TextEditingController sendRequestController = TextEditingController();
  final TextEditingController adhocController = TextEditingController();
  final TextEditingController addOnLeaveController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Item> sendRequestItems = [];
  List<Item> selectedItems = [];
  List<String> alreadyAvailableItems = [];
  List<String> adhocListItem = [
    'directly',
    'teammember',
    'notinform',
  ];
  Map<String, List<String>> reasonsByType = {
    "Personal Work": [
      "Visiting the bank for financial tasks.",
      "Shopping for household essentials.",
      "Handling important personal documents.",
      "Attending a local appointment (e.g., property management).",
      "Running errands for family needs."
    ],
    "Medical Emergency": [
      "Consulting a doctor for health issues.",
      "Visiting a hospital for treatment or tests.",
      "Assisting a family member in medical care.",
      "Attending an urgent health check-up.",
      "Seeking emergency medical attention for an accident or illness."
    ],
    "Family Function": [
      "Celebrating a wedding ceremony of a close family member.",
      "Attending a birthday celebration.",
      "Gathering for an anniversary party.",
      "Participating in a religious or cultural ceremony.",
      "Hosting or attending a family reunion."
    ],
    "Vacation": [
      "Traveling to a holiday destination.",
      "Enjoying a stay-cation for relaxation.",
      "Spending quality time with family or friends on a trip.",
      "Exploring a new city or countryside.",
      "Recharging from work or personal stress."
    ],
    "Marriage": [
      "Preparing for your own wedding.",
      "Participating in a sibling’s wedding.",
      "Celebrating a close friend's wedding.",
      "Assisting in a relative’s wedding preparations.",
      "Traveling for a destination wedding."
    ],
  };

  @override
  void onInit() {
    getWorkFromHomeRequestTo();
    super.onInit();
  }

  Future<void> getWorkFromHomeRequestTo() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
        url: '${ApiUrl.workFromHomeRequestTo}$userId',
        method: 'GET',
        onSuccess: (value) {
          log(value.statusCode.toString());
          log(value.realUri.toString());
          log('Work From Home Request API Response : ${value.data.toString()}');
          workFromHomeRequestToModel =
              WorkFromHomeRequestToModel.fromJson(value.data);
          workFromHomeRequestToModel?.data?.forEach((data) {
            selectedItems.add(
              Item(
                name: '${data.firstName} ${data.lastName}\n',
                id: data.id?.toInt() ?? 0,
              ),
            );
            alreadyAvailableItems.add('${data.firstName} ${data.lastName}\n');
          });
          update();
          getAllActiveUser();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getWorkFromHomeRequestTo(),
          );
        },
        onError: (value) {
          isLoading = false;
          update();
          log('Work From Home Request API Response : ${value.data.toString()}');
        });
  }

  Future<void> getAllActiveUser() async {
    ApiFunction.apiRequest(
        url: '${ApiUrl.allActiveUser}?public_access=true',
        method: 'GET',
        onSuccess: (value) {
          log(value.statusCode.toString());
          log(value.realUri.toString());
          log('All Active User API Response : ${value.data.toString()}');
          allActiveUserModel = AllActiveUserModel.fromJson(value.data);
          allActiveUserModel?.data?.forEach((data) {
            sendRequestItems.add(
              Item(
                name: '${data.firstName} ${data.lastName}\n',
                id: data.id ?? 0,
              ),
            );
          });
          getVariableLeaveSettingsData();
          update();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getAllActiveUser(),
          );
        },
        onError: (value) {
          isLoading = false;
          update();
          log('All Active User API Response : ${value.data.toString()}');
        });
  }

  Future<void> getVariableLeaveSettingsData() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.variableLeaveSettings}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log('Variable Leave Settings API Response : ${value.data.toString()}');
        variableLeaveSettingsModel =
            VariableLeaveSettingsModel.fromJson(value.data);
        getHolidayDate();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getVariableLeaveSettingsData(),
        );
      },
      onError: (value) {
        isLoading = false;
        update();
        log('Variable Leave Settings API Response : ${value.data.toString()}');
      },
    );
  }

  Future<void> getHolidayDate() async {
    ApiFunction.apiRequest(
        url: '${ApiUrl.holidays}?public_access=true',
        method: 'GET',
        onSuccess: (value) {
          log(value.statusCode.toString());
          log(value.realUri.toString());
          log('Holiday Date API Response : ${value.data.toString()}');
          holidayDateModels = (value.data as List)
              .map((json) => HolidayDateModel.fromJson(json))
              .toList();
          isLoading = false;
          update();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getHolidayDate(),
          );
        },
        onError: (value) {
          isLoading = false;
          update();
          log('Holiday Date API Response : ${value.data.toString()}');
        });
  }

  Future<void> getDateDurationCalculation({
    String? startDate,
    String? endDate,
  }) async {
    isDateDurationLoading = true;
    update();
    ApiFunction.apiRequest(
      url:
          '${ApiUrl.dateDurationCalculation}?start_date=$startDate&end_date=$endDate&type=${selectedDayType.isEmpty ? 'full' : selectedDayType}${selectedHalfTime.isEmpty ? '' : '&half_day_status=$selectedHalfTime'}',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log('Date Duration Calculation URL${value.realUri.toString()}');
        log('Date Duration API Response : ${value.data.toString()}');
        dateDurationModel = DateDurationModel.fromJson(value.data);

        startDateController.text =
            Global.formatDate(dateDurationModel?.data?.startDate ?? "");
        endDateController.text =
            Global.formatDate(dateDurationModel?.data?.endDate ?? "");
        returnDateController.text =
            Global.formatDate(dateDurationModel?.data?.returnDate ?? "");
        returnDate = dateDurationModel?.data?.returnDate ?? "";
        totalDayController.text =
            dateDurationModel?.data?.duration.toString() ?? 0.toString();
        isDateDurationLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getDateDurationCalculation(),
        );
      },
      onError: (value) {
        errorModel = ErrorModel.fromJson(value.data);
        isLoading = false;
        update();
        Utility.showFlushBar(
          text:
              errorModel?.error?.message?.validationError?[0].toString() ?? '',
          color: AppColors.redd,
        );
        log('Date Duration API Response : ${value.data.toString()}');
      },
    );
  }

  Future<void> submitData() async {
    isSubmitting = true;
    update();
    ApiFunction.apiRequest(
      url: addOnLeaveID == null ? ApiUrl.myLeaves : ApiUrl.createAddLeaves,
      method: 'POST',
      data: dio.FormData.fromMap({
        "requested_by": null,
        "request_from": "$userId",
        "request_to":
            selectedItems.map((item) => item.id).toList(growable: true),
        "type": "$selectedDayType",
        "half_day_status": "$selectedHalfTime",
        "start_date": "$startDate",
        "end_date": "$endDate",
        "return_date": "$returnDate",
        "duration": "${totalDayController.text}",
        "reason": "${reasonController.text}",
        "isadhoc_leave": isAdhoc,
        "adhoc_status": "${adhocController.text}",
        "available_on_phone": isAvailabilityOnPhone,
        "available_on_city": isAvailabilityInCity,
        "emergency_contact": phoneController.text.isEmpty
            ? ""
            : "+$countryCode${phoneController.text}",
        "is_add_on_leave": isAddOnLeave,
        "add_on_leave_type_status": addOnLeaveID == null ? null : addOnLeaveID
      }),
      onSuccess: (value) {
        log(value.statusCode.toString());
        log('Created add leave url${value.realUri.toString()}');
        log('Created add leave API Response : ${value.data.toString()}');
        Global.addTaskSound().then(
          (value) {
            isSubmitting = false;
            update();
            Get.back(result: "Created");
          },
        );
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => submitData(),
        );
      },
      onServerError: (p0) {
        isSubmitting = false;
        update();
      },
      onError: (value) {
        errorModel = ErrorModel.fromJson(value.data);
        isSubmitting = false;
        update();
        Utility.showFlushBar(
          text:
              errorModel?.error?.message?.validationError?[0].toString() ?? '',
          color: AppColors.redd,
        );
        log('Created add leave API Response : ${value.data.toString()}');
      },
    );
  }

  void updateSelectedDayType(String value) {
    selectedDayType = value;
    print('Selected Day Type: $selectedDayType');
    update();
  }

  void updateSelectedHalfTime(String value) {
    selectedHalfTime = value;
    print('Selected Half Time: $selectedHalfTime');
    update();
  }

  void setStartDate(DateTime date) {
    startDate = date.toString().split(' ')[0];
    startDateController.text = Global.formatDate(date.toString().split(' ')[0]);
    update();
    if (endDateController.text.isNotEmpty) {
      getDateDurationCalculation(startDate: startDate, endDate: endDate);
    }
  }

  void setEndDate(DateTime? date) {
    endDate = date.toString().split(' ')[0];
    endDateController.text = Global.formatDate(date.toString().split(' ')[0]);
    update();
    getDateDurationCalculation(startDate: startDate, endDate: endDate);
  }

  bool areAllRequiredFieldsFilled() {
    bool isStartDateFilled = startDateController.text.isNotEmpty;
    bool isEndDateFilled = endDateController.text.isNotEmpty;
    bool isReasonFilled = reasonController.text.isNotEmpty;
    bool isAdhocFilled = !isAdhoc || adhocController.text.isNotEmpty;
    bool isAddOnLeaveFilled =
        !isAddOnLeave || addOnLeaveController.text.isNotEmpty;

    return isStartDateFilled &&
        isEndDateFilled &&
        isReasonFilled &&
        isAdhocFilled &&
        isAddOnLeaveFilled;
  }

  void updateSubmitButtonState() {
    isSubmitButtonEnabled = areAllRequiredFieldsFilled();
    update();
  }
}
