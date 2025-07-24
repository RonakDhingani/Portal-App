// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widget/common_live_time_card.dart';
import 'home_cards/custom_leave_workfromhome_card.dart';
import 'home_cards/custom_second_details_home_card.dart';
import 'home_cards/custom_third_details_home_card.dart';

class MiddleContainer extends StatelessWidget {
  MiddleContainer({
    super.key,
    this.hour,
    this.minute,
    this.second,
    this.logTime,
    this.logDate,
    this.timeLeft,
    required this.myLeave,
    required this.todayLeave,
    required this.upcomingLeave,
    required this.wfh,
    required this.isMyLeave,
    required this.isTodayLeave,
    required this.isUpcoming,
    required this.isWFH,
    required this.isTimeUpdate,
    this.isOutOfOffice,
    required this.onTapMyLeave,
    required this.onTapTodayLeave,
    required this.onTapUpcomingLeave,
    required this.onTapWorkFromHome,
    this.isFromHome = false,
    this.completedHours,
    this.currentPage,
    this.onPageChanged,
    required this.isEOM,
    required this.isTodayBDay,
    required this.isWorkAnniv,
    required this.isUpcomingBDay,
    required this.isTeamStatus,
    required this.isDefaulter,
    required this.isLoading,
    required this.teamStrength,
    this.onTeamStatus,
    this.onDefaulter,
    this.quotes,
    this.controller,
    this.totalWeeklyHours,
    this.eomModel,
    this.todayBirthDayModel,
    this.upcomingBirthdayModel,
    this.todayWorkAnnivModel,
    this.lastWeekday,
    this.isTodayHalfDay,
    this.isServerError,
  });

  final String? logTime;
  final String? logDate;
  final String? timeLeft;
  final String? hour;
  final String? minute;
  final String? second;
  final String myLeave;
  final String todayLeave;
  final String upcomingLeave;
  final String wfh;
  final String? completedHours;
  final bool isMyLeave;
  final bool isTimeUpdate;
  final bool isTodayLeave;
  final bool isUpcoming;
  final bool isWFH;
  final bool isFromHome;
  final bool? isOutOfOffice;
  final bool? isServerError;
  final Function()? onTapMyLeave;
  final Function()? onTapTodayLeave;
  final Function()? onTapUpcomingLeave;
  final Function()? onTapWorkFromHome;
  final Function(int)? onPageChanged;
  final ValueNotifier<int>? currentPage;
  final String teamStrength;
  final bool isEOM;
  final bool isTodayBDay;
  final bool isWorkAnniv;
  final bool isUpcomingBDay;
  final bool isTeamStatus;
  final bool isDefaulter;
  final bool isLoading;
  final bool? isTodayHalfDay;
  final Function()? onTeamStatus;
  final Function()? onDefaulter;
  final String? quotes;
  final PageController? controller;
  var totalWeeklyHours;
  var eomModel;
  var todayBirthDayModel;
  var upcomingBirthdayModel;
  var todayWorkAnnivModel;
  String? lastWeekday;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 50.h, bottom: 60.h),
        child: Column(
          children: [
            CommonLiveTimeCard(
              isTodayHalfDay: isTodayHalfDay,
              lastWeekday: lastWeekday,
              calenderTitle: logDate ?? '',
              timeTitle: logTime ?? '',
              hour: hour ?? '00',
              minutes: minute ?? '00',
              second: second ?? '00',
              timeLeft: timeLeft ?? '',
              isFromHome: isFromHome,
              completedHours: completedHours,
              currentPage: currentPage ?? ValueNotifier<int>(0),
              onPageChanged: onPageChanged,
              isOutOfOffice: isOutOfOffice,
              totalWeeklyHours: totalWeeklyHours,
              isLoading: isLoading,
              isSeverError: isServerError,
            ),
            Flexible(
              child: PageView(
                controller: controller,
                scrollDirection: Axis.vertical,
                onPageChanged: (value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isScrollAlready', true);
                },
                children: [
                  CustomLeaveWorkFromHomeCard(
                    myLeave: myLeave,
                    todayLeave: todayLeave,
                    upcomingLeave: upcomingLeave,
                    wfh: wfh,
                    isMyLeave: isMyLeave,
                    isTodayLeave: isTodayLeave,
                    isUpcoming: isUpcoming,
                    isWFH: isWFH,
                    onTapMyLeave: onTapMyLeave,
                    onTapTodayLeave: onTapTodayLeave,
                    onTapUpcomingLeave: onTapUpcomingLeave,
                    onTapWorkFromHome: onTapWorkFromHome,
                  ),
                  CustomSecondDetailsHomeCard(
                    isEOM: isEOM,
                    isTodayBDay: isTodayBDay,
                    isTeamStatus: isTeamStatus,
                    isDefaulter: isDefaulter,
                    teamStrength: teamStrength,
                    eomModel: eomModel,
                    todayBirthdayModel: todayBirthDayModel,
                    onTeamStatus: onTeamStatus,
                    onDefaulter: onDefaulter,
                  ),
                  CustomThirdDetailsHomeCard(
                    todayWorkAnnivModel: todayWorkAnnivModel,
                    upcomingBirthdayModel: upcomingBirthdayModel,
                    isWorkAnniv: isWorkAnniv,
                    isUpcomingBDay: isUpcomingBDay,
                    quotes: quotes,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
