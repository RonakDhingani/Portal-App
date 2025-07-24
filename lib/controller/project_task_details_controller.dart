import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../common_widget/api_url.dart';
import '../model/project_task_assignee_model.dart';
import '../model/project_task_details_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class ProjectTaskDetailsController extends GetxController
    with WidgetsBindingObserver {
  bool isLoading = false;
  bool isTaskLog = false;
  bool isSomethingNew = false;
  int pageSize = 10;
  ProjectTaskDetailsModel? projectTaskDetailsModel;
  ProjectTaskAssigneeModel? projectTaskAssigneeModel;
  late PageController pageController;
  Timer? timer;
  int currentPage = 0;
  final PagingController<int, Results> pagingController =
      PagingController(firstPageKey: 0);
  final ScrollController scrollController = ScrollController();
  var id;
  Set<int> animatedIndices = {};

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    pageController = PageController(initialPage: currentPage);
    final arguments = Get.arguments;
    id = arguments['id'];
    update();
    getProjectTaskAssignee();
    setupPaginationListener();
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void setupPaginationListener() {
    pagingController.addPageRequestListener((pageKey) async {
      getProjectTasksDetails(pageKey: pageKey == 0 ? 1 : pageKey);
    });
  }

  Future<void> getProjectTaskAssignee() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.projectTasksAssignee}/$id',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Project Tasks Assignee API Response : ${value.data.toString()}');
        projectTaskAssigneeModel =
            ProjectTaskAssigneeModel.fromJson(value.data);
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getProjectTaskAssignee(),
        );
      },
      onError: (value) {
        log('Project Tasks Assignee API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
      },
    );
  }

  Future<void> getProjectTasksDetails({
    int pageKey = 1,
  }) async {
    ApiFunction.apiRequest(
      url:
          '${ApiUrl.projectTasksDetails}/$id?page=$pageKey&page_size=$pageSize',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Project Tasks Details API Response : ${value.data.toString()}');
        projectTaskDetailsModel = ProjectTaskDetailsModel.fromJson(value.data);
        final newList = projectTaskDetailsModel?.results ?? [];

        final currentList = pagingController.itemList ?? [];
        final filteredList =
            newList.where((newItem) => !currentList.contains(newItem)).toList();

        if (filteredList.length < pageSize) {
          pagingController.appendLastPage(filteredList);
        } else {
          pagingController.appendPage(filteredList, pageKey + 1);
        }
        isTaskLog = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getProjectTasksDetails(),
        );
      },
      onError: (value) {
        isTaskLog = false;
        update();
        log('Project Tasks Details API Response : ${value.data.toString()}');
      },
    );
  }

  Future<void> deleteTaskWorkLog({required int indexID}) async {
    // isTaskLog = true;
    update();

    ApiFunction.apiRequest(
      url: '${ApiUrl.deleteTaskWorkLog}$indexID',
      method: 'DELETE',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Delete Tasks Work Log API Response : ${value.data.toString()}');
        pagingController.refresh();
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then((value) {
          deleteTaskWorkLog(indexID: indexID);
        });
      },
      onError: (value) {
        log('Delete Tasks Work Log API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isTaskLog = false;
        update();
      },
    );
  }
}
