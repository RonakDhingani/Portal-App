import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/leave_request_user_details_model.dart';
import '../model/user_information_model.dart';
import '../model/wfh_request_user_details_model.dart';
import 'package:inexture/model/leave_request_model.dart' as leaveRequest;
import 'package:inexture/model/wfh_request_model.dart' as wfhRequest;
import '../services/api_function.dart';
import '../utils/utility.dart';
import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';

class RequestDetailsController extends GetxController {
  bool isExpLeave = false;
  bool isLoadUserInfo = false;
  bool isExpComment = false;
  bool isGettingDetails = false;
  bool isUpdated = false;
  bool isApproved = false;

  bool isExpand = false;
  bool isWorkFromHome = false;
  bool isLeaveWFH = false;
  bool isRequest = false;
  bool isWFHRequest = false;

  bool? userApproveReq;
  bool? userRejectReq;
  bool? isAdhocLeave;
  bool? isAvailableOnPhone;
  bool? isAvailableOnCity;
  bool? isMyLeave;

  String? url;
  String? reason;
  String? status;
  String? returnDate;
  String? requestedDate;
  String? startDate;
  String? endDate;
  String? dayType;
  String? halfDayTime;
  String? requestedLeaves;
  String? phone;

  int? reqUserID;
  int? reqFromID;

  List<dynamic>? comments;
  leaveRequest.RequestFrom? requestUserDetails;
  wfhRequest.RequestFrom? wfhReqUserDetails;

  LeaveRequestUserDetailsModel? lvReqUserDtlMdl;
  WFHRequestUserDetailsModel? wfhReqUserDtlMdl;
  UserInformationModel? userInformationModel;

  TextEditingController commentsController = TextEditingController();

  final cmtFormKey = GlobalKey<FormState>();
  final ValueNotifier<bool> submitButtonEnabledNotifier = ValueNotifier(false);
  final ValueNotifier<String> commentTextNotifier = ValueNotifier("");
  var approvedByLength;
  var rejectedByLength;

  String formattedDate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  @override
  void onInit() {
    apiCalling();
    super.onInit();
  }

  RequestDetailsController() {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};

    reason = arguments["reason"] ?? "";
    status = arguments["status"] ?? "";
    returnDate = arguments["returnDate"] ?? "";
    startDate = arguments["startDate"] ?? "";
    endDate = arguments["endDate"] ?? "";
    requestedDate = arguments["requestedDate"] ?? "";
    dayType = arguments["dayType"] ?? "";
    halfDayTime = arguments["halfDayTime"] ?? "";
    requestedLeaves = arguments["requestedLeaves"] ?? "";
    phone = arguments["phone"] ?? "";

    isAdhocLeave = arguments["isAdhocLeave"] ?? false;
    isAvailableOnPhone = arguments["isAvailableOnPhone"] ?? false;
    isAvailableOnCity = arguments["isAvailableOnCity"] ?? false;
    isExpand = arguments["isExpand"] ?? false;
    isWorkFromHome = arguments["isWorkFromHome"] ?? false;
    isLeaveWFH = arguments["isLeaveWFH"] ?? false;
    isRequest = arguments["isRequest"] ?? false;
    isWFHRequest = arguments["isWFHRequest"] ?? false;
    isMyLeave = arguments["isMyLeave"] ?? false;

    reqUserID = arguments["reqUserID"] as int?;
    reqFromID = arguments["reqFromID"] as int?;

    comments = arguments["comments"] ?? [];
    requestUserDetails = arguments["requestUserDetails"];
    wfhReqUserDetails = arguments["wfhReqUserDetails"];
    update();
    log("RequestDetailsController Initialized with:");
    log("reason: $reason");
    log("status: $status");
    log("returnDate: $returnDate");
    log("startDate: $startDate");
    log("endDate: $endDate");
    log("dayType: $dayType");
    log("halfDayTime: $halfDayTime");
    log("requestedLeaves: $requestedLeaves");
    log("phone: $phone");
    log("isAdhocLeave: $isAdhocLeave");
    log("isAvailableOnPhone: $isAvailableOnPhone");
    log("isAvailableOnCity: $isAvailableOnCity");
    log("isExpand: $isExpand");
    log("isWorkFromHome: $isWorkFromHome");
    log("isLeaveWFH: $isLeaveWFH");
    log("isRequest: $isRequest");
    log("isWFHRequest: $isWFHRequest");
    log("isMyLeave: $isMyLeave");
    log("reqUserID: $reqUserID");
    log("reqFromID: $reqFromID");
    log("comments: ${comments.toString()}");
    log("requestUserDetails: ${requestUserDetails.toString()}");
    log("wfhReqUserDetails: ${wfhReqUserDetails.toString()}");
  }


  Future<void> apiCalling() async {
    if (isMyLeave == true) {
      getMyLeaveDetails();
      return;
    } else if (isRequest == true) {
      getRequestUserDetails();
      return;
    } else if (isWorkFromHome == true) {
      getMyWFHDetails();
      return;
    } else if (isWFHRequest == true) {
      getWFHRequestUserDetails();
      return;
    }
  }

  Future<void> getMyLeaveDetails() async {
    isGettingDetails = true;
    ApiFunction.apiRequest(
        url: '${ApiUrl.myLeaves}/$reqUserID',
        method: 'GET',
        onSuccess: (response) {
          log('Get My Leave Details Response : ${response.data.toString()}');
          lvReqUserDtlMdl =
              LeaveRequestUserDetailsModel.fromJson(response.data);
          isGettingDetails = false;
          update();
        },
        onError: (response) {
          isGettingDetails = false;
          update();
          log('Get My Leave Details Response : ${response.data.toString()}');
        });
  }

  Future<void> getRequestUserDetails() async {
    isGettingDetails = true;
    ApiFunction.apiRequest(
        url: '${ApiUrl.leavesLeaveRequest}/$reqUserID',
        method: 'GET',
        onSuccess: (response) {
          log('Get Request User Details Response : ${response.data.toString()}');
          lvReqUserDtlMdl =
              LeaveRequestUserDetailsModel.fromJson(response.data);

          approvedByLength = lvReqUserDtlMdl?.data?.approvedBy?.length;
          rejectedByLength = lvReqUserDtlMdl?.data?.rejectedBy?.length;

          userApproveReq = lvReqUserDtlMdl?.data?.approvedBy
              ?.any((e) => e.firstName == userName);
          userRejectReq = lvReqUserDtlMdl?.data?.rejectedBy
              ?.any((e) => e.firstName == userName);

          isGettingDetails = false;
          update();
        },
        onError: (response) {
          isGettingDetails = false;
          update();
          log('Get Request User Details Response : ${response.data.toString()}');
        });
  }

  Future<void> getMyWFHDetails() async {
    isGettingDetails = true;
    ApiFunction.apiRequest(
        url: '${ApiUrl.myWorkFromHome}$reqUserID',
        method: 'GET',
        onSuccess: (response) {
          log('Get My WFH User Details Response : ${response.data.toString()}');
          wfhReqUserDtlMdl = WFHRequestUserDetailsModel.fromJson(response.data);
          isGettingDetails = false;
          update();
        },
        onError: (response) {
          isGettingDetails = false;
          update();
          log('Get My WFH User Details Response : ${response.data.toString()}');
        });
  }

  Future<void> getWFHRequestUserDetails() async {
    isGettingDetails = true;
    ApiFunction.apiRequest(
        url: '${ApiUrl.workFromHomeRequest}$reqUserID',
        method: 'GET',
        onSuccess: (response) {
          log('Get WFH Request User Details Response : ${response.data.toString()}');
          wfhReqUserDtlMdl = WFHRequestUserDetailsModel.fromJson(response.data);

          approvedByLength = wfhReqUserDtlMdl?.data?.approvedBy?.length;
          rejectedByLength = wfhReqUserDtlMdl?.data?.rejectedBy?.length;

          userApproveReq = wfhReqUserDtlMdl?.data?.approvedBy
              ?.any((e) => e.firstName == userName);
          userRejectReq = wfhReqUserDtlMdl?.data?.rejectedBy
              ?.any((e) => e.firstName == userName);

          isGettingDetails = false;
          update();
        },
        onError: (response) {
          isGettingDetails = false;
          update();
          log('Get WFH Request User Details Response : ${response.data.toString()}');
        });
  }

//  final url = isAdminUser == true ? "${ApiUrl.baseUrl}leaves/all-employee-leave-request-approve-reject" :

  Future<void> lvReqApprove() async {
    isApproved = true;

    ApiFunction.apiRequest(
        url: "${ApiUrl.leavesLeaveRequest}/$reqUserID",
        method: 'PUT',
        data: {
          "comments": commentsController.text,
          "leave_id": lvReqUserDtlMdl?.data?.id,
          "request_from": lvReqUserDtlMdl?.data?.requestFrom?.id,
          "status": "approved",
          "approved_by": [userId]
        },
        onSuccess: (response) {
          log('Request Approve Response : ${response.data.toString()}');

          isApproved = false;
          isUpdated = true;
          commentsController.clear();
          update();
          getRequestUserDetails();
        },
        onError: (response) {
          isApproved = false;
          update();
          log('Request Approve Response : ${response.data.toString()}');
        });
  }

  //   final url = isAdminUser == true ? "${ApiUrl.baseUrl}leaves/all-employee-leave-request-approve-reject" :
  //   if(isAdminUser == true)
  //           "loss_of_pay" : 0,

  Future<void> lvReqReject() async {
    isApproved = true;

    ApiFunction.apiRequest(
        url: "${ApiUrl.leavesLeaveRequest}/$reqUserID",
        method: 'PUT',
        data: {
          "comments": commentsController.text,
          "leave_id": lvReqUserDtlMdl?.data?.id,
          "request_from": lvReqUserDtlMdl?.data?.requestFrom?.id,
          "status": "rejected",
          "rejected_by": [userId]
        },
        onSuccess: (response) {
          log('Request Reject Response : ${response.data.toString()}');

          isApproved = false;
          isUpdated = true;
          commentsController.clear();
          update();
          getRequestUserDetails();
        },
        onError: (response) {
          isApproved = false;
          update();
          log('Request Reject Response : ${response.data.toString()}');
        });
  }

  Future<void> lvCancel() async {
    isApproved = true;

    ApiFunction.apiRequest(
        url: "${ApiUrl.leaveCancel}/$reqUserID",
        method: 'PUT',
        data: {
          "comments": commentsController.text,
          "leave_id": lvReqUserDtlMdl?.data?.id,
          "loss_of_pay": lvReqUserDtlMdl?.data?.totalLossOfPay.toString(),
          "request_from": lvReqUserDtlMdl?.data?.requestFrom?.id,
          "status": "cancelled"
        },
        onSuccess: (response) {
          log('leave cancel Response : ${response.data.toString()}');

          isApproved = false;
          isUpdated = true;
          commentsController.clear();
          update();
          getMyLeaveDetails();
        },
        onError: (response) {
          isApproved = false;
          update();
          log('leave cancel Response : ${response.data.toString()}');
        });
  }

  Future<void> wfhCancel() async {
    isApproved = true;

    ApiFunction.apiRequest(
        url: "${ApiUrl.cancelWorkFromHome}/$reqUserID",
        method: 'PUT',
        data: {
          "comments": commentsController.text,
          "request_from": wfhReqUserDtlMdl?.data?.requestFrom?.id,
          "rejected_by": [userId],
          "status": "cancelled",
          "work_from_home": "$reqUserID"
        },
        onSuccess: (response) {
          log('Work from home cancel Response : ${response.data.toString()}');

          isApproved = false;
          isUpdated = true;
          commentsController.clear();
          update();
          getMyWFHDetails();
        },
        onError: (response) {
          isApproved = false;
          update();
          log('Work from home cancel Response : ${response.data.toString()}');
        });
  }

  Future<void> wfhReqApprove() async {
    isApproved = true;

    ApiFunction.apiRequest(
        url: '${ApiUrl.wFHRequestApprove}/$reqUserID',
        method: 'PUT',
        data: {
          "comments": commentsController.text,
          "work_from_home": wfhReqUserDtlMdl?.data?.id,
          "request_from": wfhReqUserDtlMdl?.data?.requestFrom?.id,
          "review_by": userId,
          "status": "approved",
          "approved_by": [userId]
        },
        onSuccess: (response) {
          log('wfh Request Approve Response Success: ${response.data.toString()}');

          isApproved = false;
          commentsController.clear();
          update();
          getWFHRequestUserDetails();
        },
        onError: (response) {
          isApproved = false;
          commentsController.clear();
          update();
          log('wfh Request Approve Response Error: ${response.data.toString()}');
        });
  }

  Future<void> wfhReqReject() async {
    isApproved = true;

    ApiFunction.apiRequest(
        url: '${ApiUrl.wFHRequestApprove}/$reqUserID',
        method: 'PUT',
        data: {
          "comments": commentsController.text,
          "work_from_home": wfhReqUserDtlMdl?.data?.id,
          "request_from": wfhReqUserDtlMdl?.data?.requestFrom?.id,
          "review_by": userId,
          "status": "rejected",
          "rejected_by": [userId]
        },
        onSuccess: (response) {
          log('wfh Request Rejected Response Success: ${response.data.toString()}');

          isApproved = false;
          commentsController.clear();
          update();
          getWFHRequestUserDetails();
        },
        onError: (response) {
          isApproved = false;
          commentsController.clear();
          update();
          log('wfh Request Rejected Response Error: ${response.data.toString()}');
        });
  }

  Future<void> addComments() async {
    isGettingDetails = true;
    if (isMyLeave == true) {
      url = ApiUrl.myLeaveComment;
    } else if (isRequest == true) {
      url = ApiUrl.leaveRequestComment;
    } else if (isWorkFromHome == true) {
      url = ApiUrl.myWorkFromHomeComment;
    } else if (isWFHRequest == true) {
      url = ApiUrl.wFHRequestComment;
    }
    ApiFunction.apiRequest(
        url: url ?? '',
        data: isLeaveWFH
            ? {
                "comments": commentsController
                    .text /*"${DeltaToHTML.encodeJson(quillController.document.toDelta().toJson())}"*/,
                "work_from_home": reqUserID,
                "request_from": reqFromID,
                "review_by": userId
              }
            : {
                "comments": commentsController
                    .text /*"${DeltaToHTML.encodeJson(quillController.document.toDelta().toJson())}"*/,
                "leave_id": reqUserID,
                "request_from": reqFromID,
                "status": null
              },
        method: 'POST',
        onSuccess: (response) {
          log('Add comments Response : ${response.data.toString()}');
          apiCalling();

          isUpdated = true;
          // quillController.clear();
          commentsController.clear();
          update();
        },
        onError: (response) {
          // quillController.clear();
          commentsController.clear();
          isGettingDetails = false;
          update();
          log('Add comments Response : ${response.data.toString()}');
        });
  }

  Future<void> getUserinfo(String id) async {
    isLoadUserInfo = true;
    update();
    ApiFunction.apiRequest(
        url: '${ApiUrl.userInformation}$id',
        method: 'GET',
        onSuccess: (response) {
          log('User Info API Response : ${response.data.toString()}');
          userInformationModel = UserInformationModel.fromJson(response.data);
          var userDetails = userInformationModel?.basicDetails;

          isLoadUserInfo = false;
          update();
          Utility.userInfoSheet(
            profileImage: userDetails?.image,
            userNames:
                "${userDetails?.firstName?[0].toUpperCase()}${userDetails?.lastName?[0].toUpperCase()}",
            fullName: "${userDetails?.firstName} ${userDetails?.lastName}",
            team: userInformationModel?.team,
            designation: userInformationModel
                ?.basicDetails?.designationOuter?.designation,
            experience:
                "${userDetails?.experience?.year} Years ${userDetails?.experience?.month} Month",
            skype: userDetails?.contactUrl?.skype,
            email: userDetails?.email,
            gmail: userDetails?.contactUrl?.gmail,
            github: userDetails?.contactUrl?.github,
            gitlab: userDetails?.contactUrl?.gitlab,
            technology: userDetails?.technology,
            projects: userInformationModel?.project?.data,
            teamLead: userInformationModel?.leader,
            isBirthDay: false,
          );
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getUserinfo(id),
          );
        },
        onError: (response) {
          isLoadUserInfo = false;
          update();
          log('User Info API Response Error : ${response.data.toString()}');
        });
  }

  String? getStatus() {
    if (isMyLeave == true) {
      return lvReqUserDtlMdl?.data?.status;
    } else if (isRequest == true) {
      return lvReqUserDtlMdl?.data?.status;
    } else if (isWorkFromHome == true) {
      return wfhReqUserDtlMdl?.data?.status;
    } else if (isWFHRequest == true) {
      return wfhReqUserDtlMdl?.data?.status;
    }
    return null;
  }

  List<dynamic>? getComment() {
    if (isMyLeave == true) {
      return lvReqUserDtlMdl?.data?.comments;
    } else if (isRequest == true) {
      return lvReqUserDtlMdl?.data?.comments;
    } else if (isWorkFromHome == true) {
      return wfhReqUserDtlMdl?.data?.comments;
    } else if (isWFHRequest == true) {
      return wfhReqUserDtlMdl?.data?.comments;
    }
    return null;
  }
}
