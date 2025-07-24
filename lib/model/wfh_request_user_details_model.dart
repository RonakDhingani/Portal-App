// ignore_for_file: prefer_collection_literals

import 'package:inexture/model/leave_request_user_details_model.dart';

class WFHRequestUserDetailsModel {
  Data? data;
  String? message;

  WFHRequestUserDetailsModel({this.data, this.message});

  WFHRequestUserDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  List<RequestTo>? requestTo;
  String? type;
  String? halfDayStatus;
  String? startDate;
  String? endDate;
  String? returnDate;
  String? duration;
  String? reason;
  bool? isadhocWfh;
  String? adhocStatus;
  String? status;
  bool? isActive;
  List<ApprovedBy>? approvedBy;
  List<RejectedBy>? rejectedBy;
  List<Comments>? comments;
  String? createdAt;
  RequestedBy? requestedBy;
  Labels? labels;

  Data(
      {this.id,
        this.requestFrom,
        this.requestTo,
        this.type,
        this.halfDayStatus,
        this.startDate,
        this.endDate,
        this.returnDate,
        this.duration,
        this.reason,
        this.isadhocWfh,
        this.adhocStatus,
        this.status,
        this.isActive,
        this.approvedBy,
        this.rejectedBy,
        this.comments,
        this.createdAt,
        this.requestedBy,
        this.labels});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestFrom = json['request_from'] != null
        ? RequestFrom.fromJson(json['request_from'])
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
    returnDate = json['return_date'];
    duration = json['duration'];
    reason = json['reason'];
    isadhocWfh = json['isadhoc_wfh'];
    adhocStatus = json['adhoc_status'];
    status = json['status'];
    isActive = json['is_active'];
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
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    requestedBy = json['requested_by'] != null
        ? RequestedBy.fromJson(json['requested_by'])
        : null;
    labels =
    json['labels'] != null ? Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    if (requestTo != null) {
      data['request_to'] = requestTo!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['half_day_status'] = halfDayStatus;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['return_date'] = returnDate;
    data['duration'] = duration;
    data['reason'] = reason;
    data['isadhoc_wfh'] = isadhocWfh;
    data['adhoc_status'] = adhocStatus;
    data['status'] = status;
    data['is_active'] = isActive;
    if (approvedBy != null) {
      data['approved_by'] = approvedBy!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    if (rejectedBy != null) {
      data['rejected_by'] = rejectedBy!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    if (requestedBy != null) {
      data['requested_by'] = requestedBy!.toJson();
    }
    if (labels != null) {
      data['labels'] = labels!.toJson();
    }
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  int? workFromHome;
  RequestTo? requestFrom;
  RequestTo? reviewBy;
  String? status;
  String? comments;
  bool? isActive;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;

  Comments(
      {this.id,
        this.workFromHome,
        this.requestFrom,
        this.reviewBy,
        this.status,
        this.comments,
        this.isActive,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workFromHome = json['work_from_home'];
    requestFrom = json['request_from'] != null
        ? RequestTo.fromJson(json['request_from'])
        : null;
    reviewBy = json['review_by'] != null
        ? RequestTo.fromJson(json['review_by'])
        : null;
    status = json['status'];
    comments = json['comments'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['work_from_home'] = workFromHome;
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    if (reviewBy != null) {
      data['review_by'] = reviewBy!.toJson();
    }
    data['status'] = status;
    data['comments'] = comments;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Labels {
  int? pending;
  int? rejected;
  int? approved;
  int? cancelled;
  int? totalData;

  Labels(
      {this.pending,
        this.rejected,
        this.approved,
        this.cancelled,
        this.totalData});

  Labels.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    rejected = json['rejected'];
    approved = json['approved'];
    cancelled = json['cancelled'];
    totalData = json['total_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pending'] = pending;
    data['rejected'] = rejected;
    data['approved'] = approved;
    data['cancelled'] = cancelled;
    data['total_data'] = totalData;
    return data;
  }
}
