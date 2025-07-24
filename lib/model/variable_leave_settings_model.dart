class VariableLeaveSettingsModel {
  List<Data>? data;

  VariableLeaveSettingsModel({this.data});

  VariableLeaveSettingsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? leaveType;
  String? effectiveFrom;
  bool? includeHoliday;
  bool? includeWeekday;
  bool? isActive;

  Data(
      {this.id,
        this.leaveType,
        this.effectiveFrom,
        this.includeHoliday,
        this.includeWeekday,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
    effectiveFrom = json['effective_from'];
    includeHoliday = json['include_holiday'];
    includeWeekday = json['include_weekday'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = leaveType;
    data['effective_from'] = effectiveFrom;
    data['include_holiday'] = includeHoliday;
    data['include_weekday'] = includeWeekday;
    data['is_active'] = isActive;
    return data;
  }
}
