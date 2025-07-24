// ignore_for_file: prefer_collection_literals

class DateDurationModel {
  Data? data;

  DateDurationModel({this.data});

  DateDurationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? startDate;
  String? endDate;
  String? type;
  String? halfDayStatus;
  String? returnDate;
  dynamic duration;

  Data(
      {this.startDate,
        this.endDate,
        this.type,
        this.halfDayStatus,
        this.returnDate,
        this.duration});

  Data.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    type = json['type'];
    halfDayStatus = json['half_day_status'];
    returnDate = json['return_date'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['type'] = type;
    data['half_day_status'] = halfDayStatus;
    data['return_date'] = returnDate;
    data['duration'] = duration;
    return data;
  }
}
