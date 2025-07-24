// ignore_for_file: must_be_immutable, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/controller/task_dashboard_controller.dart';
import 'package:inexture/model/my_task_project_model.dart';
import 'package:inexture/routes/app_pages.dart';
import 'package:inexture/utils/utility.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/app_string.dart';
import '../../common_widget/assigned_project_task.dart';
import '../../common_widget/common_app_bar.dart';
import 'build_day_container.dart';

class TaskDashboardScreen extends GetView<TaskDashboardController> {
  TaskDashboardScreen({
    super.key,
    this.isFromTab = false,
  });

  final bool isFromTab;

  @override
  final TaskDashboardController controller = Get.put(TaskDashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDashboardController>(builder: (taskDashboardCtrl) {
      return Scaffold(
        appBar: CommonAppBar.commonAppBar(
          context: context,
          isButtonHide: isFromTab == true ? true : false,
          title: AppString.taskDashBoard,
          widget: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppColors.whitee,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    actionsPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 30,
                      top: 0,
                    ),
                    content: SizedBox(
                      height: 290.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          List<String> tags = [
                            'P',
                            'W',
                            'H',
                            'L',
                            'W-L',
                            '',
                            ''
                          ];
                          List<String> titles = [
                            'Pending',
                            'Weekend',
                            'Holiday',
                            'On Leave',
                            'Worked Leave',
                            'Done',
                            'Less Hours'
                          ];
                          List<Color> colors = [
                            AppColors.brownn,
                            AppColors.purplee,
                            AppColors.yellowLight,
                            AppColors.blues,
                            AppColors.orangee,
                            AppColors.greenn,
                            AppColors.redd
                          ];
                          String tag = tags[index];
                          String title = titles[index];
                          Color clr = colors[index];

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp,
                                    ),
                                    margin: EdgeInsets.only(right: 5.sp),
                                    decoration: BoxDecoration(
                                      color: clr,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      tag,
                                      style: CommonText.style500S15,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text(
                                    title,
                                    style: CommonText.style500S15.copyWith(
                                      color: AppColors.blackk,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
            tooltip: AppString.infoAboutTag,
            icon: Icon(
              Icons.info_outline,
              color: AppColors.whitee,
            ),
          ),
        ),
        body: taskDashboardCtrl.isLoading
            ? Utility.circleProcessIndicator()
            : Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TableCalendar(
                          firstDay: DateTime.utc(2023, 6, 31),
                          lastDay: DateTime.utc(2026, 1, 1),
                          focusedDay: taskDashboardCtrl.focusedDay,
                          calendarFormat: taskDashboardCtrl.calendarFormat,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          selectedDayPredicate: (day) {
                            return isSameDay(
                                taskDashboardCtrl.selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            DateTime currentDate = DateTime.now();
                            DateTime startOfWeek = currentDate.subtract(
                              Duration(
                                days: currentDate.weekday - 1,
                              ),
                            );
                            DateTime endOfWeek = startOfWeek.add(
                              Duration(
                                days: 6,
                              ),
                            );
                            bool isThisMonth =
                                selectedDay.isAtSameMomentAs(focusedDay);
                            bool isWeekend =
                                selectedDay.weekday == DateTime.saturday ||
                                    selectedDay.weekday == DateTime.sunday;

                            bool hasWeekendThisWeek = (selectedDay
                                        .isAfter(startOfWeek) ||
                                    selectedDay
                                        .isAtSameMomentAs(startOfWeek)) &&
                                (selectedDay.isBefore(endOfWeek) ||
                                    selectedDay.isAtSameMomentAs(endOfWeek));
                            if (isThisMonth) {
                              if (!isWeekend ||
                                  selectedDay.isBefore(currentDate) ||
                                  selectedDay.isAtSameMomentAs(currentDate) ||
                                  (hasWeekendThisWeek &&
                                      (selectedDay.isBefore(startOfWeek) ||
                                          selectedDay.isAtSameMomentAs(
                                              startOfWeek)))) {
                                if (selectedDay.isBefore(currentDate) ||
                                    selectedDay.isAtSameMomentAs(currentDate)) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(selectedDay);
                                  if (!taskDashboardCtrl.isLoadingDateWise) {
                                    Utility.transparentDialog(
                                      date: formattedDate,
                                      onTap: () {
                                        Get.back();
                                        Get.toNamed(Routes.addWorkLog,
                                            arguments: {
                                              'date': formattedDate,
                                            })?.then((value) {
                                          if (value != null) {
                                            taskDashboardCtrl
                                                .getProjectMyWorkLogList(
                                              isShowLoading: true,
                                            );
                                          }
                                        });
                                      },
                                    );
                                    taskDashboardCtrl
                                        .getProjectTasksDetailsDateWise(
                                      date: formattedDate,
                                    );
                                  }
                                }
                              }
                            }
                          },
                          onPageChanged: (focusedDay) {
                            taskDashboardCtrl.focusedDay = focusedDay;
                            taskDashboardCtrl.month =
                                focusedDay.month.toString();
                            taskDashboardCtrl.year = focusedDay.year.toString();
                            taskDashboardCtrl.update();
                            taskDashboardCtrl.getProjectMyWorkLogList(
                              isShowLoading: true,
                            );
                          },
                          onHeaderTapped: taskDashboardCtrl
                                  .isFocusedDayInCurrentMonth()
                              ? (focusedDay) {}
                              : (focusedDay) {
                                  taskDashboardCtrl.focusedDay = DateTime.now();
                                  taskDashboardCtrl.update();
                                },
                          calendarBuilders: CalendarBuilders(
                            dowBuilder: (context, day) {
                              final text = DateFormat.E().format(day);
                              return Center(
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    color: AppColors.greyyDark.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            defaultBuilder: (context, day, focusedDay) {
                              String? totalHours = taskDashboardCtrl
                                  .calculateTotalHours(day, taskDashboardCtrl);
                              Color bgColor;
                              if (totalHours == null) {
                                bgColor = AppColors.transparent;
                              } else if (totalHours == "W") {
                                bgColor = AppColors.purplee;
                              } else {
                                bgColor = taskDashboardCtrl
                                    .calculateBackgroundColor(totalHours);
                              }
                              return BuildDayContainer(
                                day: day,
                                workLeaved:
                                    (taskDashboardCtrl.isHalfDay == true &&
                                            taskDashboardCtrl
                                                    .workLeaved?.isNotEmpty ==
                                                true)
                                        ? taskDashboardCtrl.workLeaved
                                        : '',
                                isLoading: taskDashboardCtrl.isCalendarLoading,
                                totalHours: totalHours,
                                bgColor: bgColor,
                                textColor: AppColors.whitee,
                              );
                            },
                            todayBuilder: (context, day, focusedDay) {
                              String? totalHours = taskDashboardCtrl
                                  .calculateTotalHours(day, taskDashboardCtrl);
                              return BuildDayContainer(
                                day: day,
                                isLoading: taskDashboardCtrl.isCalendarLoading,
                                totalHours:
                                    totalHours == '0' ? null : totalHours,
                                bgColor: taskDashboardCtrl
                                    .calculateBackgroundColor(totalHours ?? ''),
                                textColor: AppColors.whitee,
                                isToday: true,
                              );
                            },
                            selectedBuilder: (context, day, focusedDay) {
                              return BuildDayContainer(
                                day: day,
                                isLoading: false,
                                bgColor: AppColors.yelloww,
                                textColor: AppColors.whitee,
                              );
                            },
                            outsideBuilder: (context, day, focusedDay) {
                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: AppColors.greyy.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              );
                            },
                          ),
                          headerStyle: HeaderStyle(
                            titleCentered: true,
                            titleTextStyle: CommonText.style500S18.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                          availableCalendarFormats: const {
                            CalendarFormat.month: 'Month',
                          },
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 15, bottom: 10, left: 10),
                          child: Text(
                            AppString.assignedProjectsTask,
                            style: CommonText.style500S17.copyWith(
                              color: AppColors.greyyDark,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: PagedListView<int, Results>(
                              pagingController: taskDashboardCtrl
                                  .taskController.pagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<Results>(
                                firstPageProgressIndicatorBuilder: (_) =>
                                    Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Utility.circleProcessIndicator(),
                                ),
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
                                itemBuilder: (context, item, index) {
                                  var id = item.id;
                                  return AssignedProjectTask(
                                    onTap: () {
                                      Get.toNamed(Routes.projectTaskDetails,
                                          arguments: {'id': id})?.then((value) {
                                        if (value != null) {
                                          taskDashboardCtrl
                                              .getProjectMyWorkLogList(
                                                  isShowLoading: true);
                                        }
                                      });
                                    },
                                    projectName: item.projectName.toString(),
                                    taskName: item.taskName.toString(),
                                    code: item.projectCode.toString(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: isFromTab == true
            ? null
            : FloatingActionButton(
                onPressed: () {
                  DateTime currentDate = DateTime.now();
                  Get.toNamed(Routes.addWorkLog,
                          arguments: {'date': currentDate.toString()})
                      ?.then((value) {
                    if (value != null) {
                      Utility.showFlushBar(text: value);
                      taskDashboardCtrl.getProjectMyWorkLogList(
                          isShowLoading: true);
                    }
                  });
                },
                backgroundColor: AppColors.yelloww,
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: AppColors.blackk,
                ),
              ),
      );
    });
  }
}
