class UserInformationModel {
  BasicDetails? basicDetails;
  Project? project;
  String? team;
  Pod? pod;
  List<Leader>? leader;
  ResourceStatus? resourceStatus;
  String? gender;

  UserInformationModel(
      {this.basicDetails,
        this.project,
        this.team,
        this.pod,
        this.leader,
        this.resourceStatus,
        this.gender});

  UserInformationModel.fromJson(Map<String, dynamic> json) {
    basicDetails = json['basic_details'] != null
        ? BasicDetails.fromJson(json['basic_details'])
        : null;
    project =
    json['project'] != null ? Project.fromJson(json['project']) : null;
    team = json['team'];
    pod = json['pod'] != null ? Pod.fromJson(json['pod']) : null;
    if (json['leader'] != null) {
      leader = <Leader>[];
      json['leader'].forEach((v) {
        leader!.add(Leader.fromJson(v));
      });
    }
    resourceStatus = json['resource_status'] != null
        ? ResourceStatus.fromJson(json['resource_status'])
        : null;
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (basicDetails != null) {
      data['basic_details'] = basicDetails!.toJson();
    }
    if (project != null) {
      data['project'] = project!.toJson();
    }
    data['team'] = team;
    if (pod != null) {
      data['pod'] = pod!.toJson();
    }
    if (leader != null) {
      data['leader'] = leader!.map((v) => v.toJson()).toList();
    }
    if (resourceStatus != null) {
      data['resource_status'] = resourceStatus!.toJson();
    }
    data['gender'] = gender;
    return data;
  }
}

class BasicDetails {
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  String? phoneNumber;
  DesignationOuter? designationOuter;
  Experience? experience;
  List<String>? technology;
  ContactUrl? contactUrl;

  BasicDetails(
      {this.firstName,
        this.lastName,
        this.image,
        this.email,
        this.phoneNumber,
        this.designationOuter,
        this.experience,
        this.technology,
        this.contactUrl});

  BasicDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    designationOuter = json['designation'] != null
        ? DesignationOuter.fromJson(json['designation'])
        : null;
    experience = json['experience'] != null
        ? Experience.fromJson(json['experience'])
        : null;
    technology = json['technology']?.cast<String>();
    contactUrl = json['contact_url'] != null
        ? ContactUrl.fromJson(json['contact_url'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    if (designationOuter != null) {
      data['designation'] = designationOuter!.toJson();
    }
    if (experience != null) {
      data['experience'] = experience!.toJson();
    }
    data['technology'] = technology;
    if (contactUrl != null) {
      data['contact_url'] = contactUrl!.toJson();
    }
    return data;
  }
}

class DesignationOuter {
  String? designation;
  String? variant;
  String? color;

  DesignationOuter({this.designation, this.variant, this.color});

  DesignationOuter.fromJson(Map<String, dynamic> json) {
    designation = json['designation'];
    variant = json['variant'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['designation'] = designation;
    data['variant'] = variant;
    data['color'] = color;
    return data;
  }
}

class Experience {
  int? year;
  int? month;

  Experience({this.year, this.month});

  Experience.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}

class ContactUrl {
  String? skype;
  String? gmail;
  String? github;
  String? gitlab;

  ContactUrl({this.skype, this.gmail, this.github, this.gitlab});

  ContactUrl.fromJson(Map<String, dynamic> json) {
    skype = json['skype'];
    gmail = json['gmail'];
    github = json['github'];
    gitlab = json['gitlab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skype'] = skype;
    data['gmail'] = gmail;
    data['github'] = github;
    data['gitlab'] = gitlab;
    return data;
  }
}

class Project {
  List<Data>? data;
  int? count;

  Project({this.data, this.count});

  Project.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  int? id;
  String? projectName;
  String? projectCode;
  Status? status;
  Designation? designation;
  String? sodStatus;

  Data(
      {this.id,
        this.projectName,
        this.projectCode,
        this.status,
        this.designation,
        this.sodStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    projectCode = json['project_code'];
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
    sodStatus = json['sod_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['project_code'] = projectCode;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    data['sod_status'] = sodStatus;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    data['variant'] = variant;
    return data;
  }
}

class Designation {
  String? resourceDesignationName;
  String? resourceDesignationColor;
  String? resourceDesignationVariant;

  Designation(
      {this.resourceDesignationName,
        this.resourceDesignationColor,
        this.resourceDesignationVariant});

  Designation.fromJson(Map<String, dynamic> json) {
    resourceDesignationName = json['resource_designation__name'];
    resourceDesignationColor = json['resource_designation__color'];
    resourceDesignationVariant = json['resource_designation__variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resource_designation__name'] = this.resourceDesignationName;
    data['resource_designation__color'] = this.resourceDesignationColor;
    data['resource_designation__variant'] = this.resourceDesignationVariant;
    return data;
  }
}


class Pod {
  String? name;
  Manager? manager;

  Pod({this.name, this.manager});

  Pod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    manager =
    json['manager'] != null ? Manager.fromJson(json['manager']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    return data;
  }
}

class Manager {
  int? id;
  String? firstName;
  String? lastName;
  String? userImage;
  String? gender;

  Manager(
      {this.id, this.firstName, this.lastName, this.userImage, this.gender});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userImage = json['user_image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_image'] = userImage;
    data['gender'] = gender;
    return data;
  }
}

class ResourceStatus {
  bool? workFromHome;
  bool? leave;

  ResourceStatus({this.workFromHome, this.leave});

  ResourceStatus.fromJson(Map<String, dynamic> json) {
    workFromHome = json['work_from_home'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_from_home'] = workFromHome;
    data['leave'] = leave;
    return data;
  }
}

class Leader {
  int? id;
  String? firstName;
  String? lastName;
  String? userImage;
  String? gender;

  Leader(
      {this.id, this.firstName, this.lastName, this.userImage, this.gender});

  Leader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userImage = json['user_image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_image'] = userImage;
    data['gender'] = gender;
    return data;
  }
}
