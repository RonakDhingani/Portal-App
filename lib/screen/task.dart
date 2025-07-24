// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/assigned_project_task.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/model/my_task_project_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../common_widget/app_string.dart';
import '../common_widget/common_app_bar.dart';
import '../common_widget/global_value.dart';
import '../common_widget/textfield.dart';
import '../controller/task_controller.dart';
import '../routes/app_pages.dart';
import '../utils/utility.dart';

class Task extends GetView<TaskController> {
  Task({super.key});

  @override
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskCtrl) {
      return Scaffold(
        appBar: CommonAppBar.commonAppBar(
          context: context,
          isButtonHide: true,
          title: AppString.tasks,
        ),
        body: Visibility(
          visible: isAdminUser == false,
          replacement:  Center(
            child: Text(
              AppString.taskAreComingSoon,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: CommonText.style500S15.copyWith(
                color: AppColors.blackk,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        buildStatusCard(
                          title: AppString.total,
                          count:
                              taskCtrl.myTasksProjectModel?.labels?.allTasks ?? 0,
                          color: AppColors.yellowLight,
                          icon: TablerIcons.checkup_list,
                        ),
                        buildStatusCard(
                          title: AppString.todo,
                          count:
                              taskCtrl.myTasksProjectModel?.labels?.todoTasks ??
                                  0,
                          color: AppColors.redd,
                          icon: TablerIcons.clipboard_data,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buildStatusCard(
                          title: AppString.inProgress,
                          count: taskCtrl
                                  .myTasksProjectModel?.labels?.pendingTasks ??
                              0,
                          color: AppColors.greenn,
                          icon: TablerIcons.clipboard_list,
                        ),
                        buildStatusCard(
                          title: AppString.done,
                          count: taskCtrl
                                  .myTasksProjectModel?.labels?.completedTasks ??
                              0,
                          color: AppColors.blues,
                          icon: TablerIcons.checklist,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          AppString.assignedProjectsTask,
                          maxLines: 1,
                          overflow: taskCtrl.isSearch
                              ? TextOverflow.ellipsis
                              : TextOverflow.visible,
                          style: CommonText.style500S17.copyWith(
                            color: AppColors.greyyDark,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        alignment: Alignment.centerRight,
                        width: taskCtrl.isSearch ? 250 : 50,
                        child: Visibility(
                          visible: taskCtrl.isSearch,
                          child: TextFieldCustom(
                            controller: taskCtrl.searchController,
                            inputAction: TextInputAction.search,
                            fillColor: AppColors.transparent,
                            onFieldSubmitted: (value) {
                              taskCtrl.myTasksProjectModel?.results?.clear();
                              taskCtrl.update();
                              taskCtrl.getProjectMyTasks(isStatus: true);
                            },
                            isTitleHide: true,
                            isShow: true,
                            labelText: AppString.search,
                            showSuffixIcon: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                TablerIcons.x,
                                color: AppColors.blackk,
                              ),
                              onPressed: () {
                                taskCtrl.isSearch = !taskCtrl.isSearch;
                                taskCtrl.searchController.clear();
                                taskCtrl.myTasksProjectModel?.results?.clear();
                                taskCtrl.update();
                                taskCtrl.getProjectMyTasks(
                                  isStatus: true,
                                );
                              },
                            ),
                          ),
                          replacement: SizedBox(
                            height: 54,
                            child: IconButton(
                              icon: Icon(
                                TablerIcons.search,
                                color: AppColors.greyyDark,
                              ),
                              onPressed: () {
                                taskCtrl.isSearch = !taskCtrl.isSearch;
                                taskCtrl.update();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PagedListView<int, Results>(
                    pagingController: taskCtrl.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Results>(
                      firstPageProgressIndicatorBuilder: (_) => Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Utility.circleProcessIndicator(),
                      ),
                      firstPageErrorIndicatorBuilder: (_) =>
                          Utility.dataNotFound(),
                      noItemsFoundIndicatorBuilder: (_) => Utility.dataNotFound(),
                      newPageProgressIndicatorBuilder: (_) => Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Utility.circleProcessIndicator(),
                      ),
                      animateTransitions: true,
                      itemBuilder: (context, item, index) {
                        var id = item.id;
                        return AssignedProjectTask(
                          onTap: () {
                            Get.toNamed(Routes.projectTaskDetails,
                                arguments: {'id': id});
                          },
                          projectName: item.projectName.toString(),
                          taskName: item.taskName.toString(),
                          code: item.projectCode.toString(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildStatusCard({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: color, width: 10),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      icon,
                      color: color,
                    ),
                    Text(
                      '$count',
                      style: CommonText.style600S18.copyWith(
                        color: AppColors.blackk,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
