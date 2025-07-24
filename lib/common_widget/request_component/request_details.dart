// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/common_info_ui.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:inexture/common_widget/profile_image.dart';
import 'package:inexture/controller/request_details_controller.dart';
import 'package:inexture/utils/utility.dart';
import 'package:intl/intl.dart';

import '../../controller/main_home_controller.dart';
import '../text.dart';
import '../textfield.dart';

class RequestDetails extends GetView<RequestDetailsController> {
  RequestDetails({super.key});

  @override
  final RequestDetailsController controller =
      Get.put(RequestDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestDetailsController>(builder: (reqDetailsCtrl) {
      var userDetails =
          Get.find<MainHomeController>().userProfileDetailsModel?.data;
      String? imageUrl = reqDetailsCtrl.isRequest
          ? reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.image
          : reqDetailsCtrl.isWFHRequest
              ? reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.image
              : userDetails?.image;

      return WillPopScope(
        onWillPop: () async {
          if (reqDetailsCtrl.isUpdated) {
            Get.back(result: "Update something");
          } else {
            Get.back();
          }
          return false;
        },
        child: Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: reqDetailsCtrl.isLeaveWFH
                ? reqDetailsCtrl.isWFHRequest
                    ? AppString.workFromHomeReqDetails
                    : AppString.myWorkFromHomeDetails
                : reqDetailsCtrl.isRequest
                    ? AppString.leaveReqDetails
                    : AppString.myLeaveDetails,
            onPressed: () {
              if (reqDetailsCtrl.isUpdated) {
                Get.back(result: "Update something");
              } else {
                Get.back();
              }
            },
          ),
          body: reqDetailsCtrl.isGettingDetails
              ? Utility.circleProcessIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: imageUrl == null || imageUrl.isEmpty
                                      ? null
                                      : Border.all(
                                          color: AppColors.greyyDark, width: 2),
                                ),
                                child: ProfileImage(
                                  userName: reqDetailsCtrl.isRequest
                                      ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.firstName?[0].toUpperCase()}${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.lastName?[0].toUpperCase()}")
                                      : reqDetailsCtrl.isWFHRequest
                                          ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.firstName?[0].toUpperCase()}${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.lastName?[0].toUpperCase()}")
                                          : ("${userDetails?.firstName?[0].toUpperCase()}${userDetails?.lastName?[0].toUpperCase()}"),
                                  profileImage: "$imageUrl",
                                  name: reqDetailsCtrl.isRequest
                                      ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.firstName}${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.lastName}")
                                      : reqDetailsCtrl.isWFHRequest
                                          ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.firstName}${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.lastName}")
                                          : ("${userDetails?.firstName}${userDetails?.lastName}"),
                                ),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        reqDetailsCtrl.isRequest
                                            ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.firstName} ${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.lastName} - ")
                                            : reqDetailsCtrl.isWFHRequest
                                                ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.firstName} ${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.lastName} - ")
                                                : ('${userDetails?.firstName} ${userDetails?.lastName} - '),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: CommonText.style600S15.copyWith(
                                          color: AppColors.blackk,
                                        ),
                                      ),
                                      Text(
                                        reqDetailsCtrl.isRequest
                                            ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.userOfficialDetails?.code}")
                                            : reqDetailsCtrl.isWFHRequest
                                                ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.userOfficialDetails?.code}")
                                                : (userDetails
                                                        ?.userdetails?.code ??
                                                    ''),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: CommonText.style500S12.copyWith(
                                          color: AppColors.blackk,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.yelloww.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      reqDetailsCtrl.isRequest
                                          ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.userOfficialDetails?.designation}")
                                          : reqDetailsCtrl.isWFHRequest
                                              ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.userOfficialDetails?.designation}")
                                              : ("${userDetails?.userdetails?.designationName?.name}"),
                                      maxLines: 2,
                                      style: CommonText.style500S13
                                          .copyWith(color: AppColors.yelloww),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.redd.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      reqDetailsCtrl.isRequest
                                          ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.userOfficialDetails?.team}")
                                          : reqDetailsCtrl.isWFHRequest
                                              ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.userOfficialDetails?.team}")
                                              : ("${userDetails?.userdetails?.teamName?.name}"),
                                      maxLines: 2,
                                      style: CommonText.style500S13
                                          .copyWith(color: AppColors.redd),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 13.h,
                          right: 10.w,
                          child: InkWell(
                            splashColor: AppColors.transparent,
                            onTap: () {
                              var userId = reqDetailsCtrl.isRequest
                                  ? ("${reqDetailsCtrl.lvReqUserDtlMdl?.data?.requestFrom?.id}")
                                  : reqDetailsCtrl.isWFHRequest
                                      ? ("${reqDetailsCtrl.wfhReqUserDtlMdl?.data?.requestFrom?.id}")
                                      : ("${userDetails?.id}");
                              reqDetailsCtrl.getUserinfo(userId);
                            },
                            child: reqDetailsCtrl.isLoadUserInfo
                                ? SizedBox(
                                    height: 30.h,
                                    width: 30.w,
                                    child: Utility.circleProcessIndicator(),
                                  )
                                : Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.yelloww,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(
                                  horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppString.status,
                                        style: CommonText.style600S16.copyWith(
                                          color: AppColors.blackk,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 2,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: Global.getColorForStatus(
                                            status:
                                                reqDetailsCtrl.getStatus() ??
                                                    '',
                                          ).withOpacity(0.1),
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                              color: Global.getColorForStatus(
                                                status: reqDetailsCtrl
                                                        .getStatus() ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          reqDetailsCtrl
                                                  .getStatus()
                                                  ?.capitalizeFirst ??
                                              '',
                                          style:
                                              CommonText.style500S14.copyWith(
                                            color: Global.getColorForStatus(
                                              status:
                                                  reqDetailsCtrl.getStatus() ??
                                                      '',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(
                                  horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppString.reason,
                                        style: CommonText.style600S16.copyWith(
                                          color: AppColors.blackk,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    child: Text(
                                      reqDetailsCtrl.reason ?? '',
                                      maxLines: reqDetailsCtrl.reason?.length,
                                      style: CommonText.style500S14.copyWith(
                                        color: AppColors.greyyDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonExpansionPanelList(
                              expansionCallback: (p0, p1) {
                                reqDetailsCtrl.isExpLeave = !p1;
                                reqDetailsCtrl.update();
                              },
                              titleInfo: reqDetailsCtrl.isLeaveWFH
                                  ? AppString.wfhInfo
                                  : AppString.leaveInfo,
                              isExpand: reqDetailsCtrl.isExpLeave,
                              isAddPadding: true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child:
                                    CommonPersonalUiWidget.commonRequestInfoUI(
                                  isWorkFromHome: !reqDetailsCtrl.isLeaveWFH,
                                  returnDate: reqDetailsCtrl.returnDate,
                                  requestedDate: reqDetailsCtrl.requestedDate,
                                  startDate: reqDetailsCtrl.startDate,
                                  endDate: reqDetailsCtrl.endDate,
                                  requestedLeaves:
                                      reqDetailsCtrl.requestedLeaves,
                                  phone: reqDetailsCtrl.phone,
                                  dayType: reqDetailsCtrl.dayType ?? '',
                                  halfDayTime: reqDetailsCtrl.halfDayTime,
                                  isAdhocLeave: reqDetailsCtrl.isAdhocLeave,
                                  isAvailableOnPhone:
                                      reqDetailsCtrl.isAvailableOnPhone,
                                  isAvailableOnCity:
                                      reqDetailsCtrl.isAvailableOnCity,
                                ),
                              ),
                            ),
                            CommonExpansionPanelList(
                              expansionCallback: (p0, p1) {
                                reqDetailsCtrl.isExpComment = !p1;
                                reqDetailsCtrl.update();
                              },
                              titleInfo: AppString.comments,
                              isExpand: reqDetailsCtrl.isExpComment,
                              isAddPadding: true,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Visibility(
                                  visible:
                                      reqDetailsCtrl.getComment()?.length == 0
                                          ? false
                                          : true,
                                  replacement: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Center(
                                      child: Text(
                                        AppString.noCommentsYet,
                                        style: CommonText.style500S15.copyWith(
                                          color: AppColors.blackk,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                            0.5 -
                                        10,
                                    child: ListView.builder(
                                      itemCount:
                                          reqDetailsCtrl.getComment()?.length ??
                                              0,
                                      itemBuilder: (context, index) {
                                        var cmtValue =
                                            reqDetailsCtrl.getComment()?[index];
                                        return Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ProfileImage(
                                                  userName:
                                                      '${cmtValue.reviewBy?.firstName?[0].toUpperCase()}${cmtValue.reviewBy?.lastName?[0].toUpperCase()}',
                                                  profileImage: cmtValue
                                                          .reviewBy?.image ??
                                                      '',
                                                  radius: 20,
                                                  name:
                                                      "${cmtValue.reviewBy?.firstName} ${cmtValue.reviewBy?.lastName}",
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${cmtValue?.reviewBy?.firstName} ${cmtValue?.reviewBy?.lastName}",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: CommonText
                                                                .style500S15
                                                                .copyWith(
                                                              color: AppColors
                                                                  .blackk,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5.w),
                                                            child: Text(
                                                              "${cmtValue.status == AppString.pending ? "" : cmtValue.status}"
                                                                  .capitalizeFirst
                                                                  .toString(),
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: CommonText
                                                                  .style500S13
                                                                  .copyWith(
                                                                color: Global
                                                                    .getColorForStatus(
                                                                  status: cmtValue
                                                                          .status ??
                                                                      AppString
                                                                          .pending,
                                                                  isFromCmt:
                                                                      true,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 3.h),
                                                      CommonText.richText(
                                                        firstTitle: AppString
                                                            .commentsColan,
                                                        secTitle: (cmtValue
                                                                .comments ??
                                                            ""),
                                                        color: AppColors.blackk,
                                                        fontSize: 13,
                                                        fontSize2: 13,
                                                        firstColor:
                                                            AppColors.blues,
                                                        maxLines: cmtValue
                                                            .comments.length,
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            Global.formatDateMonthNameAMPM(
                                                                cmtValue
                                                                    .createdAt),
                                                            style: CommonText
                                                                .style500S12
                                                                .copyWith(
                                                              color: AppColors
                                                                  .greyyDark,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5.h),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: BottomSheet(
            shape: Border.all(
              color: AppColors.greyy,
            ),
            onClosing: () {},
            builder: (context) => ValueListenableBuilder<bool>(
              valueListenable: reqDetailsCtrl.submitButtonEnabledNotifier,
              builder: (context, isButtonEnabled, child) {
                return SizedBox(
                  height: 90.h,
                  child: reqDetailsCtrl.isGettingDetails
                      ? Utility.shimmerLoading(
                          borderRadius: BorderRadius.circular(0),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  AppString.handleRequest,
                                  style: CommonText.style500S18.copyWith(
                                    color: AppColors.blackk,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (reqDetailsCtrl.isRequest ||
                                      reqDetailsCtrl.isWFHRequest)
                                    if (reqDetailsCtrl.getStatus() !=
                                        AppString.cancelled)
                                      if (reqDetailsCtrl.getStatus() !=
                                          AppString.approvedSmall)
                                        if (reqDetailsCtrl.userApproveReq ==
                                            false)
                                          IconButton(
                                            onPressed: () {
                                              showLeaveApprovalDialog(
                                                  status: AppString.approve);
                                            },
                                            tooltip: AppString.approve,
                                            icon: Icon(
                                              TablerIcons.circle_check,
                                              color: AppColors.greenn,
                                              size: 35,
                                            ),
                                          ),
                                  if (reqDetailsCtrl.isRequest ||
                                      reqDetailsCtrl.isWFHRequest)
                                    if (reqDetailsCtrl.getStatus() !=
                                        AppString.cancelled)
                                      if (reqDetailsCtrl.getStatus() !=
                                          AppString.rejected)
                                        if (reqDetailsCtrl.userRejectReq ==
                                            false)
                                          IconButton(
                                            onPressed: () {
                                              showLeaveApprovalDialog(
                                                  status: AppString.reject);
                                            },
                                            tooltip: AppString.reject,
                                            icon: Icon(
                                              TablerIcons.ban,
                                              color: AppColors.redd,
                                              size: 30,
                                            ),
                                          ),
                                  if (reqDetailsCtrl.getStatus() !=
                                          AppString.cancelled &&
                                      DateFormat("dd-MM-yyyy")
                                          .parse(reqDetailsCtrl.startDate ?? '')
                                          .isAfter(DateFormat("dd-MM-yyyy")
                                              .parse(reqDetailsCtrl
                                                  .formattedDate)) &&
                                      userId == reqDetailsCtrl.reqFromID)
                                    IconButton(
                                      onPressed: () {
                                        showLeaveApprovalDialog(
                                          status: AppString.cancel,
                                        );
                                      },
                                      tooltip: AppString.cancel,
                                      icon: Icon(
                                        TablerIcons.x,
                                        color: AppColors.blues,
                                        size: 30,
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: () {
                                      showLeaveApprovalDialog(
                                          status: AppString.comments);
                                    },
                                    tooltip: AppString.comments,
                                    icon: Icon(
                                      TablerIcons.message,
                                      color: AppColors.yelloww,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
        ),
      );
    });
  }

  void showLeaveApprovalDialog({
    required String status,
  }) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return ValueListenableBuilder<String>(
          valueListenable: controller.commentTextNotifier,
          builder: (context, commentText, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Form(
                key: controller.cmtFormKey,
                child: AlertDialog(
                  insetPadding: const EdgeInsets.all(15),
                  contentPadding: const EdgeInsets.all(15),
                  actionsPadding: const EdgeInsets.all(15),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  backgroundColor: AppColors.whitee,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  icon: _buildAppBar(context: context, status: status),
                  iconPadding: const EdgeInsets.only(bottom: 10),
                  content: _buildDialogContent(context),
                  actions: _buildDialogActions(status: status),
                ),
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar({
    required BuildContext context,
    required String status,
  }) {
    return AppBar(
      surfaceTintColor: AppColors.whitee,
      backgroundColor: AppColors.whitee,
      shadowColor: AppColors.greyy,
      elevation: 2,
      automaticallyImplyLeading: false,
      leading: const Icon(TablerIcons.calendar_time),
      titleSpacing: 0,
      title: Text(
        "$status ${controller.isLeaveWFH ? AppString.wfh : AppString.leave}",
        style: CommonText.style600S16.copyWith(color: AppColors.blackk),
      ),
      actions: [
        IconButton(
          onPressed: () {
            controller.commentsController.clear();
            controller.submitButtonEnabledNotifier.value =
                controller.commentsController.text.trim().isNotEmpty;
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<String>(
              valueListenable: controller.commentTextNotifier,
              builder: (context, commentText, child) {
                return TextFieldCustom(
                  maxLines: 5,
                  onChanged: (value) {
                    controller.commentTextNotifier.value = value;
                    controller.submitButtonEnabledNotifier.value =
                        value.trim().isNotEmpty;
                  },
                  onPressed: () {},
                  title: AppString.comments,
                  hintText: AppString.enterComments,
                  controller: controller.commentsController,
                  isShow: true,
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Comment is required";
                    }
                    if (value?.trim().isEmpty == true) {
                      return "This field may not be blank.";
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDialogActions({
    required String status,
  }) {
    return [
      Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: controller.submitButtonEnabledNotifier,
          builder: (context, isButtonEnabled, child) {
            return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    isButtonEnabled ? AppColors.yelloww : AppColors.greyy),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color:
                        isButtonEnabled ? AppColors.yelloww : AppColors.greyy,
                  ),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: controller.isApproved
                  ? Utility.circleProcessIndicator(color: AppColors.whitee)
                  : Text(
                      AppString.submit,
                      style: CommonText.style600S18,
                    ),
              onPressed: () {
                if (controller.cmtFormKey.currentState!.validate()) {
                  if (status == AppString.approve) {
                    Get.back();
                    if (controller.isRequest == true) {
                      controller.lvReqApprove();
                    } else if (controller.isWFHRequest == true) {
                      controller.wfhReqApprove();
                    }
                  } else if (status == AppString.reject) {
                    Get.back();
                    if (controller.isRequest == true) {
                      controller.lvReqReject();
                    } else if (controller.isWFHRequest == true) {
                      controller.wfhReqReject();
                    }
                  } else if (status == AppString.cancel) {
                    Get.back();
                    if (controller.isMyLeave == true) {
                      controller.lvCancel();
                    } else if (controller.isWorkFromHome == true) {
                      controller.wfhCancel();
                    }
                  } else if (status == AppString.comments) {
                    Get.back();
                    if (controller.isMyLeave == true) {
                      controller.addComments();
                    } else if (controller.isRequest == true) {
                      controller.addComments();
                    } else if (controller.isWorkFromHome == true) {
                      controller.addComments();
                    } else if (controller.isWFHRequest == true) {
                      controller.addComments();
                    }
                  }
                }
              },
            );
          },
        ),
      ),
    ];
  }
}
