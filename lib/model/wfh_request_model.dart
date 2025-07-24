// ignore_for_file: prefer_collection_literals

class WFHRequestModel {
  int? total;
  int? pageSize;
  int? page;
  List<Results>? results;
  Labels? labels;

  WFHRequestModel(
      {this.total, this.pageSize, this.page, this.results, this.labels});

  WFHRequestModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['page_size'];
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    labels =
    json['labels'] != null ? Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['page_size'] = pageSize;
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      data['labels'] = labels!.toJson();
    }
    return data;
  }
}

class Results {
  int? id;
  RequestFrom? requestFrom;
  int? requestedBy;
  List<int>? requestTo;
  String? type;
  String? halfDayStatus;
  String? startDate;
  String? endDate;
  String? returnDate;
  String? duration;
  String? reason;
  bool? isadhocWfh;
  String? adhocStatus;
  dynamic currentMonthTotalWFH;
  String? status;
  List<int>? approvedBy;
  List<int>? rejectedBy;
  bool? isActive;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  int? commentCount;
  List<Comments>? comments;

  Results(
      {this.id,
        this.requestFrom,
        this.requestedBy,
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
        this.currentMonthTotalWFH,
        this.status,
        this.approvedBy,
        this.rejectedBy,
        this.isActive,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt,
        this.commentCount,
        this.comments});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestFrom = json['request_from'] != null
        ? RequestFrom.fromJson(json['request_from'])
        : null;
    requestedBy = json['requested_by'];
    requestTo = json['request_to'].cast<int>();
    type = json['type'];
    halfDayStatus = json['half_day_status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    returnDate = json['return_date'];
    duration = json['duration'];
    reason = json['reason'];
    isadhocWfh = json['isadhoc_wfh'];
    adhocStatus = json['adhoc_status'];
    currentMonthTotalWFH = json['current_month_total_wfh'];
    status = json['status'];
    approvedBy = json['approved_by'].cast<int>();
    rejectedBy = json['rejected_by'].cast<int>();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    commentCount = json['comment_count'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    data['requested_by'] = requestedBy;
    data['request_to'] = requestTo;
    data['type'] = type;
    data['half_day_status'] = halfDayStatus;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['return_date'] = returnDate;
    data['duration'] = duration;
    data['reason'] = reason;
    data['isadhoc_wfh'] = isadhocWfh;
    data['adhoc_status'] = adhocStatus;
    data['current_month_total_wfh'] = currentMonthTotalWFH;
    data['status'] = status;
    data['approved_by'] = approvedBy;
    data['rejected_by'] = rejectedBy;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    data['comment_count'] = commentCount;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
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
  String? roleName;

  RequestFrom(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.roleName});

  RequestFrom.fromJson(Map<String, dynamic> json) {
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

class Comments {
  int? id;
  int? workFromHome;
  RequestFrom? requestFrom;
  RequestFrom? reviewBy;
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
        ? RequestFrom.fromJson(json['request_from'])
        : null;
    reviewBy = json['review_by'] != null
        ? RequestFrom.fromJson(json['review_by'])
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
