import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inexture/model/project_details_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../common_widget/api_url.dart';
import '../common_widget/app_colors.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class ProjectController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  bool isLoading = false;
  ProjectDetailsModel? projectDetailsModel;
  int page = 1;
  int pageSize = 25;
  final PagingController<int, Results> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    setupPaginationListener();
    super.onInit();
  }

  void setupPaginationListener() {
    pagingController.addPageRequestListener((pageKey) async {
      getProjectDetailsList(pageKey: pageKey == 0 ? 1 : pageKey);
    });
  }

  Future<void> getProjectDetailsList({
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
          '${ApiUrl.projectList}?${searchTextController.text.isEmpty ? '' : 'search=${searchTextController.text}&'}page=$page&page_size=$pageSize',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Project List API Response : ${value.data.toString()}');
        projectDetailsModel = ProjectDetailsModel.fromJson(value.data);
        final newList = projectDetailsModel?.results ?? [];
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
          (value) => getProjectDetailsList(),
        );
      },
      onError: (value) {
        log('Project List API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
      },
    );
  }

  String getNullDateUpdate(String value) {
    switch (value) {
      case "null":
        return 'NA';
      default:
        return value;
    }
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case "null":
        return AppColors.redd;
      case "Hold":
        return AppColors.blues;
      case "Open":
        return AppColors.greenn;
      case "Closed":
        return AppColors.redd;
      default:
        return AppColors.greyy;
    }
  }

  Color getColorForPriority(String status) {
    switch (status) {
      case "null":
        return AppColors.redd;
      case "High":
        return AppColors.greenn;
      case "Very High":
        return AppColors.blues;
      case "Medium":
        return AppColors.yelloww;
      case "Low":
        return AppColors.brownn;
      default:
        return AppColors.greyy;
    }
  }
}
