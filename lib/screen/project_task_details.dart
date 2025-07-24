// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print

import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/model/project_task_details_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widget/app_string.dart';
import '../common_widget/common_app_bar.dart';
import '../common_widget/global_value.dart';
import '../controller/project_task_details_controller.dart';
import '../routes/app_pages.dart';
import '../utils/utility.dart';

class ProjectTaskDetails extends GetView<ProjectTaskDetailsController> {
  ProjectTaskDetails({super.key});

  @override
  final ProjectTaskDetailsController controller =
      Get.put(ProjectTaskDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectTaskDetailsController>(
      builder: (ptdCtrl) {
        return WillPopScope(
          onWillPop: () async {
            if (ptdCtrl.isSomethingNew) {
              Get.back(result: "Update something");
            } else {
              Get.back();
            }
            return false;
          },
          child: Scaffold(
            appBar: CommonAppBar.commonAppBar(
              context: context,
              title: AppString.projectTaskDetails,
              onPressed: () {
                if (ptdCtrl.isSomethingNew) {
                  Get.back(result: "Update something");
                } else {
                  Get.back();
                }
              },
            ),
            body: Column(
              children: [
                ptdCtrl.isLoading
                    ? Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 85.h,
                        child: Utility.shimmerLoading(
                          color: AppColors.greyy,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 15, top: 20, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppString.project,
                                          style:
                                              CommonText.style600S15.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                        Text(
                                          ptdCtrl.projectTaskAssigneeModel
                                                  ?.projectName ??
                                              '',
                                          style:
                                              CommonText.style400S13.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 20,
                                    color: AppColors.greyy,
                                    thickness: 1,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppString.projectCode,
                                          style:
                                              CommonText.style600S15.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                        Text(
                                          ptdCtrl.projectTaskAssigneeModel
                                                  ?.projectCode ??
                                              '',
                                          style:
                                              CommonText.style400S13.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 20,
                                    color: AppColors.greyy,
                                    thickness: 1,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppString.assignee,
                                          style:
                                              CommonText.style600S15.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                          child: PageView.builder(
                                            controller: ptdCtrl.pageController,
                                            itemCount: ptdCtrl
                                                    .projectTaskAssigneeModel
                                                    ?.assignTo
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              var length = ptdCtrl
                                                      .projectTaskAssigneeModel
                                                      ?.assignTo
                                                      ?.length ??
                                                  0;
                                              var userDetails = ptdCtrl
                                                  .projectTaskAssigneeModel
                                                  ?.assignTo?[index];
                                              var userName =
                                                  '${userDetails?.firstName ?? ''} ${userDetails?.lastName ?? ''}';
                                              return Text(
                                                length <= 1
                                                    ? userName
                                                    : "$userName,\t",
                                                style: CommonText.style400S13
                                                    .copyWith(
                                                  color: AppColors.blues,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              margin: EdgeInsets.only(right: 15.w),
                              child: CommonText.richText(
                                firstTitle: AppString.taskNameColan,
                                secTitle:
                                    "${ptdCtrl.projectTaskAssigneeModel?.taskName}",
                                color: AppColors.blackk,
                                style2: CommonText.style400S13.copyWith(
                                  color: AppColors.blackk,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Divider(
                  endIndent: 15,
                  indent: 15,
                ),
                Expanded(
                  child: ptdCtrl.isTaskLog
                      ? Center(
                          child: Utility.circleProcessIndicator(),
                        )
                      : PagedListView<int, Results>(
                          pagingController: ptdCtrl.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Results>(
                            firstPageProgressIndicatorBuilder: (_) => Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Utility.circleProcessIndicator(),
                            ),
                            firstPageErrorIndicatorBuilder: (_) =>
                                Utility.dataNotFound(),
                            noItemsFoundIndicatorBuilder: (_) =>
                                Utility.dataNotFound(),
                            newPageProgressIndicatorBuilder: (_) => Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Utility.circleProcessIndicator(),
                            ),
                            animateTransitions: true,
                            itemBuilder: (context, item, index) {
                              var workDescription = item.workDescription ?? '';
                              Color cardColor = (index % 2 == 0)
                                  ? AppColors.blues
                                  : AppColors.yelloww;
                              var isRightOrLeft = (index % 2 == 0);

                              var shouldAnimate = !ptdCtrl.animatedIndices.contains(index);

                              Widget taskWidget = taskCard(
                                cardColor: cardColor,
                                item: item,
                                workDescription: workDescription,
                                isCopy: item.isCopy,
                                onCopy: () {
                                  var copyValue = item.workDescription ?? '';
                                  Clipboard.setData(ClipboardData(text: copyValue)).then((_) {
                                    item.isCopy = true;
                                    ptdCtrl.update();
                                    log("Copied value to clipboard: $copyValue");
                                  }).catchError((error) {
                                    log("Failed to copy to clipboard: $error");
                                  });
                                  item.isCopy = true;
                                  ptdCtrl.update();
                                  log("Copy value is $copyValue");
                                },
                                onEdit: () {
                                  Get.toNamed(Routes.addWorkLog, arguments: {
                                    'taskId': item.id,
                                    'isFromEdit': true,
                                    'project': ptdCtrl.projectTaskAssigneeModel?.projectName ?? '',
                                    'task': ptdCtrl.projectTaskAssigneeModel?.taskName ?? '',
                                    'hours': item.logHours,
                                    'date': item.logDate,
                                    'workDescription': workDescription,
                                  })?.then((value) {
                                    if (value != null) {
                                      ptdCtrl.isSomethingNew = true;
                                      ptdCtrl.pagingController.refresh();
                                    }
                                  });
                                },
                                onDelete: () {
                                  Utility.deleteConformationDialog(
                                    onConfirm: () {
                                      Get.back();
                                      ptdCtrl.deleteTaskWorkLog(indexID: item.id ?? 0);
                                      ptdCtrl.isSomethingNew = true;
                                      ptdCtrl.update();
                                    },
                                    date: Global.formatDate(item.logDate ?? ''),
                                  );
                                },
                              );
                              if (shouldAnimate) {
                                ptdCtrl.animatedIndices.add(index);
                                return isRightOrLeft
                                    ? FadeInRightBig(child: taskWidget)
                                    : FadeInLeftBig(child: taskWidget);
                              } else {
                                return taskWidget;
                              }
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget taskCard({
    required Color cardColor,
    var item,
    required String workDescription,
    Function()? onCopy,
    Function()? onDelete,
    Function()? onEdit,
    bool? isCopy,
  }) {
    return Card(
      elevation: 3,
      surfaceTintColor: cardColor,
      margin: EdgeInsets.all(10.sp),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  // Date
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.yelloww.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      Global.formatDate(item.logDate ?? ''),
                      style: CommonText.style500S16.copyWith(
                        color: AppColors.yelloww,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 15.w,
                    color: AppColors.yelloww,
                  ),
                  Text(
                    "${item.logHours ?? ''} ${AppString.hrs}",
                    style: CommonText.style500S16.copyWith(
                      color: AppColors.greyyDark,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: onCopy,
                    child: Icon(
                      isCopy == true
                          ? TablerIcons.copy_check_filled
                          : TablerIcons.copy,
                      color: AppColors.blackk,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: onEdit,
                    child: Icon(TablerIcons.edit, size: 20.sp,),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: onDelete,
                    child: Icon(TablerIcons.trash, size: 20.sp,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            HtmlWidget(
              workDescription,
              onTapUrl: (url) async {
                Uri uri = Uri.parse(url);
                if (!await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch $url');
                }
                return true;
              },
              renderMode: RenderMode.column,
            ),
          ],
        ),
      ),
    );
  }
}
