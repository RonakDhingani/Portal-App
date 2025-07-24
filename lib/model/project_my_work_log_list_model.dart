class ProjectMyWorkLogListModel {
  Map<String, List<Data>> groupedData;

  ProjectMyWorkLogListModel({required this.groupedData});

  factory ProjectMyWorkLogListModel.fromJson(List<dynamic> jsonList) {
    Map<String, List<Data>> groupedData = {};
    for (var json in jsonList) {
      Data data = Data.fromJson(json);
      String logDate = data.logDate ?? '';
      if (groupedData.containsKey(logDate)) {
        groupedData[logDate]!.add(data);
      } else {
        groupedData[logDate] = [data];
      }
    }
    return ProjectMyWorkLogListModel(groupedData: groupedData);
  }
}


class Data {
  int? id;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  bool? isActive;
  String? logDate;
  String? logTime;
  String? workDescription;
  int? createdBy;
  int? modifiedBy;
  int? deletedBy;
  int? user;
  int? task;
  String? logTimeStr;

  Data(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt,
        this.isActive,
        this.logDate,
        this.logTime,
        this.workDescription,
        this.createdBy,
        this.modifiedBy,
        this.deletedBy,
        this.user,
        this.task,
        this.logTimeStr});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    isActive = json['is_active'];
    logDate = json['log_date'];
    logTime = json['log_time'];
    workDescription = json['work_description'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    deletedBy = json['deleted_by'];
    user = json['user'];
    task = json['task'];
    logTimeStr = json['log_time_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    data['is_active'] = isActive;
    data['log_date'] = logDate;
    data['log_time'] = logTime;
    data['work_description'] = workDescription;
    data['created_by'] = createdBy;
    data['modified_by'] = modifiedBy;
    data['deleted_by'] = deletedBy;
    data['user'] = user;
    data['task'] = task;
    data['log_time_str'] = logTimeStr;
    return data;
  }
}
