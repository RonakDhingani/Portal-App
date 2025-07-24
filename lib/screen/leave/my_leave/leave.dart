// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_date_range_picker.dart';
import 'package:inexture/common_widget/request_component/request_details.dart';
import 'package:inexture/common_widget/request_component/status_labels.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/controller/leave_controller.dart';
import 'package:inexture/model/leave_request_model.dart' as leaveRequest;
import 'package:inexture/model/my_leave_model.dart';
import 'package:inexture/routes/app_pages.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/common_dropdown_menu.dart';
import '../../../common_widget/global_value.dart';
import '../../../common_widget/request_component/request_details_tile.dart';
import '../../../utils/utility.dart';

class LeaveScreen extends GetView<LeaveController> {
  LeaveScreen({super.key});

  @override
  LeaveController controller = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(
      builder: (leaveController) {
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.leave,
            widget: Row(
              children: [
                Visibility(
                  visible: leaveController.controller.index == 1,
                  replacement: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: leaveController.dropdownValue == ''
                        ? null
                        : CommonDropdownMenuForYear(
                            isDefaultSelected:
                                leaveController.isDefaultSelected,
                            dropdownValue: leaveController.dropdownValue,
                            value: leaveController.isDefaultSelected
                                ? null
                                : leaveController.dropdownValue,
                            items: leaveController.dropdownItems,
                            onChanged: (value) {
                              leaveController.dropdownValue = value;
                              leaveController.status = '';
                              leaveController.currentIndex = 0;
                              leaveController.isDefaultSelected = false;
                              leaveController.update();
                              if (value != null) {
                                List<String> parts = value.split(' - ');
                                if (parts.length == 2) {
                                  leaveController.startYear = parts[0];
                                  leaveController.endYear = parts[1];
                                  leaveController.getMyLeavesData(
                                      isStatus: true, isShowLoading: true);
                                }
                              }
                            },
                          ),
                  ),
                  child: CommonDateRangePicker(
                    onSubmit: (p0) {
                      Get.back();
                      leaveController.onSelectionChanged(
                          DateRangePickerSelectionChangedArgs(p0));
                      leaveController.getLeaveRequest(
                          isStatus: true, isShowLoading: true);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: leaveController.isLoading
              ? Utility.circleProcessIndicator()
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StatusLabels(
                        total: leaveController.controller.index == 1
                            ? leaveController
                                    .leaveRequestModel?.labels?.totalData
                                    .toString() ??
                                '0'
                            : leaveController.myLeaveModel?.labels?.totalData
                                    .toString() ??
                                '0',
                        approved: leaveController.controller.index == 1
                            ? leaveController
                                    .leaveRequestModel?.labels?.approved
                                    .toString() ??
                                '0'
                            : leaveController.myLeaveModel?.labels?.approved
                                    .toString() ??
                                '0',
                        pending: leaveController.controller.index == 1
                            ? leaveController.leaveRequestModel?.labels?.pending
                                    .toString() ??
                                '0'
                            : leaveController.myLeaveModel?.labels?.pending
                                    .toString() ??
                                '0',
                        cancelled: leaveController.controller.index == 1
                            ? leaveController
                                    .leaveRequestModel?.labels?.cancelled
                                    .toString() ??
                                '0'
                            : leaveController.myLeaveModel?.labels?.cancelled
                                    .toString() ??
                                '0',
                        rejected: leaveController.controller.index == 1
                            ? leaveController
                                    .leaveRequestModel?.labels?.rejected
                                    .toString() ??
                                '0'
                            : leaveController.myLeaveModel?.labels?.rejected
                                    .toString() ??
                                '0',
                        status: leaveController.status,
                        currentPage:
                            ValueNotifier(leaveController.currentIndex),
                        pageController: leaveController.pageController,
                        onPageChanged: (index) {
                          leaveController.currentIndex = index;
                          switch (index) {
                            case 0:
                              return {
                                leaveController.status = '',
                                leaveController.update(),
                                leaveController.controller.index == 1
                                    ? leaveController.getLeaveRequest(
                                        isStatus: true)
                                    : leaveController.getMyLeavesData(
                                        isStatus: true),
                              };
                            case 1:
                              return {
                                leaveController.status = AppString.pending,
                                leaveController.update(),
                                leaveController.controller.index == 1
                                    ? leaveController.getLeaveRequest(
                                        isStatus: true)
                                    : leaveController.getMyLeavesData(
                                        isStatus: true),
                              };
                            case 2:
                              return {
                                leaveController.status = AppString.approvedSmall,
                                leaveController.update(),
                                leaveController.controller.index == 1
                                    ? leaveController.getLeaveRequest(
                                        isStatus: true)
                                    : leaveController.getMyLeavesData(
                                        isStatus: true),
                              };
                            case 3:
                              return {
                                leaveController.status = AppString.cancelled,
                                leaveController.update(),
                                leaveController.controller.index == 1
                                    ? leaveController.getLeaveRequest(
                                        isStatus: true)
                                    : leaveController.getMyLeavesData(
                                        isStatus: true),
                              };
                            case 4:
                              return {
                                leaveController.status = AppString.rejected,
                                leaveController.update(),
                                leaveController.controller.index == 1
                                    ? leaveController.getLeaveRequest(
                                        isStatus: true)
                                    : leaveController.getMyLeavesData(
                                        isStatus: true),
                              };
                            default:
                              break;
                          }
                        },
                      ),
                      permissionList.contains("list_leaverequest")
                          ? TabBar(
                              labelStyle: CommonText.style500S15,
                              unselectedLabelStyle: CommonText.style500S15
                                  .copyWith(color: AppColors.blackk),
                              indicator: BoxDecoration(
                                color: AppColors.yelloww,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: AppColors.whitee,
                              dividerColor: AppColors.transparent,
                              splashBorderRadius: BorderRadius.circular(20),
                              padding: EdgeInsets.only(bottom: 10),
                              controller: leaveController.controller,
                              tabs: leaveController.myTabs,
                            )
                          : Container(),
                      Expanded(
                        child: TabBarView(
                          controller: leaveController.controller,
                          physics: permissionList.contains("list_leaverequest")
                              ? ScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              child: leaveController
                                          .myLeaveModel?.results?.length ==
                                      0
                                  ? Utility.dataNotFound()
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: PagedListView<int, Results>(
                                            pagingController: leaveController
                                                .pagingController,
                                            scrollController: leaveController
                                                .scrollController,
                                            builderDelegate:
                                                PagedChildBuilderDelegate<
                                                    Results>(
                                              firstPageProgressIndicatorBuilder:
                                                  (_) => Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Utility
                                                    .circleProcessIndicator(),
                                              ),
                                              firstPageErrorIndicatorBuilder:
                                                  (_) => Utility.dataNotFound(),
                                              noItemsFoundIndicatorBuilder:
                                                  (_) => Utility.dataNotFound(),
                                              animateTransitions: true,
                                              itemBuilder:
                                                  (context, item, index) {
                                                return RequestDetailsTile(
                                                  commentsCount: item
                                                      .commentCount
                                                      .toString(),
                                                  comments: item.comments ?? [],
                                                  color:
                                                      Global.getColorForStatus(
                                                          status: item.status
                                                              .toString()),
                                                  leaveStatus: item.status,
                                                  duration: item.duration,
                                                  startDate: Global.formatDate(
                                                    item.startDate ??
                                                        "2024-04-11",
                                                  ),
                                                  endDate: Global.formatDate(
                                                    item.endDate ??
                                                        "2024-04-11",
                                                  ),
                                                  leaveType: item.type,
                                                  onTap: () {
                                                    Get.to(
                                                      () => RequestDetails(),
                                                      arguments: {
                                                        "isMyLeave": true,
                                                        "isWorkFromHome": false,
                                                        "isLeaveWFH": false,
                                                        "reqUserID": item.id,
                                                        "reqFromID": item
                                                            .requestFrom?.id,
                                                        "reason":
                                                            item.reason ?? '',
                                                        "status":
                                                            item.status ?? '',
                                                        "isAdhocLeave":
                                                            item.isadhocLeave,
                                                        "isAvailableOnPhone":
                                                            item.availableOnPhone,
                                                        "isAvailableOnCity":
                                                            item.availableOnCity,
                                                        "requestedLeaves":
                                                            item.duration,
                                                        "phone": item
                                                            .emergencyContact,
                                                        "dayType": item.type,
                                                        "halfDayTime":
                                                            item.halfDayStatus,
                                                        "returnDate":
                                                            Global.formatDate(
                                                                item.returnDate ??
                                                                    ""),
                                                        "startDate":
                                                            Global.formatDate(
                                                                item.startDate ??
                                                                    ""),
                                                        "endDate":
                                                            Global.formatDate(
                                                                item.endDate ??
                                                                    ""),
                                                        "requestedDate":
                                                            Global.formatDate(
                                                                item.createdAt ??
                                                                    ""),
                                                        "comments":
                                                            item.comments,
                                                      },
                                                    )?.then(
                                                      (value) {
                                                        if (value != null) {
                                                          leaveController
                                                              .pagingController
                                                              .refresh();
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            Container(
                              child: leaveController
                                          .leaveRequestModel?.results?.length ==
                                      0
                                  ? Utility.dataNotFound()
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: PagedListView<int,
                                              leaveRequest.Results>(
                                            pagingController: leaveController
                                                .leaveReqController,
                                            builderDelegate:
                                                PagedChildBuilderDelegate<
                                                    leaveRequest.Results>(
                                              firstPageProgressIndicatorBuilder:
                                                  (_) => Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Utility
                                                    .circleProcessIndicator(),
                                              ),
                                              firstPageErrorIndicatorBuilder:
                                                  (_) => Utility.dataNotFound(),
                                              noItemsFoundIndicatorBuilder:
                                                  (_) => Utility.dataNotFound(),
                                              newPageProgressIndicatorBuilder:
                                                  (_) => Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Utility
                                                    .circleProcessIndicator(),
                                              ),
                                              animateTransitions: true,
                                              itemBuilder:
                                                  (context, item, index) {
                                                return RequestDetailsTile(
                                                  commentsCount: item
                                                      .commentCount
                                                      .toString(),
                                                  comments: item.comments ?? [],
                                                  firstName:
                                                      "${item.requestFrom?.firstName}",
                                                  lastName:
                                                      "${item.requestFrom?.lastName}",
                                                  image:
                                                      item.requestFrom?.image,
                                                  color:
                                                      Global.getColorForStatus(
                                                          status: item.status
                                                              .toString()),
                                                  leaveStatus: item.status,
                                                  duration: item.duration,
                                                  startDate: Global.formatDate(
                                                    item.startDate ??
                                                        "2024-04-11",
                                                  ),
                                                  endDate: Global.formatDate(
                                                    item.endDate ??
                                                        "2024-04-11",
                                                  ),
                                                  leaveType: item.type,
                                                  halfDayStatus:
                                                      item.halfDayStatus,
                                                  onTap: () {
                                                    Get.to(
                                                      () => RequestDetails(),
                                                      arguments: {
                                                        "isMyLeave": false,
                                                        "isWorkFromHome": false,
                                                        "isRequest": true,
                                                        "isLeaveWFH": false,
                                                        "reqFromID": item
                                                            .requestFrom?.id,
                                                        "reason":
                                                            item.reason ?? '',
                                                        "status":
                                                            item.status ?? '',
                                                        "isAdhocLeave":
                                                            item.isadhocLeave,
                                                        "isAvailableOnPhone":
                                                            item.availableOnPhone,
                                                        "isAvailableOnCity":
                                                            item.availableOnCity,
                                                        "requestedLeaves":
                                                            item.duration,
                                                        "phone": item
                                                            .emergencyContact,
                                                        "dayType": item.type,
                                                        "halfDayTime":
                                                            item.halfDayStatus,
                                                        "returnDate":
                                                            Global.formatDate(
                                                                item.returnDate ??
                                                                    ""),
                                                        "startDate":
                                                            Global.formatDate(
                                                                item.startDate ??
                                                                    ""),
                                                        "endDate":
                                                            Global.formatDate(
                                                                item.endDate ??
                                                                    ""),
                                                        "requestedDate":
                                                            Global.formatDate(
                                                                item.createdAt ??
                                                                    ""),
                                                        "comments":
                                                            item.comments,
                                                        "reqUserID": item.id,
                                                        "requestUserDetails":
                                                            item.requestFrom,
                                                      },
                                                    )?.then(
                                                      (value) {
                                                        if (value != null) {
                                                          leaveController
                                                              .leaveReqController
                                                              .refresh();
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: !leaveController.isAtBottom &&
                  leaveController.controller.index == 0
              ? FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(Routes.addLeave)?.then((value) {
                      if (value != null) {
                        leaveController.status = '';
                        leaveController.update();
                        Utility.showFlushBar(text: value);
                        return leaveController.getMyLeavesData(
                            isShowLoading: true, isStatus: true);
                      }
                    });
                  },
                  shape: const StadiumBorder(),
                  backgroundColor: AppColors.yelloww,
                  child: const Icon(
                    Icons.add,
                    color: AppColors.whitee,
                  ),
                )
              : null,
        );
      },
    );
  }
}
