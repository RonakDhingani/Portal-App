// ignore_for_file: prefer_collection_literals

class MyDashboardLeaveModel {
  List<Results>? results;
  Labels? labels;

  MyDashboardLeaveModel({this.results, this.labels});

  MyDashboardLeaveModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
      });
    }
    labels =
    json['labels'] != null ?  Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  bool? isadhocLeave;
  String? adhocStatus;
  bool? availableOnPhone;
  bool? availableOnCity;
  String? emergencyContact;
  String? endDate;
  List<int>? approvedBy;
  List<int>? rejectedBy;
  bool? isActive;
  String? returnDate;
  String? duration;
  String? status;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;

  Results(
      {this.id,
        this.requestFrom,
        this.requestedBy,
        this.requestTo,
        this.type,
        this.halfDayStatus,
        this.startDate,
        this.isadhocLeave,
        this.adhocStatus,
        this.availableOnPhone,
        this.availableOnCity,
        this.emergencyContact,
        this.endDate,
        this.approvedBy,
        this.rejectedBy,
        this.isActive,
        this.returnDate,
        this.duration,
        this.status,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestFrom = json['request_from'] != null
        ?  RequestFrom.fromJson(json['request_from'])
        : null;
    requestedBy = json['requested_by'];
    requestTo = json['request_to'].cast<int>();
    type = json['type'];
    halfDayStatus = json['half_day_status'];
    startDate = json['start_date'];
    isadhocLeave = json['isadhoc_leave'];
    adhocStatus = json['adhoc_status'];
    availableOnPhone = json['available_on_phone'];
    availableOnCity = json['available_on_city'];
    emergencyContact = json['emergency_contact'];
    endDate = json['end_date'];
    approvedBy = json['approved_by'].cast<int>();
    if (json['rejected_by'] != null) {
      rejectedBy = <int>[];
      json['rejected_by'].forEach((v) {
        rejectedBy!.add(v);
      });
    }
    isActive = json['is_active'];
    returnDate = json['return_date'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    data['requested_by'] = requestedBy;
    data['request_to'] = requestTo;
    data['type'] = type;
    data['half_day_status'] = halfDayStatus;
    data['start_date'] = startDate;
    data['isadhoc_leave'] = isadhocLeave;
    data['adhoc_status'] = adhocStatus;
    data['available_on_phone'] = availableOnPhone;
    data['available_on_city'] = availableOnCity;
    data['emergency_contact'] = emergencyContact;
    data['end_date'] = endDate;
    data['approved_by'] = approvedBy;
    if (rejectedBy != null) {
      data['rejected_by'] = rejectedBy!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    data['is_active'] = isActive;
    data['return_date'] = returnDate;
    data['duration'] = duration;
    data['status'] = status;
    data['created_at'] = createdAt;
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
        ?  UserOfficialDetails.fromJson(json['user_official_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
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

class Labels {
  int? userId;
  dynamic allocatedLeave;
  String? usedLeave;
  dynamic remainingLeave;
  bool? isActive;
  String? remainingCompensationLeaves;
  String? totalCompensationLeaves;
  String? exceedLeave;
  String? lossOfPay;

  Labels(
      {this.userId,
        this.allocatedLeave,
        this.usedLeave,
        this.remainingLeave,
        this.isActive,
        this.remainingCompensationLeaves,
        this.totalCompensationLeaves,
        this.exceedLeave,
        this.lossOfPay});

  Labels.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
