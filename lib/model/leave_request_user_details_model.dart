class LeaveRequestUserDetailsModel {
  Data? data;
  String? message;

  LeaveRequestUserDetailsModel({this.data, this.message});

  LeaveRequestUserDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  RequestFrom? requestFrom;
  RequestedBy? requestedBy;
  List<RequestTo>? requestTo;
  String? type;
  String? halfDayStatus;
  String? startDate;
  String? endDate;
  double? addOnLeaveCount;
  String? returnDate;
  String? duration;
  String? reason;
  bool? isadhocLeave;
  String? adhocStatus;
  bool? availableOnPhone;
  bool? availableOnCity;
  String? emergencyContact;
  String? status;
  List<Comments>? comments;
  List<ApprovedBy>? approvedBy;
  List<RejectedBy>? rejectedBy;
  double? totalLossOfPay;
  double? pendingLossOfPay;
  bool? isActive;
  bool? isAddOnLeave;
  String? addOnLeaveTypeStatus;
  String? createdAt;
  List<LeaveAllocationData>? leaveAllocationData;
  String? modifiedAt;
  String? deletedAt;

  Data(
      {this.id,
        this.requestFrom,
        this.requestedBy,
        this.requestTo,
        this.type,
        this.halfDayStatus,
        this.startDate,
        this.endDate,
        this.addOnLeaveCount,
        this.returnDate,
        this.duration,
        this.reason,
        this.isadhocLeave,
        this.adhocStatus,
        this.availableOnPhone,
        this.availableOnCity,
        this.emergencyContact,
        this.status,
        this.comments,
        this.approvedBy,
        this.rejectedBy,
        this.totalLossOfPay,
        this.pendingLossOfPay,
        this.isActive,
        this.isAddOnLeave,
        this.addOnLeaveTypeStatus,
        this.createdAt,
        this.leaveAllocationData,
        this.modifiedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestFrom = json['request_from'] != null
        ? RequestFrom.fromJson(json['request_from'])
        : null;
    requestedBy = json['requested_by'] != null
        ? RequestedBy.fromJson(json['requested_by'])
        : null;
    if (json['request_to'] != null) {
      requestTo = <RequestTo>[];
      json['request_to'].forEach((v) {
        requestTo!.add(RequestTo.fromJson(v));
      });
    }
    type = json['type'];
    halfDayStatus = json['half_day_status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    addOnLeaveCount = json['add_on_leave_count'];
    returnDate = json['return_date'];
    duration = json['duration']?.toString();
    reason = json['reason'];
    isadhocLeave = json['isadhoc_leave'];
    adhocStatus = json['adhoc_status'];
    availableOnPhone = json['available_on_phone'];
    availableOnCity = json['available_on_city'];
    emergencyContact = json['emergency_contact'];
    status = json['status'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    if (json['approved_by'] != null) {
      approvedBy = <ApprovedBy>[];
      json['approved_by'].forEach((v) {
        approvedBy!.add(ApprovedBy.fromJson(v));
      });
    }
    if (json['rejected_by'] != null) {
      rejectedBy = <RejectedBy>[];
      json['rejected_by'].forEach((v) {
        rejectedBy!.add(RejectedBy.fromJson(v));
      });
    }
    totalLossOfPay = json['total_loss_of_pay'];
    pendingLossOfPay = json['pending_loss_of_pay'];
    isActive = json['is_active'];
    isAddOnLeave = json['is_add_on_leave'];
    addOnLeaveTypeStatus = json['add_on_leave_type_status']?.toString();
    createdAt = json['created_at'];
    if (json['leave_allocation_data'] != null) {
      leaveAllocationData = <LeaveAllocationData>[];
      json['leave_allocation_data'].forEach((v) {
        leaveAllocationData!.add(LeaveAllocationData.fromJson(v));
      });
    }
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    if (requestedBy != null) {
      data['requested_by'] = requestedBy!.toJson();
    }
    if (requestTo != null) {
      data['request_to'] = requestTo!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    data['type'] = type;
    data['half_day_status'] = halfDayStatus;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['add_on_leave_count'] = addOnLeaveCount;
    data['return_date'] = returnDate;
    data['duration'] = duration;
    data['reason'] = reason;
    data['isadhoc_leave'] = isadhocLeave;
    data['adhoc_status'] = adhocStatus;
    data['available_on_phone'] = availableOnPhone;
    data['available_on_city'] = availableOnCity;
    data['emergency_contact'] = emergencyContact;
    data['status'] = status;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (approvedBy != null) {
      data['approved_by'] = approvedBy!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    if (rejectedBy != null) {
      data['rejected_by'] = rejectedBy!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    data['total_loss_of_pay'] = totalLossOfPay;
    data['pending_loss_of_pay'] = pendingLossOfPay;
    data['is_active'] = isActive;
    data['is_add_on_leave'] = isAddOnLeave;
    data['add_on_leave_type_status'] = addOnLeaveTypeStatus;
    data['created_at'] = createdAt;
    if (leaveAllocationData != null) {
      data['leave_allocation_data'] =
          leaveAllocationData!.map((v) => v.toJson()).toList();
    }
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class RequestFrom {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? gender;
  UserOfficialDetails? userOfficialDetails;

  RequestFrom(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.userOfficialDetails});

  RequestFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    userOfficialDetails = json['user_official_details'] != null
        ? UserOfficialDetails.fromJson(json['user_official_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image'] = image;
    data['gender'] = gender;
    if (userOfficialDetails != null) {
      data['user_official_details'] = userOfficialDetails!.toJson();
    }
    return data;
  }
}

class UserOfficialDetails {
  String? code;
  String? designation;
  String? team;
  int? experienceYear;
  int? experienceMonth;
  int? totalExperienceYear;
  int? totalExperienceMonth;

  UserOfficialDetails(
      {this.code,
        this.designation,
        this.team,
        this.experienceYear,
        this.experienceMonth,
        this.totalExperienceYear,
        this.totalExperienceMonth});

  UserOfficialDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    designation = json['designation'];
    team = json['team'];
    experienceYear = json['experience_year'];
    experienceMonth = json['experience_month'];
    totalExperienceYear = json['total_experience_year'];
    totalExperienceMonth = json['total_experience_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['designation'] = designation;
    data['team'] = team;
    data['experience_year'] = experienceYear;
    data['experience_month'] = experienceMonth;
    data['total_experience_year'] = totalExperienceYear;
    data['total_experience_month'] = totalExperienceMonth;
    return data;
  }
}

class RequestedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? gender;
  String? roleName;

  RequestedBy(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.roleName});

  RequestedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image'] = image;
    data['gender'] = gender;
    data['role_name'] = roleName;
    return data;
  }
}

class RequestTo {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? gender;
  String? roleName;

  RequestTo(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.roleName});

  RequestTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image'] = image;
    data['gender'] = gender;
    data['role_name'] = roleName;
    return data;
  }
}

class ApprovedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? gender;
  String? roleName;

  ApprovedBy(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.roleName});

  ApprovedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image'] = image;
    data['gender'] = gender;
    data['role_name'] = roleName;
    return data;
  }
}

class RejectedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? gender;
  String? roleName;

  RejectedBy(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.roleName});

  RejectedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image'] = image;
    data['gender'] = gender;
    data['role_name'] = roleName;
    return data;
  }
}

class Comments {
  int? id;
  int? leaveId;
  RequestedBy? requestFrom;
  RequestedBy? reviewBy;
  String? status;
  String? comments;
  bool? isActive;
  int? createdBy;
  String? modifiedAt;
  String? deletedAt;
  String? createdAt;

  Comments(
      {this.id,
        this.leaveId,
        this.requestFrom,
        this.reviewBy,
        this.status,
        this.comments,
        this.isActive,
        this.createdBy,
        this.modifiedAt,
        this.deletedAt,
        this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveId = json['leave_id'];
    requestFrom = json['request_from'] != null
        ? RequestedBy.fromJson(json['request_from'])
        : null;
    reviewBy = json['review_by'] != null
        ? RequestedBy.fromJson(json['review_by'])
        : null;
    status = json['status'];
    comments = json['comments'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_id'] = leaveId;
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    if (reviewBy != null) {
      data['review_by'] = reviewBy!.toJson();
    }
    data['status'] = status;
    data['comments'] = comments;
    data['is_active'] = isActive;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

class LeaveAllocationData {
  int? userId;
  double? allocatedLeave;
  String? usedLeave;
  double? remainingLeave;
  bool? isActive;
  String? remainingCompensationLeaves;
  String? totalCompensationLeaves;
  String? exceedLeave;
  String? lossOfPay;

  LeaveAllocationData(
      {this.userId,
        this.allocatedLeave,
        this.usedLeave,
        this.remainingLeave,
        this.isActive,
        this.remainingCompensationLeaves,
        this.totalCompensationLeaves,
        this.exceedLeave,
        this.lossOfPay});

  LeaveAllocationData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    allocatedLeave = json['allocated_leave'];
    usedLeave = json['used_leave'];
    remainingLeave = json['remaining_leave'];
    isActive = json['is_active'];
    remainingCompensationLeaves = json['remaining_compensation_leaves'];
    totalCompensationLeaves = json['total_compensation_leaves'];
    exceedLeave = json['exceed_leave'];
    lossOfPay = json['loss_of_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['allocated_leave'] = allocatedLeave;
    data['used_leave'] = usedLeave;
    data['remaining_leave'] = remainingLeave;
    data['is_active'] = isActive;
    data['remaining_compensation_leaves'] = remainingCompensationLeaves;
    data['total_compensation_leaves'] = totalCompensationLeaves;
    data['exceed_leave'] = exceedLeave;
    data['loss_of_pay'] = lossOfPay;
    return data;
  }
}
