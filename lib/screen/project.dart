// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/model/project_details_model.dart';
import 'package:inexture/utils/utility.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../common_widget/app_string.dart';
import '../controller/project_controller.dart';

class ProjectScreen extends GetView<ProjectController> {
  ProjectScreen({super.key});

  @override
  final ProjectController controller = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
      builder: (projectController) {
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.project,
          ),
          body: projectController.isLoading
              ? Utility.circleProcessIndicator()
              : PagedListView<int, Results>(
                  pagingController: projectController.pagingController,
                  padding: EdgeInsets.all(20),
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
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: AppColors.whitee,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${item.projectName}',
                                  style: CommonText.style600S16.copyWith(
                                    color: AppColors.yelloww,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonText.richText(
                                      firstTitle: AppString.codeColan,
                                      secTitle: '${item.projectCode}',
                                      color: AppColors.blackk,
                                    ),
                                    Spacer(),
                                    CommonText.richText(
                                      firstTitle: AppString.typeColan,
                                      secTitle: '${item.projectType}',
                                      color: AppColors.blackk,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonText.richText(
                                      firstTitle: AppString.statusColan,
                                      secTitle:
                                          projectController.getNullDateUpdate(
                                              '${item.statusType}'),
                                      color:
                                          projectController.getColorForStatus(
                                        '${item.statusType}',
                                      ),
                                    ),
                                    Spacer(),
                                    CommonText.richText(
                                      firstTitle: AppString.priorityColan,
                                      secTitle:
                                          projectController.getNullDateUpdate(
                                              '${item.priority}'),
                                      color:
                                          projectController.getColorForPriority(
                                        '${item.priority}',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonText.richText(
                                      firstTitle: AppString.totalTaskColan,
                                      secTitle: '${item.totalTask}',
                                      color: AppColors.blackk,
                                    ),
                                    Spacer(),
                                    CommonText.richText(
                                      firstTitle: AppString.totalHoursColan,
                                      secTitle: '${item.totalHours}',
                                      color: AppColors.blackk,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CommonText.richText(
                                  firstTitle: AppString.currentProjectStatusIsColan,
                                  secTitle: '${item.status?.name}',
                                  color: item.status?.color == "#ed2b2b"
                                      ? AppColors.redd
                                      : AppColors.greenn,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}