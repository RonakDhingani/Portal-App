// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/controller/task_controller.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common_widget/api_url.dart';
import '../common_widget/app_colors.dart';
import '../model/holiday_date_model.dart';
import '../model/my_leave_model.dart';
import '../model/my_work_log_date_wise_model.dart' as date_wise;
import '../model/project_my_work_log_list_model.dart' as work_log_list;
import '../services/api_function.dart';
import '../utils/utility.dart';

class TaskDashboardController extends GetxController {
  bool isLoading = false;
  bool isSearch = false;
  bool isLoadingDateWise = false;
  bool isCalendarLoading = false;
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();
  date_wise.MyWorkLogDateWiseModel? myWorkLogDateWiseModel;
  work_log_list.ProjectMyWorkLogListModel? projectMyWorkLogListModel;
  MyLeaveModel? myLeaveModel;
  List<HolidayDateModel> holidayDateModels = [];
  List<Map<String, dynamic>> collectedDate = [];

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  var taskController = Get.find<TaskController>();
  var isHalfDay;
  String? workLeaved;

  @override
  void onInit() {
    getHolidayDate();
    super.onInit();
  }

  Future<void> getProjectMyWorkLogList({
    bool? isShowLoading = false,
  }) async {
    if (isShowLoading == true) {
      isCalendarLoading = true;
      update();
    } else {
      isLoading = true;
      update();
    }
    ApiFunction.apiRequest(
      url: '${ApiUrl.projectMyWorkLogList}?month=$month&year=$year',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusMessage.toString());
        log(value.statusCode.toString());
        log('Api URL : ${value.requestOptions.uri.toString()}');
        log('Project My Work Log List API Response : ${value.data.toString()}');
        projectMyWorkLogListModel =
            work_log_list.ProjectMyWorkLogListModel.fromJson(value.data);
        isLoading = false;
        isCalendarLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getProjectMyWorkLogList(),
        );
      },
      onError: (value) {
        log('Project My Work Log List API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        isCalendarLoading = false;
        update();
      },
    );
  }

  Future<void> getHolidayDate() async {
    isLoading = true;
    isCalendarLoading = true;
    update();
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
          getMyLeavesData();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getHolidayDate(),
          );
        },
        onError: (value) {
          isLoading = false;
          isCalendarLoading = false;
          update();
          log('Holiday Date API Response : ${value.data.toString()}');
        });
  }

  Future<void> getMyLeavesData() async {
    ApiFunction.apiRequest(
        url: '${ApiUrl.myLeaves}?ordering=-start_date',
        method: 'GET',
        onSuccess: (value) {
          log(value.statusCode.toString());
          log(value.realUri.toString());
          log('My Leave API Response Success : ${value.data.toString()}');
          myLeaveModel = MyLeaveModel.fromJson(value.data);
          if (myLeaveModel?.results != null) {
            for (var leave in myLeaveModel!.results!) {
              if(leave.status == 'approved'){
                if (leave.startDate != null && leave.endDate != null) {
                  DateTime startDate = DateTime.parse(leave.startDate!);
                  DateTime endDate = DateTime.parse(leave.endDate!);
                  int duration = int.tryParse(leave.duration ?? '0') ?? 0;
                  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

                  if (startDate == endDate) {
                    collectedDate.add({
                      'date': dateFormat.format(startDate),
                      'halfDayStatus':
                      leave.type == "full" ? null : leave.halfDayStatus,
                    });
                  } else {
                    int addedDays = 0;
                    DateTime currentDate = startDate;

                    while (addedDays < duration) {
                      if (currentDate.weekday != DateTime.saturday &&
                          currentDate.weekday != DateTime.sunday) {
                        collectedDate.add({
                          'date': dateFormat.format(currentDate),
                          'halfDayStatus':
                          leave.type == "full" ? null : leave.halfDayStatus,
                        });
                        addedDays++;
                      }
                      currentDate = currentDate.add(Duration(days: 1));
                    }
                  }
                }
              }
            }
            for (var entry in collectedDate) {
              log("Collected Date: ${entry['date']}, Half Day Status: ${entry['halfDayStatus']}");
            }
          }
          getProjectMyWorkLogList();
          update();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getMyLeavesData(),
          );
        },
        onError: (value) {
          isLoading = false;
          isCalendarLoading = false;
          update();
          log('My Leave API Response Error: ${value.data.toString()}');
        });
  }

  Future<void> getProjectTasksDetailsDateWise({
    required String date,
  }) async {
    isLoadingDateWise = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.projectMyWorklogDateWise}?date=$date',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusMessage.toString());
        log(value.statusCode.toString());
        log(value.requestOptions.uri.toString());
        log('Project Tasks Details Date Wise API Response : ${value.data.toString()}');
        myWorkLogDateWiseModel =
            date_wise.MyWorkLogDateWiseModel.fromJson(value.data);
        isLoadingDateWise = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getProjectTasksDetailsDateWise(date: date),
        );
      },
      onError: (value) {
        log('Project Tasks Details Date Wise API Response : ${value.data.toString()}');
        isLoadingDateWise = false;
        update();
      },
    );
  }

  bool isFocusedDayInCurrentMonth() {
    final now = DateTime.now();
    print('object now month: ${now.month}');
    print('object focusedDay month: ${focusedDay.month}');
    print('object now year: ${now.year}');
    print('object focusedDay year: ${focusedDay.year}');
    return focusedDay.month == now.month && focusedDay.year == now.year;
  }

  String? calculateTotalHours(
      DateTime day, TaskDashboardController taskDashboardCtrl) {
    final isWeekend =
        day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

    final isHoliday = taskDashboardCtrl.holidayDateModels.any(
      (holiday) => holiday.date == DateFormat('yyyy-MM-dd').format(day),
    );

    Map<String, dynamic>? leaveInfo;
    try {
      leaveInfo = collectedDate.firstWhere(
        (leave) => leave['date'] == DateFormat('yyyy-MM-dd').format(day),
      );
    } catch (e) {
      leaveInfo = null;
    }

    final isLeaveDay = leaveInfo != null;
    isHalfDay = leaveInfo?['halfDayStatus'] != null;

    List<work_log_list.Data>? logs = taskDashboardCtrl.projectMyWorkLogListModel
        ?.groupedData[DateFormat('yyyy-MM-dd').format(day)];

    double hours =
        logs?.fold(0, (sum, log) => sum! + double.parse(log.logTime ?? '0')) ??
            0;

    if (!isHalfDay && hours > 0) {
      int fullHours = hours.floor();
      double remainingMinutes = (hours - fullHours) * 100;
      if (remainingMinutes >= 60) {
        fullHours += (remainingMinutes / 60).floor();
        remainingMinutes = remainingMinutes % 60;
      }
      double totalHours = fullHours + (remainingMinutes / 100);
      return totalHours.toStringAsFixed(2);
    } else if (isWeekend) {
      return "W";
    } else if (isHoliday) {
      return "H";
    } else if (isLeaveDay) {
      if (isHalfDay) {
        workLeaved = 'W-L';
        return hours.toStringAsFixed(2);
      }
      return "L";
    } else if (!isSameDate(day, DateTime.now()) &&
        day.isBefore(DateTime.now())) {
      return "P";
    }
    return null;
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Color calculateBackgroundColor(String totalHours) {
    Color bgColor;
    double? totalHoursValue;

    if (totalHours == "H") {
      bgColor = AppColors.yellowLight;
    } else if (totalHours == "L") {
      bgColor = AppColors.blues;
    } else if (totalHours == "P") {
      bgColor = AppColors.brownn;
    } else {
      totalHoursValue = double.tryParse(totalHours);

      if (totalHoursValue != null &&
          totalHoursValue <= (isHalfDay ? 4.00 : 7.00)) {
        bgColor = AppColors.redd;
      } else {
        bgColor = AppColors.greenn;
      }
    }
    return bgColor;
  }
}
