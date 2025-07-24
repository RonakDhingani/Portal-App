class MyWorkLogDateWiseModel {
  List<Data>? data;
  Labels? labels;

  MyWorkLogDateWiseModel({this.data, this.labels});

  MyWorkLogDateWiseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    labels = json['labels'] != null ? Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      data['labels'] = labels!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  Task? task;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  bool? isActive;
  String? logDate;
  String? logTime;
  String? workDescription;
  int? createdBy;
  String? modifiedBy;
  String? deletedBy;
  int? user;
  String? logHours;
  int? logTimeHours;
  int? logTimeMinutes;
  int? hourCounter;
  int? minCounter;

  Data({
    this.id,
    this.task,
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
    this.logHours,
    this.logTimeHours,
    this.logTimeMinutes,
    this.hourCounter,
    this.minCounter,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    createdAt = json['created_at']?.toString();
    modifiedAt = json['modified_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
    isActive = json['is_active'];
    logDate = json['log_date']?.toString();
    logTime = json['log_time']?.toString();
    workDescription = json['work_description']?.toString();
    createdBy = json['created_by'];
    modifiedBy = json['modified_by']?.toString();
    deletedBy = json['deleted_by']?.toString();
    user = json['user'];
    logHours = json['log_hours']?.toString();
    logTimeHours = json['log_time_hours'];
    logTimeMinutes = json['log_time_minutes'];
    hourCounter = json['hour_counter'];
    minCounter = json['min_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (task != null) {
      data['task'] = task!.toJson();
    }
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
    data['log_hours'] = logHours;
    data['log_time_hours'] = logTimeHours;
    data['log_time_minutes'] = logTimeMinutes;
    data['hour_counter'] = hourCounter;
    data['min_counter'] = minCounter;
    return data;
  }
}

class Task {
  int? id;
  String? taskId;
  String? projectName;
  int? project;
  String? taskName;
  bool? isActive;
  String? description;
  String? status;
  String? priority;
  String? projectCode;
  List<int>? assignTo;
  String? billingType;
  String? estimatedHours;
  String? duration;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;

  Task({
    this.id,
    this.taskId,
    this.projectName,
    this.project,
    this.taskName,
    this.isActive,
    this.description,
    this.status,
    this.priority,
    this.projectCode,
    this.assignTo,
    this.billingType,
    this.estimatedHours,
    this.duration,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id']?.toString();
    projectName = json['project_name']?.toString();
    project = json['project'];
    taskName = json['task_name']?.toString();
    isActive = json['is_active'];
    description = json['description']?.toString();
    status = json['status']?.toString();
    priority = json['priority']?.toString();
    projectCode = json['project_code']?.toString();
    assignTo = json['assign_to'] != null
        ? List<int>.from(json['assign_to'])
        : <int>[];
    billingType = json['billing_type']?.toString();
    estimatedHours = json['estimated_hours']?.toString();
    duration = json['duration']?.toString();
    startDate = json['start_date']?.toString();
    endDate = json['end_date']?.toString();
    createdAt = json['created_at']?.toString();
    modifiedAt = json['modified_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_id'] = taskId;
    data['project_name'] = projectName;
    data['project'] = project;
    data['task_name'] = taskName;
    data['is_active'] = isActive;
    data['description'] = description;
    data['status'] = status;
    data['priority'] = priority;
    data['project_code'] = projectCode;
    data['assign_to'] = assignTo;
    data['billing_type'] = billingType;
    data['estimated_hours'] = estimatedHours;
    data['duration'] = duration;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Labels {
  String? totalHours;

  Labels({this.totalHours});

  Labels.fromJson(Map<String, dynamic> json) {
    totalHours = json['total_hours']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_hours'] = totalHours;
    return data;
  }
}
