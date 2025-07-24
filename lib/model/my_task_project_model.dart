class MyTasksProjectModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;
  Labels? labels;

  MyTasksProjectModel(
      {this.count, this.next, this.previous, this.results, this.labels});

  MyTasksProjectModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
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
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
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
  String? taskId;
  String? projectName;
  String? projectCode;
  int? project;
  String? taskName;
  bool? isActive;
  String? description;
  String? status;
  String? priority;
  List<AssignTo>? assignTo;
  String? billingType;
  String? estimatedHours;
  String? duration;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;

  Results(
      {this.id,
        this.taskId,
        this.projectName,
        this.projectCode,
        this.project,
        this.taskName,
        this.isActive,
        this.description,
        this.status,
        this.priority,
        this.assignTo,
        this.billingType,
        this.estimatedHours,
        this.duration,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    projectName = json['project_name'];
    projectCode = json['project_code'];
    project = json['project'];
    taskName = json['task_name'];
    isActive = json['is_active'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    if (json['assign_to'] != null) {
      assignTo = <AssignTo>[];
      json['assign_to'].forEach((v) {
        assignTo!.add(AssignTo.fromJson(v));
      });
    }
    billingType = json['billing_type'];
    estimatedHours = json['estimated_hours'];
    duration = json['duration'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_id'] = taskId;
    data['project_name'] = projectName;
    data['project_code'] = projectCode;
    data['project'] = project;
    data['task_name'] = taskName;
    data['is_active'] = isActive;
    data['description'] = description;
    data['status'] = status;
    data['priority'] = priority;
    if (assignTo != null) {
      data['assign_to'] = assignTo!.map((v) => v.toJson()).toList();
    }
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

class AssignTo {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? gender;

  AssignTo(
      {this.id,
        this.username,
        this.firstName,
        this.lastName,
        this.image,
        this.gender});

  AssignTo.fromJson(Map<String, dynamic> json) {
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
  int? todoTasks;
  int? pendingTasks;
  int? completedTasks;
  int? allTasks;

  Labels(
      {this.todoTasks, this.pendingTasks, this.completedTasks, this.allTasks});

  Labels.fromJson(Map<String, dynamic> json) {
    todoTasks = json['todo_tasks'];
    pendingTasks = json['pending_tasks'];
    completedTasks = json['completed_tasks'];
    allTasks = json['all_tasks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['todo_tasks'] = todoTasks;
    data['pending_tasks'] = pendingTasks;
    data['completed_tasks'] = completedTasks;
    data['all_tasks'] = allTasks;
    return data;
  }
}
