// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/common_date_range_picker.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/model/my_work_from_home_model.dart';
import 'package:inexture/model/wfh_request_model.dart' as wfhRequest;
import 'package:inexture/utils/utility.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../common_widget/app_string.dart';
import '../../common_widget/common_app_bar.dart';
import '../../common_widget/common_dropdown_menu.dart';
import '../../common_widget/global_value.dart';
import '../../common_widget/request_component/request_details.dart';
import '../../common_widget/request_component/request_details_tile.dart';
import '../../common_widget/request_component/status_labels.dart';
import '../../controller/my_work_from_home_controller.dart';
import '../../routes/app_pages.dart';

class MyWorkFromHomeScreen extends GetView<MyWorkFromHomeController> {
  MyWorkFromHomeScreen({super.key});

  @override
  MyWorkFromHomeController controller = Get.put(MyWorkFromHomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWorkFromHomeController>(
      builder: (myWorkFromHomeController) {
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.myWorkFromHome,
            widget: Row(
              children: [
                Visibility(
                  visible: myWorkFromHomeController.controller.index == 1,
                  replacement: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: myWorkFromHomeController.dropdownValue == ''
                          ? null
                          : CommonDropdownMenuForYear(
                              isDefaultSelected:
                                  myWorkFromHomeController.isDefaultSelected,
                              dropdownValue:
                                  myWorkFromHomeController.dropdownValue,
                              value: myWorkFromHomeController.isDefaultSelected
                                  ? null
                                  : myWorkFromHomeController.dropdownValue,
                              items: myWorkFromHomeController.dropdownItems,
                              onChanged: (value) {
                                myWorkFromHomeController.dropdownValue = value;
                                myWorkFromHomeController.status = '';
                                myWorkFromHomeController.currentIndex = 0;
                                myWorkFromHomeController.isDefaultSelected =
                                    false;
                                myWorkFromHomeController.update();
                                if (value != null) {
                                  List<String> parts = value.split(' - ');
                                  if (parts.length == 2) {
                                    myWorkFromHomeController.startYear =
                                        parts[0];
                                    myWorkFromHomeController.endYear = parts[1];
                                    myWorkFromHomeController.getMyWorkFromHome(
                                        isStatus: true, isShowLoading: true);
                                  }
                                }
                              },
                            )),
                  child: CommonDateRangePicker(
                    onSubmit: (p0) {
                      Get.back();
                      myWorkFromHomeController.onSelectionChanged(
                          DateRangePickerSelectionChangedArgs(p0));
                      myWorkFromHomeController.getWFHRequest(
                          isStatus: true, isShowLoading: true);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: myWorkFromHomeController.isLoading
              ? Utility.circleProcessIndicator()
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      StatusLabels(
                        total: myWorkFromHomeController.controller.index == 1
                            ? myWorkFromHomeController
                                    .wfhRequestModel?.labels?.totalData
                                    .toString() ??
                                '0'
                            : myWorkFromHomeController
                                    .myWorkFromHomeModel?.labels?.totalData
                                    .toString() ??
                                '0',
                        approved: myWorkFromHomeController.controller.index == 1
                            ? myWorkFromHomeController
                                    .wfhRequestModel?.labels?.approved
                                    .toString() ??
                                '0'
                            : myWorkFromHomeController
                                    .myWorkFromHomeModel?.labels?.approved
                                    .toString() ??
                                '0',
                        pending: myWorkFromHomeController.controller.index == 1
                            ? myWorkFromHomeController
                                    .wfhRequestModel?.labels?.pending
                                    .toString() ??
                                '0'
                            : myWorkFromHomeController
                                    .myWorkFromHomeModel?.labels?.pending
                                    .toString() ??
                                '0',
                        cancelled:
                            myWorkFromHomeController.controller.index == 1
                                ? myWorkFromHomeController
                                        .wfhRequestModel?.labels?.cancelled
                                        .toString() ??
                                    '0'
                                : myWorkFromHomeController
                                        .myWorkFromHomeModel?.labels?.cancelled
                                        .toString() ??
                                    '0',
                        rejected: myWorkFromHomeController.controller.index == 1
                            ? myWorkFromHomeController
                                    .wfhRequestModel?.labels?.rejected
                                    .toString() ??
                                '0'
                            : myWorkFromHomeController
                                    .myWorkFromHomeModel?.labels?.rejected
                                    .toString() ??
                                '0',
                        status: myWorkFromHomeController.status,
                        currentPage: ValueNotifier(
                            myWorkFromHomeController.currentIndex),
                        pageController: myWorkFromHomeController.pageController,
                        onPageChanged: (index) {
                          myWorkFromHomeController.currentIndex = index;
                          switch (index) {
                            case 0:
                              return {
                                myWorkFromHomeController.status = '',
                                myWorkFromHomeController.update(),
                                myWorkFromHomeController.controller.index == 1
                                    ? myWorkFromHomeController.getWFHRequest(
                                        isStatus: true)
                                    : myWorkFromHomeController
                                        .getMyWorkFromHome(isStatus: true),
                              };
                            case 1:
                              return {
                                myWorkFromHomeController.status = AppString.pending,
                                myWorkFromHomeController.update(),
                                myWorkFromHomeController.controller.index == 1
                                    ? myWorkFromHomeController.getWFHRequest(
                                        isStatus: true)
                                    : myWorkFromHomeController
                                        .getMyWorkFromHome(isStatus: true),
                              };
                            case 2:
                              return {
                                myWorkFromHomeController.status = AppString.approvedSmall,
                                myWorkFromHomeController.update(),
                                myWorkFromHomeController.controller.index == 1
                                    ? myWorkFromHomeController.getWFHRequest(
                                        isStatus: true)
                                    : myWorkFromHomeController
                                        .getMyWorkFromHome(isStatus: true),
                              };
                            case 3:
                              return {
                                myWorkFromHomeController.status = AppString.cancelled,
                                myWorkFromHomeController.update(),
                                myWorkFromHomeController.controller.index == 1
                                    ? myWorkFromHomeController.getWFHRequest(
                                        isStatus: true)
                                    : myWorkFromHomeController
                                        .getMyWorkFromHome(isStatus: true),
                              };
                            case 4:
                              return {
                                myWorkFromHomeController.status = AppString.rejected,
                                myWorkFromHomeController.update(),
                                myWorkFromHomeController.controller.index == 1
                                    ? myWorkFromHomeController.getWFHRequest(
                                        isStatus: true)
                                    : myWorkFromHomeController
                                        .getMyWorkFromHome(isStatus: true),
                              };
                            default:
                              break;
                          }
                        },
                      ),
                      permissionList.contains("list_workfromhome")
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
                              controller: myWorkFromHomeController.controller,
                              tabs: myWorkFromHomeController.myTabs,
                            )
                          : Container(),
                      Expanded(
                        child: TabBarView(
                          controller: myWorkFromHomeController.controller,
                          physics: permissionList.contains("list_workfromhome")
                              ? ScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              child: myWorkFromHomeController
                                          .myWorkFromHomeModel
                                          ?.results
                                          ?.length ==
                                      0
                                  ? Utility.dataNotFound()
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: PagedListView<int, Results>(
                                            pagingController:
                                                myWorkFromHomeController
                                                    .pagingController,
                                            scrollController:
                                                myWorkFromHomeController
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
                                                  monthlyWFH: item
                                                      .currentMonthTotalWFH
                                                      .toString(),
                                                  isWorkFromHome: true,
                                                  onTap: () {
                                                    Get.to(
                                                      () => RequestDetails(),
                                                      arguments: {
                                                        "isMyLeave": false,
                                                        "isWorkFromHome": true,
                                                        "isWFHRequest": false,
                                                        "isLeaveWFH": true,
                                                        "reqUserID": item.id,
                                                        "reqFromID": item
                                                            .requestFrom?.id,
                                                        "reason":
                                                            item.reason ?? '',
                                                        "status":
                                                            item.status ?? '',
                                                        "isAdhocLeave":
                                                            item.isadhocWfh,
                                                        "isAvailableOnPhone":
                                                            item.isadhocWfh,
                                                        "isAvailableOnCity":
                                                            item.isadhocWfh,
                                                        "requestedLeaves":
                                                            item.duration,
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
                                                          myWorkFromHomeController
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
                              child: myWorkFromHomeController
                                          .wfhRequestModel?.results?.length ==
                                      0
                                  ? Utility.dataNotFound()
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: PagedListView<int,
                                              wfhRequest.Results>(
                                            pagingController:
                                                myWorkFromHomeController
                                                    .wfhReqController,
                                            builderDelegate:
                                                PagedChildBuilderDelegate<
                                                    wfhRequest.Results>(
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
                                                  monthlyWFH: item
                                                      .currentMonthTotalWFH
                                                      .toString(),
                                                  halfDayStatus:
                                                      item.halfDayStatus,
                                                  isWorkFromHome: true,
                                                  onTap: () {
                                                    Get.to(
                                                      () => RequestDetails(),
                                                      arguments: {
                                                        "isMyLeave": false,
                                                        "isWFHRequest": true,
                                                        "isWorkFromHome": false,
                                                        "isLeaveWFH": true,
                                                        "reqUserID": item.id,
                                                        "reqFromID": item
                                                            .requestFrom?.id,
                                                        "reason":
                                                            item.reason ?? '',
                                                        "status":
                                                            item.status ?? '',
                                                        "isAdhocLeave":
                                                            item.isadhocWfh,
                                                        "isAvailableOnPhone":
                                                            item.isadhocWfh,
                                                        "isAvailableOnCity":
                                                            item.isadhocWfh,
                                                        "requestedLeaves":
                                                            item.duration,
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
                                                        "wfhReqUserDetails ":
                                                            item.requestFrom,
                                                      },
                                                    )?.then(
                                                      (value) {
                                                        if (value != null) {
                                                          myWorkFromHomeController
                                                              .wfhReqController
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
                      )
                    ],
                  ),
                ),
          floatingActionButton: !myWorkFromHomeController.isAtBottom &&
                  myWorkFromHomeController.controller.index == 0
              ? FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(Routes.addWorkFromHome)?.then((value) {
                      if (value != null) {
                        myWorkFromHomeController.status = '';
                        myWorkFromHomeController.update();
                        Utility.showFlushBar(text: value);
                        return myWorkFromHomeController.getMyWorkFromHome(
                          isShowLoading: true,
                          isStatus: true,
                        );
                      }
                    });
                  },
                  shape: StadiumBorder(),
                  backgroundColor: AppColors.yelloww,
                  child: Icon(
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
