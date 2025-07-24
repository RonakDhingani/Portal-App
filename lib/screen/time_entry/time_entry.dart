// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/buttons.dart';
import 'package:inexture/common_widget/common_dropdown_menu.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:inexture/screen/time_entry/time_entry_details/time_entry_tile_details.dart';
import 'package:inexture/screen/time_entry/time_entry_log_list.dart';
import 'package:inexture/screen/time_entry/time_entry_page_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/app_string.dart';
import '../../common_widget/common_app_bar.dart';
import '../../common_widget/common_live_time_card.dart';
import '../../common_widget/text.dart';
import '../../controller/home_controller.dart';
import '../../controller/time_entry_controller.dart';
import '../../model/my_time_entry_month_model.dart';
import '../../utils/utility.dart';

class TimeEntryScreen extends GetView<TimeEntryController> {
  TimeEntryScreen({super.key});

  @override
  TimeEntryController controller = Get.put(TimeEntryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimeEntryController>(
      builder: (timeEntryController) {
        HomeController homeController = Get.put(HomeController());
        if (isAdminUser == false) {
          Timer.periodic(Duration(seconds: 1), (timer) {
            timeEntryController.update();
          });
        }
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.myTimeEntry,
            widget: Container(
              margin: EdgeInsets.only(right: 15),
              child: CommonDropdownMenu(
                value: timeEntryController.dropdownTodayValue,
                items: timeEntryController.dropdownTodayItems,
                onChanged: (value) {
                  if (value == 'Previous') {
                    timeEntryController.isToday = false;
                    timeEntryController.dropdownTodayValue = value;
                    timeEntryController.update();
                  } else {
                    timeEntryController.isToday = true;
                    timeEntryController.dropdownTodayValue = value;
                    timeEntryController.update();
                  }
                },
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      TimeEntryPageView(
                        isLoading: timeEntryController.isLoading,
                        color: controller.currentIndex == 0
                            ? AppColors.redd
                            : controller.currentIndex == 1
                                ? AppColors.yelloww
                                : AppColors.greenn,
                        controller: timeEntryController.pageController,
                        onPageChanged: (int index) {
                          timeEntryController.currentIndex = index;
                          timeEntryController.update();
                        },
                        lastDay: timeEntryController
                                .myTimeEntryMonthModel?.labels?.lastDay
                                .toString() ??
                            '',
                        currentWeek: timeEntryController
                                .myTimeEntryMonthModel?.labels?.thisWeek
                                .toString() ??
                            '',
                        monthly: timeEntryController
                                .myTimeEntryMonthModel?.labels?.thisMonthAverage
                                .toString() ??
                            '',
                      ),
                      CommonLiveTimeCard(
                        totalWeeklyHours: homeController.totalWeeklyHours,
                        completedHours: homeController
                            .userWeeklyWorkLogModel?.labels?.thisWeek
                            .toString(),
                        calenderTitle: homeController.formattedDate,
                        timeTitle: homeController.formattedTime,
                        hour: homeController.hour.toString(),
                        minutes: homeController.minute.toString(),
                        second: homeController.second.toString(),
                        timeLeft: homeController.myLiveTimeEntryModel?.results
                                    ?.isNotEmpty ==
                                true
                            ? homeController.myLiveTimeEntryModel?.results
                                ?.first.totalDuration
                            : null,
                        isOutOfOffice: homeController.isOutOfOffice,
                        isSeverError: homeController.isServerError,
                        isLoading: homeController.isTimeUpdate,
                        isTodayHalfDay: homeController.isTodayHalfDay,
                        lastWeekday: homeController.lastWeekday,
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                  child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 10, bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            timeEntryController.isToday
                                ?  AppString.todayTimeLog
                                :  AppString.previousTimeLog,
                            style: CommonText.style500S17.copyWith(
                              color: AppColors.greyyDark,
                            ),
                          ),
                          Spacer(),
                          Visibility(
                            visible: !timeEntryController.isToday,
                            child: CustomTextButton(
                              txt: AppString.clearAll,
                              onpressed: () {
                                timeEntryController.dropdownTodayValue =
                                    'Today';
                                timeEntryController.month =
                                    DateFormat('MM').format(DateTime.now());
                                timeEntryController.year =
                                    DateFormat('yyyy').format(DateTime.now());
                                timeEntryController.isToday = true;
                                timeEntryController.update();
                                timeEntryController.getMyTimeEntry(
                                    isMonthChanged: true);
                              },
                            ),
                          ),
                          Visibility(
                            visible: !timeEntryController.isToday,
                            child: IconButton(
                              style: ButtonStyle(
                                shadowColor:
                                    WidgetStatePropertyAll(AppColors.blackk),
                                elevation: WidgetStatePropertyAll(2),
                                backgroundColor: WidgetStatePropertyAll(
                                  AppColors.yelloww,
                                ),
                              ),
                              icon: Icon(
                                Icons.calendar_month_outlined,
                              ),
                              iconSize: 20,
                              color: AppColors.whitee,
                              onPressed: () {
                                int selectedYear =
                                    int.parse(timeEntryController.year);
                                int selectedMonth =
                                    int.parse(timeEntryController.month);

                                showMonthPicker(
                                  context: context,
                                  initialDate:
                                      DateTime(selectedYear, selectedMonth),
                                  monthPickerDialogSettings:
                                      MonthPickerDialogSettings(
                                    headerSettings: PickerHeaderSettings(
                                      headerBackgroundColor: AppColors.yelloww,
                                    ),
                                    actionBarSettings: PickerActionBarSettings(
                                      cancelWidget: Text(
                                        AppString.cancel,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: CommonText.style500S15
                                            .copyWith(color: AppColors.blackk),
                                      ),
                                      confirmWidget: Text(
                                        AppString.ok,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: CommonText.style500S15
                                            .copyWith(color: AppColors.blackk),
                                      ),
                                    ),
                                    dateButtonsSettings:
                                        PickerDateButtonsSettings(
                                      unselectedMonthsTextColor:
                                          AppColors.blackk,
                                      selectedMonthBackgroundColor:
                                          AppColors.yelloww,
                                    ),
                                  ),
                                ).then((date) {
                                  if (date != null) {
                                    timeEntryController.month =
                                        date.month.toString().padLeft(2, '0');
                                    timeEntryController.year =
                                        date.year.toString();
                                    timeEntryController.update();
                                    timeEntryController.getMyTimeEntry(
                                        isMonthChanged: true);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: timeEntryController.isToday
                          ? (homeController.myLiveTimeEntryModel?.results
                                          ?.isEmpty ==
                                      true ||
                                  homeController
                                          .myLiveTimeEntryModel?.results ==
                                      null)
                              ? Utility.dataNotFound()
                              : ListView.builder(
                                  itemCount: homeController
                                      .myLiveTimeEntryModel?.results?.length,
                                  itemBuilder: (context, index) {
                                    var item = homeController
                                        .myLiveTimeEntryModel?.results?[index];
                                    String? logInTime = '';
                                    String? logOutTime = '';
                                    var logs = item?.log;
                                    if (logs != null) {
                                      // Track if we've found the first 'MMI' and 'MMO'
                                      bool foundFirstMMI = false;
                                      for (var logEntry in logs) {
                                        if (!foundFirstMMI &&
                                            logEntry.punch == 'IN' &&
                                            logEntry.device == 'MMI') {
                                          logInTime = logEntry.time;
                                          foundFirstMMI =
                                              true; // Stop looking for 'MMI'
                                        } else if (logEntry.punch == 'OUT' &&
                                            logEntry.device == 'MMO') {
                                          logOutTime = logEntry.time;
                                        }
                                        // If both are found, exit early
                                      }
                                    }
                                    return TimeEntryLogList(
                                      onTap: () {
                                        Get.to(
                                          TimeEntryTileDetails(
                                            log: const [],
                                            logToday: item?.log ?? [],
                                            total: ('${item?.totalDuration}'),
                                            gamezoneDuration: item?.gamezoneDuration ??
                                                '00:00:00',
                                          ),
                                        );
                                      },
                                      date: Global.formatDate(
                                          item?.logDate ?? '2024-05-01'),
                                      inTime: logInTime,
                                      outTime: logOutTime,
                                      gameZone: item?.gamezoneDuration,
                                      total: ('${item?.totalDuration}'),
                                    );
                                  },
                                )
                          : PagedListView<int, Result>(
                              pagingController:
                                  timeEntryController.pagingController,
                              padding: EdgeInsets.only(bottom: 10.h),
                              builderDelegate:
                                  PagedChildBuilderDelegate<Result>(
                                firstPageProgressIndicatorBuilder: (_) =>
                                    Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Utility.circleProcessIndicator(),
                                ),
                                newPageErrorIndicatorBuilder: (_) =>
                                    Utility.dataNotFound(),
                                firstPageErrorIndicatorBuilder: (_) =>
                                    Utility.dataNotFound(),
                                noItemsFoundIndicatorBuilder: (_) =>
                                    Utility.dataNotFound(),
                                newPageProgressIndicatorBuilder: (_) =>
                                    Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Utility.circleProcessIndicator(),
                                ),
                                animateTransitions: true,
                                itemBuilder:
                                    (BuildContext context, item, int index) {
                                  String? logInTime = '';
                                  String? logOutTime = '';
                                  var logs = item.log;
                                  if (logs != null) {
                                    // Track if we've found the first 'MMI' and 'MMO'
                                    bool foundFirstMMI = false;
                                    for (var logEntry in logs) {
                                      if (!foundFirstMMI &&
                                          logEntry.punch == 'IN' &&
                                          logEntry.device == 'MMI') {
                                        logInTime = logEntry.time;
                                        foundFirstMMI =
                                            true; // Stop looking for 'MMI'
                                      } else if (logEntry.punch == 'OUT' &&
                                          logEntry.device == 'MMO') {
                                        logOutTime = logEntry.time;
                                      }
                                      // If both are found, exit early
                                    }
                                  }
                                  return TimeEntryLogList(
                                    onTap: () {
                                      Get.to(
                                        TimeEntryTileDetails(
                                          log: item.log ?? [],
                                          total:
                                              item.totalDuration ?? '00:00:00',
                                          gamezoneDuration: item.gamezoneDuration ??
                                              '00:00:00',
                                        ),
                                      );
                                    },
                                    date: Global.formatDate(
                                      item.logDate ?? '2024-05-01',
                                    ),
                                    inTime: logInTime,
                                    outTime: logOutTime,
                                    gameZone: item.gamezoneDuration,
                                    total: item.totalDuration ?? '00:00:00',
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
