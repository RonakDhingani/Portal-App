import 'dart:developer';

import 'package:get/get.dart';
import 'package:inexture/common_widget/api_url.dart';
import 'package:intl/intl.dart';

import '../common_widget/global_value.dart';
import '../model/holidays_model.dart';
import '../model/year_filter_model.dart';
import '../services/api_function.dart';

class HolidaysController extends GetxController {
  bool isLoading = false;
  bool isDefaultSelected = true;

  LayoutType layoutType = LayoutType.listView;
  HolidaysResponse? holidaysResponse;
  var holidayDate;
  int? statusCode;
  String startYear = '';
  String endYear = '';
  String? dropdownValue = '';
  var dropdownItems = <String>[];
  YearFilterModel? yearFilterModel;

  @override
  void onInit() {
    yearFilter();
    super.onInit();
  }

  Future<void> yearFilter() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.settingsYearFilter,
      method: 'GET',
      onSuccess: (value) {
        log("Status Code: ${value.statusCode}");
        log("Year Filter Request API URL: ${value.realUri}");
        log("Year Filter Request API Response Data: ${value.data}");
        yearFilterModel = YearFilterModel.fromJson(value.data);
        dropdownItems = yearFilterModel?.data
                ?.map((year) => '${year.startYear} - ${year.endYear}')
                .toList() ??
            [];
        if (yearFilterModel?.currentFinancialYear?.isNotEmpty ?? false) {
          startYear =
              yearFilterModel!.currentFinancialYear!.first.startYear.toString();
          endYear =
              yearFilterModel!.currentFinancialYear!.first.endYear.toString();
          dropdownValue = "$startYear - $endYear";
        }
        getHolidays();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => yearFilter(),
        );
      },
      onError: (value) {
        log("Year Filter Request API URL : ${value.realUri.toString()}");
        log("Year Filter Request API Response : ${value.data.toString()}");
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getHolidays({
    bool? isShowLoading = false,
  }) async {
    if (isShowLoading == true) {
      isLoading = true;
      update();
    }
    ApiFunction.apiRequest(
      url: "${ApiUrl.holidays}?start_year=$startYear&end_year=$endYear",
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log('holidays API Response : ${value.data.toString()}');
        holidaysResponse = HolidaysResponse.fromJson(value.data);
        // holidaysResponse?.results?.removeWhere((holiday) {
        //   DateTime currentDate = DateTime.now();
        //   DateTime holidayDate = DateTime.parse(holiday.date ?? '2024-04-19');
        //   return holidayDate.isBefore(currentDate);
        // });
        holidaysResponse?.results?.sort((a, b) {
          if (a.date == null && b.date == null) {
            return 0;
          } else if (a.date == null) {
            return 1;
          } else if (b.date == null) {
            return -1;
          }
          return a.date!.compareTo(b.date!);
        });
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getHolidays(),
        );
      },
      onError: (value) {
        isLoading = false;
        update();
        statusCode = value.statusCode;
        log('holidays API Response Error : ${value.data.toString()}');
      },
    );
  }

  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    holidayDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return holidayDate;
  }

  void toggleLayout() {
    if (layoutType == LayoutType.listView) {
      layoutType = LayoutType.gridView;
    } else if (layoutType == LayoutType.gridView) {
      layoutType = LayoutType.twoItemsGrid;
    } else {
      layoutType = LayoutType.listView;
    }
    update(); // Update the UI when the layout changes
  }
}
