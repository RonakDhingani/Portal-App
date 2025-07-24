// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';

class CommonLiveTimeCard extends StatelessWidget {
  CommonLiveTimeCard({
    super.key,
    required this.calenderTitle,
    required this.timeTitle,
    required this.hour,
    required this.minutes,
    required this.second,
    this.timeLeft,
    this.isFromHome = false,
    this.completedHours,
    this.currentPage,
    this.onPageChanged,
    this.isOutOfOffice,
    this.isSeverError,
    this.isLoading,
    this.isTodayHalfDay,
    this.totalWeeklyHours,
    this.player,
    this.lastWeekday,
  });

  String calenderTitle;
  String timeTitle;
  String hour;
  String minutes;
  String second;
  String? timeLeft;
  bool isFromHome;
  bool? isOutOfOffice;
  bool? isSeverError;
  bool? isLoading;
  bool? isTodayHalfDay;
  String? completedHours;
  var totalWeeklyHours;
  String overTime = '00h 00m 00s';
  ValueNotifier<int>? currentPage;
  Function(int)? onPageChanged;
  PageController pageController = PageController();
  double valueSecond = 0.2;
  String? formattedExpectedTime;
  DateTime currentTime = DateTime.now();
  var fridayEndAround = '';
  var fridayLastHourLeft = '';
  var player;
  String? lastWeekday;
  String? hoursWarning;

  String todayWeekDay() {
    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday"
    ];

    int day = DateTime.now().weekday;
    if (day >= 1 && day <= 5) {
      return weekdays[day - 1];
    } else {
      return "Weekend";
    }
  }

  Duration parseTime(String time) {
    if (time.isEmpty) return Duration.zero;
    List<String> parts = time.split(':');
    if (parts.length != 3) return Duration.zero;
    try {
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(parts[2]);
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
      return Duration.zero;
    }
  }

  String calculateRemainingTime() {
    Duration completedTime = parseTimeString(completedHours ?? "0:00");
    Duration remainingTime = totalWeeklyHours - completedTime;

    String timeString = '$hour:$minutes:$second';
    Duration timeLeftDuration = parseTime(timeString);

    Duration targetTimeDuration = (lastWeekday == todayWeekDay())
        ? remainingTime
        : parseTime(isTodayHalfDay == false ? "08:20:00" : "04:20:00");

    if (timeLeftDuration >= targetTimeDuration) {
      if (timeLeftDuration <= Duration(hours: 7)) {
        if (isTodayHalfDay == true) {
          hoursWarning = AppString.todayIsYourHalfDay;
        } else {
          hoursWarning =
              AppString.youStillNeedToComplete7HourAsPerCompanyPolicy;
        }
      } else {
        hoursWarning = "";
      }
      return lastWeekday == todayWeekDay()
          ? AppString.yourWeeklyTargetHourIsDone
          : AppString.yourDailyTargetHourIsDone;
    }

    Duration remainingDuration = targetTimeDuration - timeLeftDuration;

    int remainingHours = remainingDuration.inHours;
    int remainingMinutes = remainingDuration.inMinutes.remainder(60);
    int remainingSeconds = remainingDuration.inSeconds.remainder(60);

    DateTime expectedCompletionTime = currentTime.add(remainingDuration);
    formattedExpectedTime =
        DateFormat('hh:mm a').format(expectedCompletionTime);

    return isLoading == true
        ? AppString.d0HoursLeftKeepGoing
        : '$remainingHours:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')} ${remainingHours == 00 ? ((remainingMinutes == 00 && remainingHours == 00) ? "second" : "minutes") : "hours"} left, keep going!';
  }

  String getRemainingTime(String completeHours) {
    Duration completedTime = parseTimeString(completeHours);

    if (isCompletedTimeGreaterOrEqual(completedTime, totalWeeklyHours)) {
      return overTime;
    }

    Duration remainingTime = totalWeeklyHours - completedTime;

    String timeString = '$hour:$minutes:$second';
    Duration timeLeftDuration = parseTime(timeString);

    int remainingHours = remainingTime.inHours;
    int remainingMinutes = remainingTime.inMinutes.remainder(60);
    int remainingSeconds = remainingTime.inSeconds.remainder(60);

    if (lastWeekday == todayWeekDay()) {
      var subtractHours = int.parse(hour);
      var subtractMinutes = int.parse(minutes);
      var subtractSeconds = int.parse(second);

      Duration adjustment = Duration(
        hours: subtractHours,
        minutes: subtractMinutes,
        seconds: subtractSeconds,
      );
      Duration remaining = Duration(
        hours: remainingHours,
        minutes: remainingMinutes,
        seconds: remainingSeconds,
      );

      Duration finalDuration = remaining - adjustment;

      int adjustedHours = finalDuration.inHours;
      int adjustedMinutes = finalDuration.inMinutes.remainder(60);
      int adjustedSeconds = finalDuration.inSeconds.remainder(60);

      fridayEndAround =
          DateFormat('hh:mm a').format(currentTime.add(finalDuration));
      if (timeLeftDuration >= remainingTime) {
        return AppString.weeklyTargetHourIsDone;
      }
      fridayLastHourLeft =
          '${adjustedHours}h ${adjustedMinutes}m ${adjustedSeconds}s';
    }

    return '${remainingHours}h ${remainingMinutes}m ${remainingSeconds}s';
  }

  Duration parseTimeString(String timeString) {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    final hourMatch = RegExp(r'(\d+)h').firstMatch(timeString);
    final minuteMatch = RegExp(r'(\d+)m').firstMatch(timeString);
    final secondMatch = RegExp(r'(\d+)s').firstMatch(timeString);

    if (hourMatch != null) {
      hours = int.parse(hourMatch.group(1)!);
    }
    if (minuteMatch != null) {
      minutes = int.parse(minuteMatch.group(1)!);
    }
    if (secondMatch != null) {
      seconds = int.parse(secondMatch.group(1)!);
    }

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  bool isCompletedTimeGreaterOrEqual(
      Duration completedTime, Duration totalHours) {
    // Compare hours first
    if (completedTime.inHours > totalHours.inHours) {
      return true;
    } else if (completedTime.inHours == totalHours.inHours) {
      // Compare minutes if hours are equal
      if (completedTime.inMinutes.remainder(60) >
          totalHours.inMinutes.remainder(60)) {
        return true;
      } else if (completedTime.inMinutes.remainder(60) ==
          totalHours.inMinutes.remainder(60)) {
        // Compare seconds if both hours and minutes are equal
        if (completedTime.inSeconds.remainder(60) >=
            totalHours.inSeconds.remainder(60)) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    String formattedHours =
        '${totalWeeklyHours.inHours}.${totalWeeklyHours.inMinutes.remainder(60).toString().padLeft(2, '0')}';

    return Card(
      surfaceTintColor: AppColors.whitee,
      margin: EdgeInsets.all(5),
      elevation: 2,
      color: AppColors.whitee,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Stack(
          children: [
            Visibility(
              visible: isAdminUser == false,
              replacement: Center(
                child: Text(
                  AppString.adminDashboardComingSoon,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: CommonText.style500S15.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
              ),
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                physics: isFromHome && users.contains(fireUserFullName)
                    ? ScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                onPageChanged: (isFromHome && users.contains(fireUserFullName))
                    ? onPageChanged
                    : null,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          CommonText.normalIconText(
                            icon: TablerIcons.calendar,
                            title: calenderTitle,
                          ),
                          Spacer(),
                          // if(timeTitle.isEmpty)
                          CommonText.normalIconText(
                            icon: Icons.watch_later_outlined,
                            title: timeTitle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customTimeBoxContainer(
                            time: hour,
                            isOutOfOffice: isOutOfOffice,
                            isRefreshing: (hour == "00" &&
                                    minutes == "00" &&
                                    second == "00")
                                ? true
                                : false,
                          ),
                          customTimeBoxContainer(
                            time: minutes,
                            isOutOfOffice: isOutOfOffice,
                            isRefreshing: (hour == "00" &&
                                    minutes == "00" &&
                                    second == "00")
                                ? true
                                : false,
                          ),
                          customTimeBoxContainer(
                            time: second,
                            isOutOfOffice: isOutOfOffice,
                            isRefreshing: (hour == "00" &&
                                    minutes == "00" &&
                                    second == "00")
                                ? true
                                : false,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.general10AMTo07PM,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: CommonText.style500S15.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: timeLeft != null && timeLeft!.isNotEmpty,
                        replacement: isSeverError == true
                            ? AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    AppString
                                        .errorLoadingDataFromServerPleaseContactSystemAdministrator,
                                    textAlign: TextAlign.center,
                                    textStyle: CommonText.style500S15.copyWith(
                                      color: AppColors.redd,
                                    ),
                                    speed: Duration(milliseconds: 100),
                                  ),
                                ],
                                isRepeatingAnimation: false,
                                repeatForever: true,
                              )
                            : isOutOfOffice == true
                                ? AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        AppString.youAreOutOfTheOffice,
                                        textStyle: CommonText.style500S15
                                            .copyWith(color: AppColors.greyy),
                                        speed: Duration(milliseconds: 150),
                                      ),
                                    ],
                                    isRepeatingAnimation: false,
                                    repeatForever: true,
                                  )
                                : SizedBox(
                                    height: 10.h,
                                  ),
                        child: Column(
                          children: [
                            Text(
                              calculateRemainingTime(),
                              style: CommonText.style500S15.copyWith(
                                color: AppColors.blackk,
                              ),
                            ),
                            if (hoursWarning?.isNotEmpty == true)
                              AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    "$hoursWarning",
                                    textStyle: CommonText.style500S15,
                                    textAlign: TextAlign.center,
                                    colors: [
                                      AppColors.redd,
                                      AppColors.greyy,
                                      AppColors.redd,
                                    ],
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                repeatForever: true,
                              ),
                            if (formattedExpectedTime != null)
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  "${AppString.endsAround} $formattedExpectedTime",
                                  style: CommonText.style500S14.copyWith(
                                    color: AppColors.greyy,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isFromHome && users.contains(fireUserFullName),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CommonText.normalIconText(
                            icon: Icons.watch_later_outlined,
                            title: AppString.weeklyTimeLog,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    AppString.totalHours,
                                    style: CommonText.style500S15
                                        .copyWith(color: AppColors.blues),
                                  ),
                                  Text(
                                    "${formattedHours}h",
                                    style: CommonText.style600S15
                                        .copyWith(color: AppColors.blackk),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppString.completedHours,
                                    style: CommonText.style500S15
                                        .copyWith(color: AppColors.greenn),
                                  ),
                                  Text(
                                    completedHours.toString(),
                                    style: CommonText.style600S15
                                        .copyWith(color: AppColors.blackk),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible: !isCompletedTimeGreaterOrEqual(
                                parseTimeString(completedHours ?? ''),
                                totalWeeklyHours),
                            replacement: Text(
                              AppString.yourWeeklyHoursAreCompleted,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: CommonText.style600S15
                                  .copyWith(color: AppColors.greenn),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppString.remainingHours,
                                  style: CommonText.style500S15
                                      .copyWith(color: AppColors.redd),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  getRemainingTime(completedHours ?? ''),
                                  style: CommonText.style600S15
                                      .copyWith(color: AppColors.blackk),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: (lastWeekday != todayWeekDay() &&
                                fridayLastHourLeft.isNotEmpty == true),
                            child: Text(
                              "${AppString.hoursLeft} ${isLoading == true ? "0h 0m 0s" : fridayLastHourLeft}",
                              style: CommonText.style500S14.copyWith(
                                color: AppColors.greyy,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: lastWeekday != todayWeekDay(),
                            replacement: Text(
                              "${AppString.weeklyEndsAround} $fridayEndAround",
                              style: CommonText.style500S14.copyWith(
                                color: AppColors.greyy,
                              ),
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  '${AppString.theBestWayToGet} $formattedHours ${AppString.hoursInAWeekIsToComplete8HoursPerDay}',
                                  textStyle: CommonText.style500S14,
                                  textAlign: TextAlign.center,
                                  colors: [
                                    AppColors.greyy,
                                    AppColors.blackk,
                                    AppColors.greyy,
                                  ],
                                ),
                              ],
                              isRepeatingAnimation: true,
                              repeatForever: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isFromHome && users.contains(fireUserFullName),
              child: Positioned(
                top: MediaQuery.of(context).size.width * 0.3,
                right: 10,
                child: ValueListenableBuilder<int>(
                  valueListenable: currentPage ?? ValueNotifier<int>(0),
                  builder: (context, value, child) {
                    return Column(
                      children: List.generate(2, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          // Space between dots
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value == index
                                ? AppColors.yelloww
                                : AppColors.greyy,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static customTimeBoxContainer(
      {required String time,
      required bool isRefreshing,
      required bool? isOutOfOffice}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.blueGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: isOutOfOffice == true
          ? Center(
              child: Text(
                time,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: CommonText.style500S15.copyWith(
                  color: AppColors.blackk,
                ),
              ),
            )
          : isRefreshing == true
              ? Utility.shimmerLoading(
                  borderRadius: BorderRadius.circular(5),
                )
              : Center(
                  child: Text(
                    time,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CommonText.style500S15.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                ),
    );
  }
}
