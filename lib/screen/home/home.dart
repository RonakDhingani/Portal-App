// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/common_chart.dart';
import 'package:inexture/model/team_status_model.dart';
import 'package:inexture/screen/home/defaulter_count.dart';
import 'package:inexture/screen/home/home_profile_ui_container.dart';
import 'package:inexture/screen/home/middle_container.dart';
import 'package:inexture/screen/home/pending_EOD.dart';

import '../../common_widget/app_string.dart';
import '../../common_widget/common_upper_container.dart';
import '../../common_widget/global_value.dart';
import '../../common_widget/text.dart';
import '../../controller/home_controller.dart';
import '../../controller/main_home_controller.dart';
import '../../routes/app_pages.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  @override
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        var mainHomeController = Get.find<MainHomeController>();
        var userDetails =
            Get.find<MainHomeController>().userProfileDetailsModel?.data;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            onRefresh: () async {
              if (userDetails == null) {
                mainHomeController.getUserProfileDetails();
              }
              mainHomeController.userService.getPremiumUserNames();
              mainHomeController.getPendingWorklogTimeEntry();
              mainHomeController.getDefaulterCount();
              homeController.apiCalls();
              homeController.update();
              await Future.delayed(Duration(seconds: 1));
              await homeController.player.setVolume(1.0);
              await homeController.player.play(
                AssetSource("sounds/water_drip.mp3"),
              );
            },
            color: AppColors.yelloww,
            child: Stack(
              children: [
                UpperContainer(
                  isProfile: false,
                  isTodayBDay: homeController.todayBirthdayModel?.data
                          ?.any((details) => details.id == userId) ??
                      false,
                  firstChild: HomeProfileUiContainer(
                    isLoading: mainHomeController.isLoading,
                    imgUrl: '${userDetails?.image}',
                    firstName: userDetails?.firstName ?? '\t',
                    lastName: userDetails?.lastName ?? '\t',
                    designation:
                        userDetails?.userdetails?.designationName?.name ?? '\t',
                    onTap: () {
                      mainHomeController.currentIndex = 3;
                      mainHomeController.update();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 85.h),
                  child: MiddleContainer(
                    isDefaulter: mainHomeController.isLoading,
                    isTodayHalfDay: homeController.isTodayHalfDay,
                    lastWeekday: homeController.lastWeekday,
                    isLoading: homeController.isTimeUpdate,
                    quotes: homeController.quotes,
                    isEOM: homeController.isEOM,
                    isTodayBDay: homeController.isBirthDay,
                    isWorkAnniv: homeController.isAnniv,
                    isUpcomingBDay: homeController.isUpcomingBirthDay,
                    isTeamStatus: homeController.isTeamStatus,
                    teamStrength: homeController.teamStatusModel?.totalEmployee
                            .toString() ??
                        "",
                    eomModel: homeController.eomModel,
                    todayBirthDayModel: homeController.todayBirthdayModel,
                    upcomingBirthdayModel: homeController.upcomingBirthdayModel,
                    todayWorkAnnivModel: homeController.todayWorkAnnivModel,
                    isFromHome: true,
                    isOutOfOffice: homeController.isOutOfOffice,
                    isServerError: homeController.isServerError,
                    totalWeeklyHours: homeController.totalWeeklyHours,
                    completedHours: homeController
                        .userWeeklyWorkLogModel?.labels?.thisWeek
                        .toString(),
                    currentPage: homeController.currentPage,
                    onPageChanged: (index) {
                      homeController.currentPage.value = index;
                      homeController.update();
                    },
                    controller: homeController.controller,
                    hour: homeController.hour.toString(),
                    minute: homeController.minute.toString(),
                    second: homeController.second.toString(),
                    logDate: homeController.formattedDate,
                    logTime: homeController.formattedTime,
                    timeLeft: homeController
                                .myLiveTimeEntryModel?.results?.isNotEmpty ==
                            true
                        ? homeController
                            .myLiveTimeEntryModel?.results?.first.totalDuration
                        : null,
                    isTimeUpdate: homeController.isTimeUpdate,
                    myLeave: homeController
                            .myDashboardLeaveModel?.labels?.allocatedLeave
                            ?.toInt()
                            .toString() ??
                        '0',
                    todayLeave: homeController
                            .employeeOnLeaveTodayModel?.labels?.total
                            .toString() ??
                        '0',
                    upcomingLeave: homeController
                            .upcomingLeaveModel?.labels?.total
                            .toString() ??
                        '0',
                    wfh: homeController.workFromHomeTodayModel?.labels?.total
                            .toString() ??
                        '0',
                    isMyLeave: homeController.isMyLeave,
                    isTodayLeave: homeController.isTodayLeave,
                    isUpcoming: homeController.isUpcoming,
                    isWFH: homeController.isWFH,
                    onTapMyLeave: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: AlertDialog(
                              insetPadding: EdgeInsets.all(30),
                              contentPadding: EdgeInsets.only(
                                  left: 20, top: 20, right: 20, bottom: 0),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              title: Center(
                                  child: Text(
                                AppString.leaveDetails,
                                style: CommonText.style500S16.copyWith(
                                  color: AppColors.blackk,
                                ),
                              )),
                              content: SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 50,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    var allocatedLeave = homeController
                                            .myDashboardLeaveModel
                                            ?.labels
                                            ?.allocatedLeave
                                            .toString() ??
                                        '0';
                                    var usedLeave = homeController
                                        .myDashboardLeaveModel
                                        ?.labels
                                        ?.usedLeave;
                                    var remainingLeave = homeController
                                            .myDashboardLeaveModel
                                            ?.labels
                                            ?.remainingLeave
                                            .toString() ??
                                        '0';
                                    var lossOfPay = homeController
                                            .myDashboardLeaveModel
                                            ?.labels
                                            ?.lossOfPay ??
                                        '0';
                                    String leaveType;
                                    Object leaveValue;
                                    switch (index) {
                                      case 0:
                                        leaveType = AppString.total;
                                        leaveValue = allocatedLeave;

                                        break;
                                      case 1:
                                        leaveType = AppString.used;
                                        leaveValue = usedLeave.toString();
                                        break;
                                      case 2:
                                        leaveType = AppString.remaining;
                                        leaveValue = remainingLeave;
                                        break;
                                      case 3:
                                        leaveType = AppString.lop;
                                        leaveValue = lossOfPay.toString();
                                        break;
                                      default:
                                        leaveType = '';
                                        leaveValue = 0;
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Card(
                                        surfaceTintColor:
                                            Global.getColorLeaves(leaveType)
                                                .withOpacity(0.4),
                                        child: Center(
                                          child: Text(
                                            '$leaveValue $leaveType',
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style:
                                                CommonText.style500S15.copyWith(
                                              color: Global.getColorLeaves(
                                                  leaveType),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              actionsPadding: EdgeInsets.zero,
                            ),
                          );
                        },
                      );
                    },
                    onTapTodayLeave: () {
                      Get.toNamed(Routes.leaveToday, arguments: {
                        'leaveToday': homeController.employeeOnLeaveTodayModel
                      });
                    },
                    onTapUpcomingLeave: () {
                      Get.toNamed(Routes.upcomingLeave, arguments: {
                        'upcomingLeave': homeController.upcomingLeaveModel
                      });
                    },
                    onTapWorkFromHome: () {
                      Get.toNamed(Routes.workFromHomeToday, arguments: {
                        'workFromHomeData':
                            homeController.workFromHomeTodayModel
                      });
                    },
                    onTeamStatus: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: AlertDialog(
                              backgroundColor:
                                  AppColors.whitee.withOpacity(0.5),
                              insetPadding: EdgeInsets.all(20),
                              contentPadding: EdgeInsets.only(
                                  left: 10, top: 20, right: 10, bottom: 20),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              title: Center(
                                child: Text(
                                  AppString.teamStatus,
                                  style: CommonText.style500S20,
                                ),
                              ),
                              content: SizedBox(
                                  height: 350.h,
                                  child: CommonChart(
                                    teamData: homeController.teamStatusModel ??
                                        TeamStatusModel(),
                                  )),
                              actionsPadding: EdgeInsets.zero,
                            ),
                          );
                        },
                      );
                    },
                    onDefaulter: () {
                      Get.to(
                        () => DefaulterCount(
                          totalDefaulterCount: mainHomeController
                                  .defaulterCountModel?.totalDefaulterCount ??
                              0,
                          categoryWiseCounts: mainHomeController
                                  .defaulterCountModel?.categoryWiseCounts ??
                              [],
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: mainHomeController.pendingWorklogTimeEntryModel
                          ?.pendingWorkLogs?.isNotEmpty ==
                      true,
                  child: Positioned(
                    right: 10.w,
                    top: 30.h,
                    child: IconButton(
                      onPressed: () {
                        Get.to(
                          PendingEod(
                            pendingEOD: mainHomeController
                                    .pendingWorklogTimeEntryModel
                                    ?.pendingWorkLogs ??
                                [],
                          ),
                        );
                      },
                      icon: Badge.count(
                        count: mainHomeController.pendingWorklogTimeEntryModel
                                ?.pendingWorkLogs?.length ??
                            0,
                        backgroundColor: AppColors.redd,
                        textStyle: CommonText.style600S12,
                        child: Icon(
                          Icons.notifications,
                          color: AppColors.whitee,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
