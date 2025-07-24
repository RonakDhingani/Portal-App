class ProjectTaskDetailsModel {
  List<Results>? results;
  Labels? labels;

  ProjectTaskDetailsModel({this.results, this.labels});

  ProjectTaskDetailsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  bool? isActive;
  String? logDate;
  String? workDescription;
  int? task;
  User? user;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  String? originalLogTime;
  String? logTimeHours;
  String? logTimeMinutes;
  String? logHours;
  String? projectName;

  // Add the `isCopy` field
  bool isCopy;

  Results({
    this.id,
    this.isActive,
    this.logDate,
    this.workDescription,
    this.task,
    this.user,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
    this.originalLogTime,
    this.logTimeHours,
    this.logTimeMinutes,
    this.logHours,
    this.projectName,
    this.isCopy = false, // Initialize `isCopy` as false by default
  });

  Results.fromJson(Map<String, dynamic> json)
      : isCopy = false // Initialize `isCopy` during deserialization
  {
    id = json['id'];
    isActive = json['is_active'];
    logDate = json['log_date'];
    workDescription = json['work_description'];
    task = json['task'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    originalLogTime = json['original_log_time'];
    logTimeHours = json['log_time_hours'];
    logTimeMinutes = json['log_time_minutes'];
    logHours = json['log_hours'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['log_date'] = logDate;
    data['work_description'] = workDescription;
    data['task'] = task;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    data['original_log_time'] = originalLogTime;
    data['log_time_hours'] = logTimeHours;
    data['log_time_minutes'] = logTimeMinutes;
    data['log_hours'] = logHours;
    data['project_name'] = projectName;
    return data;
  }
}


class User {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? gender;

  User(
      {this.id,
        this.username,
        this.firstName,
        this.lastName,
        this.image,
        this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['gender'] = gender;
    return data;
  }
}

class Labels {
  dynamic totalHours;

  Labels({this.totalHours});

  Labels.fromJson(Map<String, dynamic> json) {
    totalHours = json['total_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_hours'] = totalHours;
    return data;
  }
}
