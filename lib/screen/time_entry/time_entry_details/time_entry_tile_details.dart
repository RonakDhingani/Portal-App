import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/model/my_live_time_entry_model.dart' as liveModel;
import 'package:inexture/screen/time_entry/time_entry_details/component/time_entry_row.dart';
import 'package:inexture/utils/utility.dart';
import 'package:intl/intl.dart';

import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../model/my_time_entry_month_model.dart' as monthModel;

class TimeEntryTileDetails extends StatefulWidget {
  const TimeEntryTileDetails({
    super.key,
    required this.log,
    required this.total,
    required this.gamezoneDuration,
    this.logToday,
  });

  final List<monthModel.Log> log;
  final String total;
  final String gamezoneDuration;
  final List<liveModel.Log>? logToday;

  @override
  State<TimeEntryTileDetails> createState() => _TimeEntryTileDetailsState();
}

class _TimeEntryTileDetailsState extends State<TimeEntryTileDetails> {
  bool isLoading = false;
  bool showOriginal = true;
  List<monthModel.Log> mainInLogs = [];
  List<monthModel.Log> mainOutLogs = [];
  List<monthModel.Log> pantry1InLogs = [];
  List<monthModel.Log> pantry1OutLogs = [];
  List<monthModel.Log> pantry2InLogs = [];
  List<monthModel.Log> pantry2OutLogs = [];
  List<String> mainInLogTime = [];
  List<String> mainOutLogTime = [];
  List<String> pantry1InLogsTime = [];
  List<String> pantry1OutLogsTime = [];
  List<String> pantry2InLogsTime = [];
  List<String> pantry2OutLogsTime = [];
  String? mainBreak;
  String? pantry1Break;
  String? pantry2Break;
  int currentPage = 0;
  PageController? pageController;
  String mainBreakImg =
      "https://img.freepik.com/free-vector/end-workday-concept-illustration_114360-2983.jpg?ga=GA1.1.909543597.1737101669&semt=ais_hybrid&w=740";
  String pantry1Img =
      "https://img.freepik.com/premium-vector/people-eating-food-court-shopping-mall_40816-10.jpg?ga=GA1.1.909543597.1737101669&semt=ais_hybrid&w=740";
  String pantry2Img =
      "https://img.freepik.com/free-vector/cooks-composition-with-indoor-view-modern-restaurant-kitchen-characters-professional-cooks-preparing-meals-vector-illustration_1284-83936.jpg?ga=GA1.1.909543597.1737101669&semt=ais_hybrid&w=740";
  String gameZoneImg =
      "https://img.freepik.com/free-vector/hand-drawn-neon-gaming-photocall_23-2149860761.jpg?ga=GA1.1.909543597.1737101669&semt=ais_hybrid&w=740";
  String totalBreakTimeImg =
      "https://img.freepik.com/free-vector/big-meeting-room-concept-illustration_114360-24589.jpg?ga=GA1.1.909543597.1737101669&semt=ais_hybrid&w=740";

  @override
  void initState() {
    getLogs();
    super.initState();
  }

  void getLogs() {
    setState(() {
      isLoading = true;
    });
    List<monthModel.Log> logsToDisplay = widget.logToday != null
        ? widget.logToday!
            .map((log) => monthModel.Log(
                  device: log.device,
                  time: log.time,
                  punch: log.punch,
                ))
            .toList()
        : widget.log;

    mainInLogs = logsToDisplay
        .where((log) => log.device == 'MMI' && log.punch == 'IN')
        .toList();
    var mainInTime = mainInLogs.map((timeLog) => timeLog.time).join(', ');

    mainOutLogs = logsToDisplay
        .where((log) => log.device == 'MMO' && log.punch == 'OUT')
        .toList();
    var mainOutTime = mainOutLogs.map((timeLog) => timeLog.time).join(', ');

    pantry1InLogs = logsToDisplay
        .where((log) => log.device == 'P1' && log.punch == 'IN')
        .toList();
    var pantry1InTime = pantry1InLogs.map((timeLog) => timeLog.time).join(', ');

    pantry1OutLogs = logsToDisplay
        .where((log) => log.device == 'P1' && log.punch == 'OUT')
        .toList();
    var pantry1OutTime =
        pantry1OutLogs.map((timeLog) => timeLog.time).join(', ');

    pantry2InLogs = logsToDisplay
        .where((log) => log.device == 'P2' && log.punch == 'IN')
        .toList();
    var pantry2InTime = pantry2InLogs.map((timeLog) => timeLog.time).join(', ');

    pantry2OutLogs = logsToDisplay
        .where((log) => log.device == 'P2' && log.punch == 'OUT')
        .toList();
    var pantry2OutTime =
        pantry2OutLogs.map((timeLog) => timeLog.time).join(', ');

    mainInLogTime.add(mainInTime);
    mainOutLogTime.add(mainOutTime);
    pantry1InLogsTime.add(pantry1InTime);
    pantry1OutLogsTime.add(pantry1OutTime);
    pantry2InLogsTime.add(pantry2InTime);
    pantry2OutLogsTime.add(pantry2OutTime);

    print("mainInLogTime $mainInLogTime");
    print("mainOutLogTime $mainOutLogTime");
    print("pantry1InLogsTime $pantry1InLogsTime");
    print("pantry1OutLogsTime $pantry1OutLogsTime");
    print("pantry2InLogsTime $pantry2InLogsTime");
    print("pantry2OutLogsTime $pantry2OutLogsTime");

    mainBreak = mainBreakCalculate(mainInLogTime, mainOutLogTime);
    pantry1Break = pantryBreakCalculate(pantry1OutLogsTime, pantry1InLogsTime);
    pantry2Break = pantryBreakCalculate(pantry2OutLogsTime, pantry2InLogsTime);
    Future.delayed(
      Duration(
        seconds: 1,
      ),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  String pantryBreakCalculate(List<String> inLogs, List<String> outLogs) {
    int totalSeconds = 0;
    final timeFormat = DateFormat("HH:mm:ss");

    List<String> inTimes = inLogs.expand((log) => log.split(', ')).toList();
    List<String> outTimes = outLogs.expand((log) => log.split(', ')).toList();

    int pairCount = min(inTimes.length, outTimes.length);

    for (int i = 0; i < pairCount; i++) {
      final inTimeStr = inTimes[i];
      final outTimeStr = outTimes[i];

      if (inTimeStr.isEmpty || outTimeStr.isEmpty) continue;

      try {
        DateTime inTime = timeFormat.parse(inTimeStr);
        DateTime outTime = timeFormat.parse(outTimeStr);

        if (outTime.isBefore(inTime)) continue;

        totalSeconds += outTime.difference(inTime).inSeconds;
      } catch (e) {
        debugPrint(
            "Parsing error for [$inTimeStr] or [$outTimeStr]: ${e.toString()}");
      }
    }

    return formatSmartDuration(Duration(seconds: totalSeconds));
  }

  String mainBreakCalculate(List<String> inLogs, List<String> outLogs) {
    int totalSeconds = 0;
    final timeFormat = DateFormat("HH:mm:ss");

    List<String> inTimes = inLogs.expand((log) => log.split(', ')).toList();
    List<String> outTimes = outLogs.expand((log) => log.split(', ')).toList();

    int pairCount = min(inTimes.length - 1, outTimes.length);

    for (int i = 0; i < pairCount; i++) {
      final inTimeStr = inTimes[i + 1];
      final outTimeStr = outTimes[i];

      if (inTimeStr.isEmpty || outTimeStr.isEmpty) continue;

      try {
        DateTime inTime = timeFormat.parse(inTimeStr);
        DateTime outTime = timeFormat.parse(outTimeStr);

        totalSeconds += (outTime.difference(inTime).inSeconds).abs();
      } catch (e) {
        debugPrint(
            "Parsing error for [$inTimeStr] or [$outTimeStr]: ${e.toString()}");
      }
    }

    return formatSmartDuration(Duration(seconds: totalSeconds));
  }

  Duration parseTime(String timeStr) {
    final parts =
        timeStr.split(RegExp(r'[hms ]+')).where((e) => e.isNotEmpty).toList();

    int hours = 0, minutes = 0, seconds = 0;

    if (parts.length == 3) {
      hours = int.parse(parts[0]);
      minutes = int.parse(parts[1]);
      seconds = int.parse(parts[2]);
    } else if (parts.length == 2) {
      minutes = int.parse(parts[0]);
      seconds = int.parse(parts[1]);
    } else if (parts.length == 1) {
      seconds = int.parse(parts[0]);
    }

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  String gameFormatDuration(String duration) {
    final parts = duration.split(':');
    if (parts.length != 3) return '0h 0m 0s';

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;

    if (hours == 0 && minutes == 0 && seconds == 0) {
      return '0h 0m 0s';
    }

    final formatted = <String>[];

    if (hours > 0) formatted.add('${hours}h');
    if (minutes > 0 || hours > 0) {
      formatted.add('${minutes.toString().padLeft(2, '0')}m');
    }
    formatted.add('${seconds.toString().padLeft(2, '0')}s');

    return formatted.join(' ');
  }


  String formatSmartDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (duration.inSeconds == 0) {
      return '0h 0m 0s';
    }

    final parts = <String>[];

    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0 || hours > 0) {
      parts.add('${minutes.toString().padLeft(2, '0')}m');
    }
    parts.add('${seconds.toString().padLeft(2, '0')}s');

    return parts.join(' ');
  }


  String sumAllBreaks(String b1, String b2, String b3) {
    Duration total = parseTime(b1) +
        parseTime(b2) +
        parseTime(b3) +
        parseTime(gameFormatDuration(widget.gamezoneDuration));
    return formatSmartDuration(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.commonAppBar(
        context: context,
        title: AppString.myTimeEntryDetails,
      ),
      body: isLoading
          ? Utility.circleProcessIndicator()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: breakCard(
                          widgetName: (child) => FadeInDown(child: child),
                          title: AppString.gameBreak,
                          value: gameFormatDuration(widget.gamezoneDuration),
                          color: AppColors.blackk,
                          imageUrl: gameZoneImg,
                          isGameWidget: true,
                        ),
                      ),
                    ],
                  ),
                  breakCard(
                    widgetName: (child) => FadeInLeftBig(child: child),
                    title: AppString.mainBreak,
                    value: "$mainBreak",
                    color: AppColors.blues,
                    imageUrl: mainBreakImg,
                    isNoDataFound: (mainInLogs.isEmpty && mainOutLogs.isEmpty),
                    widget: TimeEntryRow(
                      titleIn: AppString.inn,
                      titleOut: AppString.out,
                      logIn: mainInLogs,
                      logOut: mainOutLogs,
                      color: AppColors.blues,
                    ),
                  ),
                  breakCard(
                    widgetName: (child) => FadeInRightBig(child: child),
                    title: AppString.pantry1Break,
                    value: "$pantry1Break",
                    color: AppColors.yelloww,
                    imageUrl: pantry1Img,
                    isNoDataFound:
                        (pantry1InLogs.isEmpty && pantry1OutLogs.isEmpty),
                    widget: TimeEntryRow(
                      titleIn: AppString.inn,
                      titleOut: AppString.out,
                      logIn: pantry1OutLogs,
                      logOut: pantry1InLogs,
                      color: AppColors.yelloww,
                    ),
                  ),
                  breakCard(
                    widgetName: (child) => FadeInLeftBig(child: child),
                    title: AppString.pantry2Break,
                    value: "$pantry2Break",
                    color: AppColors.greenn,
                    imageUrl: pantry2Img,
                    isNoDataFound:
                        (pantry2InLogs.isEmpty && pantry2OutLogs.isEmpty),
                    widget: TimeEntryRow(
                      titleIn: AppString.inn,
                      titleOut: AppString.out,
                      logIn: pantry2OutLogs,
                      logOut: pantry2InLogs,
                      color: AppColors.greenn,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: breakCard(
                          widgetName: (child) => FadeInUp(child: child),
                          title: AppString.totalBreakTime,
                          value: sumAllBreaks(
                              mainBreak ?? "00h 00m 00s",
                              pantry1Break ?? "00h 00m 00s",
                              pantry2Break ?? "00h 00m 00s"),
                          color: AppColors.blueGrey,
                          imageUrl: totalBreakTimeImg,
                          isGameWidget: true,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.blackk),
                    ),
                    child: Center(
                      child: CommonText.richText(
                        fontSize: 18,
                        firstTitle:  AppString.totalColan,
                        secTitle: widget.total,
                        color: (widget.total.compareTo('08:20:00') <= 0)
                            ? AppColors.redd
                            : AppColors.greenn,
                        style2: CommonText.style600S18.copyWith(
                          color: (widget.total.compareTo('08:20:00') <= 0)
                              ? AppColors.redd
                              : AppColors.greenn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget breakCard({
    Color? color,
    Widget? widget,
    bool? isGameWidget = false,
    bool? isNoDataFound = false,
    required String title,
    required String value,
    required String imageUrl,
    required Widget Function(Widget child) widgetName,
  }) {
    return widgetName(
      Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: isGameWidget == true
                  ? BorderRadius.circular(12.r)
                  : BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
            ),
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            child: ClipRRect(
              borderRadius: isGameWidget == true
                  ? BorderRadius.circular(12.r)
                  : BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: imageUrl.isEmpty
                        ? Container(
                            color: color,
                          )
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            (color ?? AppColors.blues),
                            (color?.withOpacity(0.98) ?? AppColors.blues),
                            AppColors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: CommonText.style500S16.copyWith(
                                color: AppColors.whitee,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.whitee,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              value,
                              style: CommonText.style500S16.copyWith(
                                color: AppColors.blackk,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isGameWidget == false,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
              child: Visibility(
                visible: isNoDataFound == false,
                replacement: SizedBox(
                  height: 60.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.noTimeEntry,
                        textAlign: TextAlign.start,
                        style: CommonText.style500S18.copyWith(
                          color: AppColors.greyyDark,
                        ),
                      ),
                    ],
                  ),
                ),
                child: widget ?? Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
