import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';
import 'asset.dart';

var accessToken;
var refreshToken;
var userId;
var userName;
var fireUserFullName;
var userRole;
var latitude;
var longitude;
var slotBookedId;
var gender;
var docRefID;
String appVersion = "1.0.1";

bool isTeamLeader = false;
bool isAdminUser = false;

List<String> pendingEODList = [];

List<String> permissionList = [];

enum LayoutType { listView, gridView, twoItemsGrid }

List<String> users = [];

List<ImageItem> imageList = [
  ImageItem(id: "1", name: "Himalayas", path: AssetImg.himalayasImg),
  ImageItem(id: "2", name: "Light House", path: AssetImg.lightHouseImg),
  ImageItem(id: "3", name: "Morning", path: AssetImg.morningImg),
  ImageItem(id: "4", name: "Nature", path: AssetImg.natureImg),
  ImageItem(id: "5", name: "Night", path: AssetImg.nightImg),
  ImageItem(id: "6", name: "Sunflower", path: AssetImg.sunflowerImg),
];

List<ProImageItem> proImageList = [
  ProImageItem(id: "1", name: "Flowers", path: AssetImg.flowersImg),
  ProImageItem(id: "2", name: "Ocean", path: AssetImg.oceanImg),
  ProImageItem(id: "3", name: "Sky", path: AssetImg.skyImg),
];

class ImageItem {
  final String id;
  final String name;
  final String path;

  ImageItem({required this.id, required this.name, required this.path});
}

class ProImageItem {
  final String id;
  final String name;
  final String path;

  ProImageItem({required this.id, required this.name, required this.path});
}

Future<String> checkConnectivityStatus(List<ConnectivityResult> result) async {
  if (result.contains(ConnectivityResult.mobile)) {
    return "Mobile network available.";
  } else if (result.contains(ConnectivityResult.wifi)) {
    return "Wi-Fi is available.";
  } else if (result.contains(ConnectivityResult.none)) {
    await Utility.networkConformationDialog();
    return "No network available.";
  } else {
    return "Unknown network state.";
  }
}

class Global {
  static String formattedCurrentDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  /// Retrieves access and refresh tokens from SharedPreferences
  static Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');
  }

  static Future<void> addTaskSound() async {
    final player = AudioPlayer();
    await player.play(
      AssetSource("sounds/done.mp3"),
    );
  }

  /// Converts a date string from "yyyy-MM-dd" format to "dd-MM-yyyy" format
  static String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  /// Converts a date string from "yyyy-MM-dd" format to "dd MMM, yyyy" format (e.g., "12 Jan, 2025")
  static String formatDateMonthYearName(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }

  static String formatDateWithSuffix(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String day = DateFormat('d').format(dateTime);
    String month = DateFormat('MMM').format(dateTime);

    String suffix = _getDaySuffix(int.parse(day));

    return '$day$suffix $month';
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// Converts a date-time string from "yyyy-MM-dd HH:mm:ss" to "dd MMM, yyyy | hh:mm a" format (e.g., "12 Jan, 2025 | 03:45 PM")
  static String formatDateMonthNameAMPM(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate).toLocal();
    return DateFormat('dd MMM, yyyy | hh:mm a').format(dateTime);
  }

  /// Converts a date string from "dd-MM-yyyy" format to "yyyy-MM-dd" format
  static String formatSelectedDate(String dateText) {
    DateFormat inputFormat = DateFormat("dd-MM-yyyy");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    DateTime date = inputFormat.parse(dateText);
    return outputFormat.format(date);
  }

  /// Formats a time string based on the provided options (e.g., showing seconds or AM/PM)
  static String formatTime({
    required String time,
    bool? showOriginal,
    bool? showSeconds = true,
    bool? showAMPM = true,
  }) {
    try {
      DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
      String format = showSeconds == true
          ? 'hh:mm:ss ${showAMPM == true ? "a" : ""}'
          : 'hh:mm ${showAMPM == true ? "a" : ""}';
      return showOriginal == true
          ? time
          : DateFormat(format).format(parsedTime);
    } catch (e) {
      return '';
    }
  }

  /// Returns the full month name (e.g., "January") for a given month number (1-12)
  static String getMonthName(int month) {
    final dateTime = DateTime(0, month);
    return DateFormat.MMMM().format(dateTime);
  }

  static Color getColorForStatus({required String status, bool? isFromCmt}) {
    switch (status) {
      case "approved":
        return AppColors.greenn;
      case "pending":
        return isFromCmt == true
            ? AppColors.transparent
            : AppColors.yellowLight;
      case "rejected":
        return AppColors.redd;
      case "cancelled":
        return AppColors.yelloww;
      case "total_data":
        return AppColors.blues;
      default:
        return AppColors.blackk;
    }
  }

  static Color getColorLeaves(String status) {
    switch (status) {
      case "Total":
        return AppColors.blues;
      case "Used":
        return AppColors.redd;
      case "Remaining":
        return AppColors.greenn;
      case "LOP":
        return AppColors.yelloww;
      default:
        return AppColors.blackk;
    }
  }

  static DateTime getNextWeekday(DateTime date) {
    if (date.weekday == DateTime.saturday) {
      return date.add(Duration(days: 2));
    } else if (date.weekday == DateTime.sunday) {
      return date.add(Duration(days: 1));
    }
    return date;
  }

  static bool isWeekday(DateTime date) {
    return date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;
  }

  static Future<DateTime?> showCustomDatePicker(
      BuildContext context, bool? isAdhoc, Set<DateTime> holidayDates) async {
    DateTime now = DateTime.now();
    DateTime initialDate = getNextWeekday(now);

    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isAdhoc == true ? DateTime(2000) : DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.yelloww,
              onPrimary: AppColors.whitee,
              onSurface: AppColors.blackk,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.yelloww,
                textStyle:
                    CommonText.style500S15.copyWith(color: AppColors.blackk),
              ),
            ),
          ),
          child: child!,
        );
      },
      selectableDayPredicate: (DateTime date) {
        // Ensure that only weekdays are selectable and exclude holiday dates
        return isWeekday(date) && !holidayDates.contains(date);
      },
    );
  }
}
