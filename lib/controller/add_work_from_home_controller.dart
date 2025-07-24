import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../model/all_active_user_model.dart';
import '../model/date_duration_model.dart';
import '../model/error_model.dart';
import '../model/holiday_date_model.dart';
import '../model/variable_leave_settings_model.dart';
import '../model/work_from_home_request_to_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';
import 'add_leave_controller.dart';

class AddWorkFromHomeController extends GetxController {
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
  WorkFromHomeRequestToModel? workFromHomeRequestToModel;
  VariableLeaveSettingsModel? variableLeaveSettingsModel;
  AllActiveUserModel? allActiveUserModel;
  DateDurationModel? dateDurationModel;
  List<HolidayDateModel> holidayDateModels = [];
  ErrorModel? errorModel;
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
  List<Item> sendRequestItems = [];
  List<Item> selectedItems = [];
  List<String> alreadyAvailableItems = [];
  List<String> adhocListItem = [
    'directly',
    'teammember',
    'notinform',
  ];
  Map<String, List<String>> reasonsByType = {
    "Health-Related Reasons": [
      "Feeling unwell but capable of working from home.",
      "Recovering from a minor illness or surgery.",
      "Suffering from a temporary ailment (e.g., cold, headache) that requires rest.",
      "Managing a chronic condition that is better handled from home.",
      "Quarantine or self-isolation due to exposure to an illness."
    ],
    "Family and Personal Commitments": [
      "Taking care of a sick child or elderly family member.",
      "Attending to urgent family matters or personal emergencies.",
      "Handling critical family obligations like appointments or school events.",
      "Need to manage household chores or personal tasks during working hours.",
      "Supporting family members with special needs or disabilities."
    ],
    "Commute and Travel Challenges": [
      "Unforeseen transportation problems (e.g., car breakdown, missed public transport).",
      "Bad weather conditions affecting commute (e.g., snowstorm, floods).",
      "Traffic disruptions (e.g., roadblocks, accidents) preventing timely arrival.",
      "Delayed or canceled flights (for employees working remotely after travel).",
      "Long commute times making remote work a more efficient option."
    ],
    "Work-Focused Requirements": [
      "Need to focus on a project that requires fewer interruptions and distractions.",
      "Access to specialized tools, equipment, or resources available only at home.",
      "To attend to tasks that require uninterrupted concentration or creativity.",
      "Prefer working from home to enhance productivity and efficiency.",
      "Involvement in confidential tasks that require a private work environment."
    ],
    "Other Exceptional Circumstances": [
      "Waiting for a scheduled service at home (e.g., repair, delivery).",
      "Managing unexpected home issues that require immediate attention (e.g., plumbing, electricity).",
      "Personal safety concerns due to external circumstances (e.g., safety issues in the area).",
      "Specific appointments (e.g., doctors, utility services) that require staying at home.",
      "Flexible work arrangement as per company policies for remote days."
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
        log(value.statusMessage.toString());
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
        log('Work From Home Request To API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getAllActiveUser() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.allActiveUser}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
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
        log('All Active User API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getVariableLeaveSettingsData() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.variableLeaveSettings}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Variable Leave Settings API Response : ${value.data.toString()}');
        variableLeaveSettingsModel =
            VariableLeaveSettingsModel.fromJson(value.data);
        getHolidayDate();
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getVariableLeaveSettingsData(),
        );
      },
      onError: (value) {
        log('Variable Leave Settings API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
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
        log(value.realUri.toString());
        log(value.statusMessage.toString());
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
        log('Date Duration API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isDateDurationLoading = false;
        update();
      },
    );
  }

  Future<void> submitDataForWorkFromHome() async {
    isSubmitting = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.myWorkFromHome,
      method: 'POST',
      data: dio.FormData.fromMap({
        "requested_by": null,
        "request_from": "$userId",
        "request_to":
            selectedItems.map((item) => item.id).toList(growable: true),
        "type": selectedDayType,
        "half_day_status": selectedHalfTime,
        "isadhoc_wfh": isAdhoc,
        "adhoc_status": adhocController.text,
        "start_date": "$startDate",
        "end_date": "$endDate",
        "duration": totalDayController.text,
        "return_date": "$returnDate",
        "reason": reasonController.text,
      }),
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Created work from home request API Response : ${value.data.toString()}');
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
          (value) => submitDataForWorkFromHome(),
        );
      },
      onError: (value) {
        log('Created work from home request API Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isDateDurationLoading = false;
        update();
      },
    );
  }

  // Future<void> submitDataForWorkFromHome() async {
  //   isSubmitting = true;
  //   update();
  //   try {
  //     dio.FormData formData = dio.FormData.fromMap({
  //       "requested_by": null,
  //       "request_from": "$userId",
  //       "request_to":
  //           selectedItems.map((item) => item.id).toList(growable: true),
  //       "type": selectedDayType,
  //       "half_day_status": selectedHalfTime,
  //       "isadhoc_wfh": isAdhoc,
  //       "adhoc_status": adhocController.text,
  //       "start_date": "$startDate",
  //       "end_date": "$endDate",
  //       "duration": totalDayController.text,
  //       "return_date": "$returnDate",
  //       "reason": reasonController.text,
  //     });
  //     var myDio = dio.Dio();
  //     await myDio
  //         .post(
  //       ApiUrl.myWorkFromHome,
  //       data: formData,
  //       options: dio.Options(
  //         headers: {
  //           "Authorization": 'Bearer $accessToken',
  //         },
  //         validateStatus: (status) => true,
  //       ),
  //     )
  //         .then((value) async {
  //       log('Created work from home request url${value.realUri.toString()}');
  //       if (value.statusCode == 200 || value.statusCode == 201) {
  //         print(
  //             'Created work from home request API Response : ${value.data.toString()}');
  //         isSubmitting = false;
  //         update();
  //         Get.back(canPop: true);
  //         Utility.showFlushBar(text: value.statusMessage.toString());
  //       } else if (value.statusCode == 400 || value.statusCode == 401) {
  //         errorModel = ErrorModel.fromJson(value.data);
  //         Utility.showFlushBar(
  //             text:
  //                 errorModel?.error?.message?.validationError?[0].toString() ??
  //                     '');
  //         isSubmitting = false;
  //         update();
  //       }
  //     });
  //   } catch (err) {
  //     isSubmitting = false;
  //     update();
  //     log("Created work from home request Error => ${err.toString()}");
  //   }
  // }

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

    return isStartDateFilled &&
        isEndDateFilled &&
        isReasonFilled &&
        isAdhocFilled;
  }

  void updateSubmitButtonState() {
    isSubmitButtonEnabled = areAllRequiredFieldsFilled();
    update();
  }
}
