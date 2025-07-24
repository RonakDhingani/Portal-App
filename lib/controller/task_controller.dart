import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../common_widget/api_url.dart';
import '../model/my_task_project_model.dart';
import '../services/api_function.dart';

class TaskController extends GetxController {
  bool isLoading = false;
  bool isSearch = false;
  int pageSize = 10;
  MyTasksProjectModel? myTasksProjectModel;
  final List<Results> allProjectResults = [];

  final TextEditingController searchController = TextEditingController();
  final PagingController<int, Results> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    setupPaginationListener();
    super.onInit();
  }

  void setupPaginationListener() {
    pagingController.addPageRequestListener((pageKey) async {
      getProjectMyTasks(
          pageKey: pageKey == 0 ? 1 : pageKey, isShowLoading: true);
    });
  }

  Future<void> getProjectMyTasks({
    int pageKey = 1,
    bool? isShowLoading = false,
    bool? isStatus = false,
  }) async {
    if (isShowLoading == true) {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
    ApiFunction.apiRequest(
      url:
          '${ApiUrl.projectMyTasks}?public_access=true&page=$pageKey&page_size=$pageSize&search=${searchController.text}',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log(value.requestOptions.uri.toString());
        log('Project My Tasks API Response : ${value.data.toString()}');
        myTasksProjectModel = MyTasksProjectModel.fromJson(value.data);
        final newList = myTasksProjectModel?.results ?? [];

        for (var item in newList) {
          if (!allProjectResults.contains(item)) {
            allProjectResults.add(item);
          }
        }

        log('Total combined results: ${allProjectResults.length}');
        final totalResults = value.data['count'] ?? 0;
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
          (value) => getProjectMyTasks(),
        );
      },
      onError: (response) {
        isLoading = false;
        update();
        log('Project My Tasks API Response : ${response.data.toString()}');
      },
    );
  }
}
