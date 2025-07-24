// ignore_for_file: unnecessary_overrides, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/services/api_function.dart';
import 'package:inexture/utils/utility.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../model/app_version.dart';
import '../model/employee_of_the_month_model.dart';
import '../model/employee_on_leave_today_model.dart';
import '../model/holidays_model.dart';
import '../model/my_dashboard_leave_model.dart' as results;
import '../model/my_dashboard_leave_model.dart';
import '../model/my_live_time_entry_model.dart';
import '../model/my_work_from_home_model.dart';
import '../model/team_status_model.dart';
import '../model/today_birthday_model.dart';
import '../model/today_work_anniversary_model.dart';
import '../model/upcoming_birthday_model.dart';
import '../model/upcoming_leave_model.dart';
import '../model/users_weekly_work_log_model.dart';
import '../model/work_from_home_today_model.dart';
import '../routes/app_pages.dart';
import '../services/firebase_operation.dart';

T? ambiguate<T>(T? value) => value;

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  // bool isLoading = false;
  bool isMyLeave = false;
  bool isTodayLeave = false;
  bool isUpcoming = false;
  bool isWFH = false;
  bool isTimeUpdate = false;
  bool isOutOfOffice = false;
  bool isServerError = false;
  bool isUserWorkLog = false;
  bool isTeamStatus = false;
  bool isEOM = false;
  bool isBirthDay = false;
  bool isUpcomingBirthDay = false;
  bool isAnniv = false;
  bool isScrollAlready = false;
  bool isTodayHalfDay = false;
  bool isDialogOpen = false;
  bool _isResumed = false;
  bool isResumedLoading = false;
  int page = 1;
  int pageSize = 0;
  var holidayDate;
  EmployeeOnLeaveTodayModel? employeeOnLeaveTodayModel;
  UpcomingLeaveModel? upcomingLeaveModel;
  MyDashboardLeaveModel? myDashboardLeaveModel;
  MyWorkFromHomeModel? myWorkFromHomeModel;
  HolidaysResponse? holidaysResponse;
  WorkFromHomeTodayModel? workFromHomeTodayModel;
  MyLiveTimeEntryModel? myLiveTimeEntryModel;
  UserWeeklyWorkLogModel? userWeeklyWorkLogModel;
  TeamStatusModel? teamStatusModel;
  EmployeeOfTheMonthModel? eomModel;
  TodayBirthdayModel? todayBirthdayModel;
  UpcomingBirthdayModel? upcomingBirthdayModel;
  TodayWorkAnniversaryModel? todayWorkAnnivModel;
  String hour = '00';
  String minute = '00';
  String second = '00';
  String quotes = '';
  List<String> quotesList = [];
  List<results.Results>? filteredLeaves = [];
  String formattedDate = DateFormat('dd MMM yyyy')
      .format(DateTime.parse(DateTime.now().toString()));
  String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
  Timer? timer;
  late AnimationController animationCtrl;
  late SharedPreferences prefs;
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  PageController controller = PageController();
  List<String> weeklyDateList = [];
  final oneDayHour = Duration(hours: 8, minutes: 20, seconds: 00);
  Duration totalWeeklyHours = Duration(hours: 41, minutes: 40, seconds: 00);
  String? lastWeekday;
  final player = AudioPlayer();
  final UserService userService = UserService();
  AppVersion? appVersionData;

  @override
  void onInit() {
    super.onInit();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.blackk,
    ));
    WidgetsBinding.instance.addObserver(this);
    animationCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    final weekStart = getThisWeeksStartDate();
    for (int i = 0; i < 7; i++) {
      final dayOfWeek = weekStart.add(Duration(days: i));
      log("weekly date : ${DateFormat('yyyy-MM-dd').format(dayOfWeek)}");
      weeklyDateList.add(DateFormat('yyyy-MM-dd').format(dayOfWeek));
    }
    loadQuotes();
    getIsAdminUser();
    fetchAppVersion();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _cancelTimer();
      _isResumed = false;
      myLiveTimeEntryModel?.results?.clear();
      update();
    } else if (state == AppLifecycleState.resumed) {
      if (!_isResumed) {
        _isResumed = true;
        isTimeUpdate = true;
        getMyLiveTimeEntry();
        if (isDialogOpen) {
          print('Dialog is open');
          Get.back();
          isDialogOpen = false;
          update();
        }
        fetchAppVersion();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    animationCtrl.dispose();
    super.onClose();
  }

  void _cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void fetchAppVersion() async {
    final fetchedVersion = await userService.getAppVersion();

    if (fetchedVersion != null) {
      appVersionData = fetchedVersion;
      log("Fetched App Version: ${fetchedVersion.newVersion}");
      log("Current App Version: $appVersion");
      if (isVersionOlder(appVersion, fetchedVersion.newVersion)) {
        if (Platform.isAndroid) {
          isDialogOpen = true;
          Utility.appUpdateDialogBox(
            oldVersion: fetchedVersion.oldVersion,
            newVersion: fetchedVersion.newVersion,
            title: fetchedVersion.updateTitle,
            subTitle: fetchedVersion.updateSubtitle,
          );
        }
      } else {
        isDialogOpen = false;
        log("App is up to date.");
      }
    } else {
      log("No app version data found.");
    }
  }

  bool isVersionOlder(String current, String remote) {
    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> remoteParts = remote.split('.').map(int.parse).toList();

    int maxLength = currentParts.length > remoteParts.length
        ? currentParts.length
        : remoteParts.length;

    while (currentParts.length < maxLength) {
      currentParts.add(0);
    }
    while (remoteParts.length < maxLength) {
      remoteParts.add(0);
    }

    for (int i = 0; i < maxLength; i++) {
      if (currentParts[i] < remoteParts[i]) return true;
      if (currentParts[i] > remoteParts[i]) return false;
    }
    return false;
  }

  void animateScroll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isScrollAlready = prefs.getBool('isScrollAlready') ?? false;
    if (!controller.hasClients) return;
    double currentPosition = controller.position.pixels;
    double smallOffset = 35.0;

    if (isScrollAlready == false) {
      await controller
          .animateTo(
        currentPosition + smallOffset,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeOutQuint,
      )
          .then(
        (value) {
          prefs.setBool('isScrollAlready', true);
        },
      );
    }
  }

  Future<void> loadQuotes() async {
    final String response =
        await rootBundle.loadString("assets/quotes/quotes.json");
    final data = json.decode(response);
    quotesList = List<String>.from(data['quotes']);
    update();
    quotes = getDailyQuote();
  }

  String getDailyQuote() {
    if (quotesList.isEmpty) return "Loading your daily inspiration...";
    final now = DateTime.now();
    final index = now.day % quotesList.length;
    return quotesList[index];
  }

  void getIsAdminUser() async {
    final prefs = await SharedPreferences.getInstance();
    isAdminUser = prefs.getBool('isAdminUser') ?? false;
    update();
    apiCalls();
  }

  Future<void> apiCalls() async {
    if (accessToken == null) {
      Get.offAllNamed(Routes.login);
    } else {
      getUserTimeEntry();
      if (isAdminUser == false) {
        getMyLiveTimeEntry();
      }
      calculateTotalWeeklyHours();
      getEmployeeOnLeaveToday();
      getUpcomingLeave();
      getWorkFromHomeToday();
      getTeamStatus();
      getEmployeeOfTheMonth();
      getTodayBirthDay();
      getUpcomingBirthDay();
      getTodayWorkAnniversary();
    }
  }

  Future<void> getUserTimeEntry() async {
    isTimeUpdate = true;
    isMyLeave = true;
    isTodayLeave = true;
    isUpcoming = true;
    isWFH = true;
    isUserWorkLog = true;
    isTeamStatus = true;
    isEOM = true;
    isBirthDay = true;
    isUpcomingBirthDay = true;
    isAnniv = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.userTimeEntry}/?weekly=true&previous_week=false',
      method: 'GET',
      onSuccess: (response) {
        log('User Weekly Work Log Response API Response : ${response.data.toString()}');
        userWeeklyWorkLogModel = UserWeeklyWorkLogModel.fromJson(response.data);
        isUserWorkLog = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getUserTimeEntry(),
        );
      },
      onError: (response) {
        isUserWorkLog = false;
        update();
        log('User Weekly Work Log Response API Response : ${response.data.toString()}');
      },
    );
  }

  Future<void> getMyLiveTimeEntry() async {
    _cancelTimer();
    hour = '00';
    minute = '00';
    second = '00';
    myLiveTimeEntryModel?.results?.clear();
    update();
    ApiFunction.apiRequest(
        url: '${ApiUrl.myLiveTimeEntry}?page=$page&page_size=$pageSize',
        method: 'GET',
        onSuccess: (response) {
          log('My Live Time Entry API Response : ${response.data.toString()}');
          myLiveTimeEntryModel = MyLiveTimeEntryModel.fromJson(response.data);
          if (myLiveTimeEntryModel?.results?.isEmpty == true) {
            isOutOfOffice = true;
            update();
            return;
          }
          var logInOut = myLiveTimeEntryModel?.results?.first.log?.last.punch;
          print('logInOut value : $logInOut');
          formattedDate = formatDate(
              myLiveTimeEntryModel?.results?[0].logDate.toString() ??
                  '2024-04-26');
          formattedTime = formatTime(
              myLiveTimeEntryModel?.results?[0].log?[0].time.toString() ?? "");
          String? totalDuration =
              myLiveTimeEntryModel?.results?[0].totalDuration;

          if (totalDuration != null) {
            updateTime(totalDuration);

            // Start the timer only if logInOut is 'IN'
            if (logInOut == 'IN') {
              List<String> timeComponents = totalDuration.split(':');
              if (timeComponents.length >= 3) {
                var totalSeconds = int.tryParse(timeComponents[0])! * 3600 +
                    int.tryParse(timeComponents[1])! * 60 +
                    int.tryParse(timeComponents[2])!;

                // Start a new timer
                timer = Timer.periodic(Duration(seconds: 1), (timer) async {
                  totalSeconds++;
                  var hours = totalSeconds ~/ 3600;
                  var minutes = (totalSeconds % 3600) ~/ 60;
                  var seconds = totalSeconds % 60;

                  hour = hours.toString().padLeft(2, '0');
                  minute = minutes.toString().padLeft(2, '0');
                  second = seconds.toString().padLeft(2, '0');
                  update();
                });
              }
            } else {
              _cancelTimer();
            }
          }
          isTimeUpdate = false;
          isOutOfOffice = false;
          update();
          WidgetsBinding.instance.addPostFrameCallback((_) => animateScroll());
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getMyLiveTimeEntry(),
          );
        },
        onServerError: (error) {
          if (error != null &&
              error.toString().contains('Internal Server Error')) {
            isServerError = true;
          }
          isOutOfOffice = true;
          update();
        },
        onError: (response) {
          isTimeUpdate = false;
          isOutOfOffice = true;
          update();
          log('My Live Time Entry API Response : ${response.data.toString()}');
        });
  }

  Future<void> calculateTotalWeeklyHours() async {
    List<Map<String, dynamic>> totalDaysList = [];

    await ApiFunction.apiRequest(
      url: '${ApiUrl.myDashboardLeave}?page=$page&page_size=$pageSize',
      method: 'GET',
      onSuccess: (response) {
        log('My Leave API Response : ${response.data.toString()}');
        myDashboardLeaveModel = MyDashboardLeaveModel.fromJson(response.data);
        for (var wfhStatus in myWorkFromHomeModel?.results ?? []) {
          log("Leave status : ${wfhStatus.status}");
        }
        for (var leave in myDashboardLeaveModel?.results ?? []) {
          if (leave.status == 'approved') {
            String startDate = leave.startDate ?? '';
            String endDate = leave.endDate ?? '';
            String type = leave.type ?? 'full';
            log("leave types: $type");
            if (startDate.isNotEmpty && endDate.isNotEmpty) {
              DateTime start = DateTime.parse(startDate);
              DateTime end = DateTime.parse(endDate);

              for (var currentDate = start;
                  currentDate.isBefore(end.add(Duration(days: 1)));
                  currentDate = currentDate.add(Duration(days: 1))) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(currentDate);
                log("Checking leave date: $formattedDate");

                if (weeklyDateList.contains(formattedDate)) {
                  totalDaysList.add({'date': formattedDate, 'type': type});
                  if (formattedDate ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                    isTodayHalfDay = true;
                  }
                  log("Matching approved leave date found in if: $formattedDate, Type: $type");
                }
              }
            } else if (startDate.isNotEmpty) {
              log("Checking leave date in else: $startDate");
              if (weeklyDateList.contains(startDate)) {
                totalDaysList.add({'date': startDate, 'type': type});
                log("Matching approved leave date found in else: $startDate, Type: $type");
              }
            }
          }
        }
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => calculateTotalWeeklyHours(),
        );
      },
      onError: (response) {
        log('My Leave API Response : ${response.data.toString()}');
      },
    );

    await ApiFunction.apiRequest(
      url: '${ApiUrl.myWorkFromHome}?page=$page&page_size=$pageSize',
      method: 'GET',
      onSuccess: (response) {
        log('My WFH API Response : ${response.data.toString()}');
        myWorkFromHomeModel = MyWorkFromHomeModel.fromJson(response.data);

        for (var wfh in myWorkFromHomeModel?.results ?? []) {
          if (wfh.status == 'approved') {
            String startDate = wfh.startDate ?? '';
            String endDate = wfh.endDate ?? '';

            if (startDate.isNotEmpty && endDate.isNotEmpty) {
              DateTime start = DateTime.parse(startDate);
              DateTime end = DateTime.parse(endDate);

              for (var currentDate = start;
                  currentDate.isBefore(end.add(Duration(days: 1)));
                  currentDate = currentDate.add(Duration(days: 1))) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(currentDate);
                log("Checking WFH date: $formattedDate");

                if (weeklyDateList.contains(formattedDate)) {
                  totalDaysList.add({'date': formattedDate, 'type': 'full'});
                  if (formattedDate ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                    isTodayHalfDay = true;
                  }
                  log("Matching approved WFH date found in if: $formattedDate");
                }
              }
            } else if (startDate.isNotEmpty) {
              log("Checking WFH date in else: $startDate");
              if (weeklyDateList.contains(startDate)) {
                totalDaysList.add({'date': startDate, 'type': 'full'});
                log("Matching approved WFH date found in else: $startDate");
              }
            }
          }
        }
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => calculateTotalWeeklyHours(),
        );
      },
      onError: (response) {
        log('My WFH API Response : ${response.data.toString()}');
      },
    );

    await ApiFunction.apiRequest(
      url: ApiUrl.holidays,
      method: 'GET',
      onSuccess: (response) {
        log('Holidays API Response : ${response.data.toString()}');
        holidaysResponse = HolidaysResponse.fromJson(response.data);

        for (var holiday in holidaysResponse?.results ?? []) {
          DateTime holidayDate = DateTime.parse(holiday.date ?? '2024-04-19');
          if (weeklyDateList
              .contains(DateFormat('yyyy-MM-dd').format(holidayDate))) {
            totalDaysList.add({
              'date': DateFormat('yyyy-MM-dd').format(holidayDate),
              'type': 'full'
            });
            log("Matching holiday found: ${holiday.date}");
          }
        }
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => calculateTotalWeeklyHours(),
        );
      },
      onError: (response) {
        log('Holidays API Response : ${response.data.toString()}');
      },
    );

    totalDaysList = totalDaysList.toSet().toList();
    double totalMinutes = 0.0;
    Duration fullDayHour = Duration(hours: 8, minutes: 20);
    Duration halfDayHour = Duration(hours: 4, minutes: 00);

    log("Total Days List: $totalDaysList");

    for (var leave in totalDaysList) {
      if (leave['type'] == 'half') {
        totalMinutes += halfDayHour.inMinutes.toDouble();
      } else {
        totalMinutes += fullDayHour.inMinutes.toDouble();
      }
    }

    int leaveHours = totalMinutes ~/ 60;
    int leaveMinutes = (totalMinutes % 60).toInt();
    int leaveSeconds =
        ((totalMinutes - leaveHours * 60 - leaveMinutes) * 60).toInt();

    log('Total Time (Leave + WFH + Holidays): $leaveHours hours, $leaveMinutes minutes, $leaveSeconds seconds');

    var totalLeaveDaysHour = Duration(
        hours: leaveHours, minutes: leaveMinutes, seconds: leaveSeconds);
    totalWeeklyHours =
        Duration(hours: 41, minutes: 40, seconds: 00) - totalLeaveDaysHour;

    lastWeekday = getLastDayOfWeekday(totalDaysList);
    log("Final output: $lastWeekday");

    isMyLeave = false;
    update();
  }

  Future<void> getEmployeeOnLeaveToday() async {
    ApiFunction.apiRequest(
        url: '${ApiUrl.employeeOnLeaveToday}?page=$page&page_size=$pageSize',
        method: 'GET',
        onSuccess: (response) {
          print(
              'Employee On Leave Today API Response : ${response.data.toString()}');
          employeeOnLeaveTodayModel =
              EmployeeOnLeaveTodayModel.fromJson(response.data);
          isTodayLeave = false;
          update();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getEmployeeOnLeaveToday(),
          );
        },
        onError: (response) {
          isTodayLeave = false;
          update();
          log('Employee On Leave Today API Response : ${response.data.toString()}');
        });
  }

  Future<void> getUpcomingLeave() async {
    ApiFunction.apiRequest(
        url: '${ApiUrl.upcomingLeave}?page=$page&page_size=$pageSize',
        method: 'GET',
        onSuccess: (response) {
          print('Upcoming Leave API Response : ${response.data.toString()}');
          upcomingLeaveModel = UpcomingLeaveModel.fromJson(response.data);
          isUpcoming = false;
          update();
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getUpcomingLeave(),
          );
        },
        onError: (response) {
          isUpcoming = false;
          update();
          log('Upcoming Leave API Response : ${response.data.toString()}');
        });
  }

  Future<void> getWorkFromHomeToday() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.workFromHomeToday}?page=$page&page_size=$pageSize',
      method: 'GET',
      onSuccess: (response) {
        log('Work From Home Today API Response : ${response.data.toString()}');
        workFromHomeTodayModel = WorkFromHomeTodayModel.fromJson(response.data);
        isWFH = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getWorkFromHomeToday(),
        );
      },
      onError: (response) {
        isWFH = false;
        update();
        log('Work From Home Today API Response : ${response.data.toString()}');
      },
    );
  }

  Future<void> getTeamStatus() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.teamStatus}?page=$page&page_size=$pageSize',
      method: 'GET',
      onSuccess: (response) {
        log('Team Status API Response : ${response.data.toString()}');
        teamStatusModel = TeamStatusModel.fromJson(response.data);
        isTeamStatus = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getTeamStatus(),
        );
      },
      onError: (response) {
        isTeamStatus = false;
        update();
        log('Team Status API Response : ${response.data.toString()}');
      },
    );
  }

  Future<void> getEmployeeOfTheMonth() async {
    ApiFunction.apiRequest(
      url: '${ApiUrl.employeeOfTheMonth}?page=$page&page_size=$pageSize',
      method: 'GET',
      onSuccess: (response) {
        log('Employee Of The Month API Response : ${response.data.toString()}');
        eomModel = EmployeeOfTheMonthModel.fromJson(response.data);
        isEOM = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getEmployeeOfTheMonth(),
        );
      },
      onError: (response) {
        isEOM = false;
        update();
        log('Employee Of The Month API Response : ${response.data.toString()}');
      },
    );
  }

  Future<void> getTodayBirthDay() async {
    ApiFunction.apiRequest(
      url: ApiUrl.todaysBirthdays,
      method: 'GET',
      onSuccess: (response) {
        log('Today BirthDay API Response : ${response.data.toString()}');
        todayBirthdayModel = TodayBirthdayModel.fromJson(response.data);
        isBirthDay = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getTodayBirthDay(),
        );
      },
      onError: (response) {
        isBirthDay = false;
        update();
        log('Today BirthDay API Response : ${response.data.toString()}');
      },
    );
  }

  Future<void> getUpcomingBirthDay() async {
    ApiFunction.apiRequest(
      url: ApiUrl.upcomingBirthdays,
      method: 'GET',
      onSuccess: (response) {
        log('Upcoming BirthDay API Response : ${response.data.toString()}');
        upcomingBirthdayModel = UpcomingBirthdayModel.fromJson(response.data);
        isUpcomingBirthDay = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getUpcomingBirthDay(),
        );
      },
      onError: (response) {
        isUpcomingBirthDay = false;
        update();
        log('Upcoming BirthDay API Response : ${response.data.toString()}');
      },
    );
  }

  Future<void> getTodayWorkAnniversary() async {
    ApiFunction.apiRequest(
      url: ApiUrl.todaysWorkAnniversary,
      method: 'GET',
      onSuccess: (response) {
        log('Today Work Anniversary API Response : ${response.data.toString()}');
        todayWorkAnnivModel = TodayWorkAnniversaryModel.fromJson(response.data);
        isAnniv = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getTodayWorkAnniversary(),
        );
      },
      onError: (response) {
        isAnniv = false;
        update();
        log('Today Work Anniversary API Response : ${response.data.toString()}');
      },
    );
  }

  String getLastDayOfWeekday(List<Map<String, dynamic>> totalDaysList) {
    DateTime now = DateTime.now();

    // Define the current week's Monday and Friday
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 4));

    // Create a list of all weekdays (Mon to Fri) in current week
    List<DateTime> weekdays =
        List.generate(5, (i) => startOfWeek.add(Duration(days: i)));

    // Extract only full-day leave dates
    Set<String> fullLeaveDates = totalDaysList
        .where((e) => (e['type']?.toString().toLowerCase() == 'full'))
        .map((e) => e['date'] as String)
        .toSet();

    log("Full day leaveDates value is: $fullLeaveDates");

    // Remove full-day leave dates from weekdays
    List<DateTime> workingDays = weekdays.where((day) {
      String dayStr = day.toIso8601String().substring(0, 10); // 'YYYY-MM-DD'
      return !fullLeaveDates.contains(dayStr);
    }).toList();

    log("After successfully removing full-day leave days, weekdays value is: $workingDays");

    // Return the last working day as weekday name
    if (workingDays.isNotEmpty) {
      DateTime lastWorkingDay = workingDays.last;
      log("lastWorkingDay is $lastWorkingDay");
      List<String> weekdayNames = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday"
      ];
      return weekdayNames[lastWorkingDay.weekday - 1];
    }

    return "Friday";
  }

  void updateTime(String totalDuration) {
    List<String> timeComponents = totalDuration.split(':');
    if (timeComponents.length >= 3) {
      var hours = int.tryParse(timeComponents[0]) ?? 0;
      var minutes = int.tryParse(timeComponents[1]) ?? 0;
      var seconds = int.tryParse(timeComponents[2]) ?? 0;
      hour = hours.toString().padLeft(2, '0');
      minute = minutes.toString().padLeft(2, '0');
      second = seconds.toString().padLeft(2, '0');
      update();
    }
  }

  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    return formattedDate;
  }

  String formatTime(String timeString) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('hh:mm a');
    final dateTime = inputFormat.parse(timeString);
    return outputFormat.format(dateTime);
  }

  DateTime getThisWeeksStartDate() {
    final now = DateTime.now();
    final weekday = now.weekday;
    return now.subtract(Duration(days: weekday - 1));
  }
}
