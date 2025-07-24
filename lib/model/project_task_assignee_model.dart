class ProjectTaskAssigneeModel {
  int? id;
  String? taskId;
  int? project;
  String? projectName;
  String? projectCode;
  String? taskName;
  List<AssignTo>? assignTo;

  ProjectTaskAssigneeModel(
      {this.id,
        this.taskId,
        this.project,
        this.projectName,
        this.projectCode,
        this.taskName,
        this.assignTo});

  ProjectTaskAssigneeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    project = json['project'];
    projectName = json['project_name'];
    projectCode = json['project_code'];
    taskName = json['task_name'];
    if (json['assign_to'] != null) {
      assignTo = <AssignTo>[];
      json['assign_to'].forEach((v) {
        assignTo!.add(AssignTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_id'] = taskId;
    data['project'] = project;
    data['project_name'] = projectName;
    data['project_code'] = projectCode;
    data['task_name'] = taskName;
    if (assignTo != null) {
      data['assign_to'] = assignTo!.map((v) => v.toJson()).toList();
    }
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
