// ignore_for_file: prefer_collection_literals

class CreateLeaveModel {
  Data? data;
  String? message;

  CreateLeaveModel({this.data, this.message});

  CreateLeaveModel.fromJson(Map<String, dynamic> json) {
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
  int? requestedBy;
  int? requestFrom;
  List<int>? requestTo;
  String? type;
  String? halfDayStatus;
  String? startDate;
  String? endDate;
  String? returnDate;
  String? duration;
  String? reason;
  bool? isadhocLeave;
  String? adhocStatus;
  bool? availableOnPhone;
  bool? availableOnCity;
  String? emergencyContact;
  String? status;
  bool? isActive;
  String? createdAt;

  Data(
      {this.requestedBy,
      this.requestFrom,
      this.requestTo,
      this.type,
      this.halfDayStatus,
      this.startDate,
      this.endDate,
      this.returnDate,
      this.duration,
      this.reason,
      this.isadhocLeave,
      this.adhocStatus,
      this.availableOnPhone,
      this.availableOnCity,
      this.emergencyContact,
      this.status,
      this.isActive,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    requestedBy = json['requested_by'];
    requestFrom = json['request_from'];
    requestTo = json['request_to'].cast<int>();
    type = json['type'];
    halfDayStatus = json['half_day_status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    returnDate = json['return_date'];
    duration = json['duration'];
    reason = json['reason'];
    isadhocLeave = json['isadhoc_leave'];
    adhocStatus = json['adhoc_status'];
    availableOnPhone = json['available_on_phone'];
    availableOnCity = json['available_on_city'];
    emergencyContact = json['emergency_contact'];
    status = json['status'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['requested_by'] = requestedBy;
    data['request_from'] = requestFrom;
    data['request_to'] = requestTo;
    data['type'] = type;
    data['half_day_status'] = halfDayStatus;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['return_date'] = returnDate;
    data['duration'] = duration;
    data['reason'] = reason;
    data['isadhoc_leave'] = isadhocLeave;
    data['adhoc_status'] = adhocStatus;
    data['available_on_phone'] = availableOnPhone;
    data['available_on_city'] = availableOnCity;
    data['emergency_contact'] = emergencyContact;
    data['status'] = status;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}
