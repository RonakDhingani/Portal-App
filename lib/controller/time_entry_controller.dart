import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../common_widget/api_url.dart';
import '../common_widget/app_colors.dart';
import '../model/my_time_entry_month_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class TimeEntryController extends GetxController {
  bool isLoading = false;
  bool isSelected = false;
  bool isToday = true;
  int pageSize = 10;
  String year = DateFormat('yyyy').format(DateTime.now());
  String month = DateFormat('MM').format(DateTime.now());
  MyTimeEntryMonthModel? myTimeEntryMonthModel;
  String? dropdownTodayValue = 'Today';

  var dropdownTodayItems = [
    'Today',
    'Previous',
  ];
  final PagingController<int, Result> pagingController =
      PagingController(firstPageKey: 0);

  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void onInit() {
    getMyTimeEntry(isShowLoading: true);
    setupPaginationListener();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    pagingController.dispose();
    super.dispose();
  }

  void setupPaginationListener() {
    pagingController.addPageRequestListener((pageKey) async {
      getMyTimeEntry(pageKey: pageKey == 0 ? 1 : pageKey);
    });
  }

  Future<void> getMyTimeEntry({
    int pageKey = 1,
    bool? isShowLoading = false,
    bool? isMonthChanged = false,
  }) async {
    if (isShowLoading == true) {
      isLoading = true;
      update();
    }
    if (isMonthChanged == true) {
      Utility.showFlushBar(text: 'Filter is applying...');
    }
    ApiFunction.apiRequest(
      url:
          '${ApiUrl.myTimeEntry}?ordering=-id&month=$month&year=$year&page=$pageKey&page_size=$pageSize',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('my Time Entry Month Response : ${value.data.toString()}');
        myTimeEntryMonthModel = MyTimeEntryMonthModel.fromJson(value.data);
        if (isMonthChanged == true) {
          pagingController.refresh();
        } else {
          final newList = myTimeEntryMonthModel?.results ?? [];
          if (newList.length < pageSize) {
            pagingController.appendLastPage(newList);
          } else {
            pagingController.appendPage(newList, pageKey + 1);
          }
        }
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getMyTimeEntry(),
        );
      },
      onError: (value) {
        log('my Time Entry Month Response : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }

  Map<String, dynamic> getBorderProperties(int index, int length) {
    BorderRadius borderRadius;
    BoxBorder border;

    if (length == 1) {
      borderRadius = BorderRadius.circular(5);
      border = Border.all(
        color: AppColors.greyy,
        style: BorderStyle.solid,
      );
    } else if (index == 0) {
      borderRadius = BorderRadius.vertical(top: Radius.circular(5));
      border = Border(
        left: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
        top: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
        right: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
      );
    } else if (index == length - 1) {
      borderRadius = BorderRadius.vertical(bottom: Radius.circular(5));
      border = Border(
        left: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
        bottom: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
        right: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
      );
    } else {
      borderRadius = BorderRadius.zero;
      border = Border(
        left: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
        right: BorderSide(color: AppColors.greyy, style: BorderStyle.solid),
      );
    }

    return {'borderRadius': borderRadius, 'border': border};
  }
}
