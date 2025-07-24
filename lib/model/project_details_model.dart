// ignore_for_file: prefer_collection_literals

class ProjectDetailsModel {
  int? total;
  int? pageSize;
  int? page;
  List<Results>? results;
  Labels? labels;

  ProjectDetailsModel(
      {this.total, this.pageSize, this.page, this.results, this.labels});

  ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['page_size'];
    page = json['page'];
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['page_size'] = pageSize;
    data['page'] = page;
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
  String? projectCode;
  String? projectName;
  Status? status;
  String? priority;
  String? projectType;
  String? projectDescription;
  double? totalHours;
  String? projectImage;
  String? createdAt;
  String? statusType;
  String? modifiedAt;
  String? deletedAt;
  int? totalLinks;
  int? totalTask;

  Results(
      {this.id,
        this.projectCode,
        this.projectName,
        this.status,
        this.priority,
        this.projectType,
        this.projectDescription,
        this.totalHours,
        this.projectImage,
        this.createdAt,
        this.statusType,
        this.modifiedAt,
        this.deletedAt,
        this.totalLinks,
        this.totalTask});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectCode = json['project_code'];
    projectName = json['project_name'];
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    priority = json['priority'];
    projectType = json['project_type'];
    projectDescription = json['project_description'];
    totalHours = json['total_hours'];
    projectImage = json['project_image'];
    createdAt = json['created_at'];
    statusType = json['status_type'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    totalLinks = json['total_links'];
    totalTask = json['total_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['project_code'] = projectCode;
    data['project_name'] = projectName;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['priority'] = priority;
    data['project_type'] = projectType;
    data['project_description'] = projectDescription;
    data['total_hours'] = totalHours;
    data['project_image'] = projectImage;
    data['created_at'] = createdAt;
    data['status_type'] = statusType;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    data['total_links'] = totalLinks;
    data['total_task'] = totalTask;
    return data;
  }
}

class Status {
  String? name;
  String? color;
  String? variant;

  Status({this.name, this.color, this.variant});

  Status.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['color'] = color;
    data['variant'] = variant;
    return data;
  }
}

class Labels {
  int? all;
  int? external;
  int? internal;

  Labels({this.all, this.external, this.internal});

  Labels.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    external = json['external'];
    internal = json['internal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['all'] = all;
    data['external'] = external;
    data['internal'] = internal;
    return data;
  }
}
