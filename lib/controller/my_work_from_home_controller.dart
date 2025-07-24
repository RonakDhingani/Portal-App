import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/model/my_work_from_home_model.dart' as myWFH;
import 'package:inexture/model/wfh_request_model.dart' as wfhReq;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../common_widget/api_url.dart';
import '../model/year_filter_model.dart';
import '../services/api_function.dart';

class MyWorkFromHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isLoading = false;
  bool isAtBottom = false;
  bool isDefaultSelected = true;

  String status = '';
  String startYear = '';
  String endYear = '';
  String? dropdownValue = '';
  int pageSize = 10;
  int currentIndex = 0;

  var dropdownItems = <String>[];

  YearFilterModel? yearFilterModel;
  wfhReq.WFHRequestModel? wfhRequestModel;
  myWFH.MyWorkFromHomeModel? myWorkFromHomeModel;

  String startDate = DateFormat('yyyy-MM-dd')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1));
  String endDate = DateFormat('yyyy-MM-dd').format(
      DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
          .subtract(Duration(days: 1)));

  late TabController controller;
  PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  final PagingController<int, myWFH.Results> pagingController =
  PagingController(firstPageKey: 0);
  final PagingController<int, wfhReq.Results> wfhReqController =
  PagingController(firstPageKey: 0);

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'My WFH'),
    Tab(text: 'WFH Requests'),
  ];

  @override
  void onInit() {
    yearFilter();
    controller = TabController(vsync: this, length: myTabs.length);
    controller.addListener(
          () {
        controller.index;
        currentIndex = 0;
        pageController.jumpToPage(currentIndex);
        update();
        if (controller.index == 0) {
          getMyWorkFromHome(
            pageKey: 1,
            isStatus: true,
          );
        } else {
          if (wfhRequestModel?.results?.isNotEmpty == true) {
            getWFHRequest(
              pageKey: 1,
              isStatus: true,
            );
          }
        }
      },
    );
    setupPaginationListener();
    scrollController.addListener(onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    controller.dispose();
    pageController.dispose();
    super.onClose();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isAtBottom = true;
      update();
    } else {
      isAtBottom = false;
      update();
    }
  }

  void setupPaginationListener() {
    pagingController.addPageRequestListener((pageKey) async {
      getMyWorkFromHome(pageKey: pageKey == 0 ? 1 : pageKey);
    });
    wfhReqController.addPageRequestListener((pageKey) async {
      getWFHRequest(pageKey: pageKey == 0 ? 1 : pageKey);
    });
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
        isLoading = false;
        update();
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

  Future<void> getMyWorkFromHome({
    int pageKey = 1,
    bool? isShowLoading = false,
    bool? isStatus = false,
  }) async {
    if (isShowLoading == true) {
      isLoading = true;
      update();
    }
    ApiFunction.apiRequest(
      url:
      '${ApiUrl.myWorkFromHome}?status=$status&start_year=$startYear&end_year=$endYear&page=$pageKey&page_size=$pageSize&search=&ordering=-id',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('My Work From Home API Response : ${value.data.toString()}');
        myWorkFromHomeModel = myWFH.MyWorkFromHomeModel.fromJson(value.data);
        final newList = myWorkFromHomeModel?.results ?? [];
        final totalResults = value.data['total'] ?? 0;
        final totalPages = (totalResults / pageSize).ceil();
        if (isStatus == true) {
          pagingController.refresh();
        } else {
          final currentList = pagingController.itemList ?? [];
          final filteredList = newList
              .where((newItem) => !currentList.contains(newItem))
              .toList();
          if (filteredList.length < pageSize || pageKey >= totalPages) {
            pagingController.appendLastPage(filteredList);
          } else {
            pagingController.appendPage(filteredList, pageKey + 1);
          }
        }
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
              (value) => getMyWorkFromHome(),
        );
      },
      onError: (value) {
        log('My Work From Home API Response : ${value.data.toString()}');
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getWFHRequest({
    int pageKey = 1,
    bool? isShowLoading = false,
    bool? isStatus = false,
  }) async {
    if (isShowLoading == true) {
      isLoading = true;
      update();
    }
    ApiFunction.apiRequest(
      url:
          '${ApiUrl.workFromHomeRequest}?start_year=$startYear&end_year=$endYear&start_date=$startDate&end_date=$endDate&status=$status&page=$pageKey&page_size=$pageSize&search=&ordering=-id&filters=%5B%5D&filterModes',
      method: 'GET',
      onSuccess: (value) {
        log("Status Code: ${value.statusCode}");
        log("Work From Home Request API URL: ${value.realUri}");
        log("Work From Home Request API Response Data: ${value.data}");
        wfhRequestModel = wfhReq.WFHRequestModel.fromJson(value.data);
        final newList = wfhRequestModel?.results ?? [];
        final totalResults = value.data['total'] ?? 0;
        final totalPages = (totalResults / pageSize).ceil();
        if (isStatus == true) {
          wfhReqController.refresh();
        } else {
          final currentList = wfhReqController.itemList ?? [];
          final filteredList = newList
              .where((newItem) => !currentList.contains(newItem))
              .toList();
          if (filteredList.length < pageSize || pageKey >= totalPages) {
            wfhReqController.appendLastPage(filteredList);
          } else {
            wfhReqController.appendPage(filteredList, pageKey + 1);
          }
        }
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
              (value) => getWFHRequest(),
        );
      },
      onError: (value) {
        log("Work From Home Request API URL : ${value.realUri.toString()}");
        log("Work From Home Request API Response : ${value.data.toString()}");
        isLoading = false;
        update();
      },
    );
  }

  Future<void> onSelectionChanged(
      DateRangePickerSelectionChangedArgs args) async {
    if (args.value is PickerDateRange) {
      startDate = DateFormat('yyyy-MM-dd').format(args.value.startDate);
      endDate = DateFormat('yyyy-MM-dd').format(args.value.endDate);
    }
    update();
  }
}
