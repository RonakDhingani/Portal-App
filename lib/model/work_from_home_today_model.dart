class WorkFromHomeTodayModel {
  List<Result>? result;
  Labels? labels;

  WorkFromHomeTodayModel({this.result, this.labels});

  WorkFromHomeTodayModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    labels =
    json['labels'] != null ? Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      data['labels'] = labels!.toJson();
    }
    return data;
  }
}

class Result {
  RequestFrom? requestFrom;
  String? startDate;
  String? endDate;
  String? duration;
  String? halfDayStatus;
  String? type;

  Result(
      {this.requestFrom,
        this.startDate,
        this.endDate,
        this.duration,
        this.halfDayStatus,
        this.type});

  Result.fromJson(Map<String, dynamic> json) {
    requestFrom = json['request_from'] != null
        ? RequestFrom.fromJson(json['request_from'])
        : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    duration = json['duration'];
    halfDayStatus = json['half_day_status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (requestFrom != null) {
      data['request_from'] = requestFrom!.toJson();
    }
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['duration'] = duration;
    data['half_day_status'] = halfDayStatus;
    data['type'] = type;
    return data;
  }
}

class RequestFrom {
  num? id;
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
  num? experienceYear;
  num? experienceMonth;
  num? totalExperienceYear;
  num? totalExperienceMonth;

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

class Labels {
  num? fullDayCount;
  num? total;
  num? halfDayCount;
  num? fullDayWfhCount;
  num? totalEmployee;

  Labels(
      {this.fullDayCount,
        this.total,
        this.halfDayCount,
        this.fullDayWfhCount,
        this.totalEmployee});

  Labels.fromJson(Map<String, dynamic> json) {
    fullDayCount = json['full_day_count'];
    total = json['total'];
    halfDayCount = json['half_day_count'];
    fullDayWfhCount = json['full_day_wfh_count'];
    totalEmployee = json['total_employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_day_count'] = fullDayCount;
    data['total'] = total;
    data['half_day_count'] = halfDayCount;
    data['full_day_wfh_count'] = fullDayWfhCount;
    data['total_employee'] = totalEmployee;
    return data;
  }
}
