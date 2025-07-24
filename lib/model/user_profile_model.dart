// ignore_for_file: prefer_collection_literals

/*class UserProfileModel {
  Data? data;
  String? message;

  UserProfileModel({this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? role;
  String? gender;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? maritalStatus;
  String? weddingDate;
  String? birthDate;
  String? bloodGroup;
  String? phoneNumber;
  String? emergencyNumber;
  String? personalEmail;
  String? panNumber;
  String? aadharNumber;
  String? aadharName;
  String? aboutMe;
  bool? isActive;
  bool? isAdminUser;
  Userdetails? userdetails;
  List<TeamsTl>? teamsTl;
  List<Null>? pods;
  List<String>? permissions;

  Data(
      {this.id,
        this.role,
        this.gender,
        this.email,
        this.username,
        this.firstName,
        this.lastName,
        this.image,
        this.maritalStatus,
        this.weddingDate,
        this.birthDate,
        this.bloodGroup,
        this.phoneNumber,
        this.emergencyNumber,
        this.personalEmail,
        this.panNumber,
        this.aadharNumber,
        this.aadharName,
        this.aboutMe,
        this.isActive,
        this.isAdminUser,
        this.userdetails,
        this.teamsTl,
        this.pods,
        this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    gender = json['gender'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    maritalStatus = json['marital_status'];
    weddingDate = json['wedding_date'];
    birthDate = json['birth_date'];
    bloodGroup = json['blood_group'];
    phoneNumber = json['phone_number'];
    emergencyNumber = json['emergency_number'];
    personalEmail = json['personal_email'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    aadharName = json['aadhar_name'];
    aboutMe = json['about_me'];
    isActive = json['is_active'];
    isAdminUser = json['is_admin_user'];
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
        : null;
    if (json['teams_tl'] != null) {
      teamsTl = <TeamsTl>[];
      json['teams_tl'].forEach((v) {
        teamsTl!.add(TeamsTl.fromJson(v));
      });
    }
    if (json['pods'] != null) {
      pods = <Null>[];
      json['pods'].forEach((v) {
        pods!.add(v);
      });
    }
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['role'] = role;
    data['gender'] = gender;
    data['email'] = email;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['marital_status'] = maritalStatus;
    data['wedding_date'] = weddingDate;
    data['birth_date'] = birthDate;
    data['blood_group'] = bloodGroup;
    data['phone_number'] = phoneNumber;
    data['emergency_number'] = emergencyNumber;
    data['personal_email'] = personalEmail;
    data['pan_number'] = panNumber;
    data['aadhar_number'] = aadharNumber;
    data['aadhar_name'] = aadharName;
    data['about_me'] = aboutMe;
    data['is_active'] = isActive;
    data['is_admin_user'] = isAdminUser;
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
    }
    if (teamsTl != null) {
      data['teams_tl'] = teamsTl!.map((v) => v.toJson()).toList();
    }
    if (pods != null) {
      data['pods'] = pods!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    data['permissions'] = permissions;
    return data;
  }
}

class Userdetails {
  int? id;
  String? taskEntryDate;
  bool? isTaskEntryEnable;
  String? code;
  String? worklogEntryDate;
  bool? isWorklogEntryEnable;
  int? team;

  Userdetails(
      {this.id,
        this.taskEntryDate,
        this.isTaskEntryEnable,
        this.code,
        this.worklogEntryDate,
        this.isWorklogEntryEnable,
        this.team});

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskEntryDate = json['task_entry_date'];
    isTaskEntryEnable = json['is_task_entry_enable'];
    code = json['code'];
    worklogEntryDate = json['worklog_entry_date'];
    isWorklogEntryEnable = json['is_worklog_entry_enable'];
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['task_entry_date'] = taskEntryDate;
    data['is_task_entry_enable'] = isTaskEntryEnable;
    data['code'] = code;
    data['worklog_entry_date'] = worklogEntryDate;
    data['is_worklog_entry_enable'] = isWorklogEntryEnable;
    data['team'] = team;
    return data;
  }
}

class TeamsTl {
  int? id;
  String? name;

  TeamsTl({this.id, this.name});

  TeamsTl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}*/

class UserProfileModel {
  Data? data;
  String? message;

  UserProfileModel({this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? role;
  String? gender;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? maritalStatus;
  String? weddingDate;
  String? birthDate;
  String? bloodGroup;
  String? phoneNumber;
  String? emergencyNumber;
  String? personalEmail;
  String? panNumber;
  String? aadharNumber;
  String? aadharName;
  String? aboutMe;
  bool? isActive;
  bool? isAdminUser;
  Userdetails? userdetails;
  List<TeamsTl>? teamsTl;
  List<Pods>? pods;
  List<String>? permissions;

  Data(
      {this.id,
        this.role,
        this.gender,
        this.email,
        this.username,
        this.firstName,
        this.lastName,
        this.image,
        this.maritalStatus,
        this.weddingDate,
        this.birthDate,
        this.bloodGroup,
        this.phoneNumber,
        this.emergencyNumber,
        this.personalEmail,
        this.panNumber,
        this.aadharNumber,
        this.aadharName,
        this.aboutMe,
        this.isActive,
        this.isAdminUser,
        this.userdetails,
        this.teamsTl,
        this.pods,
        this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    gender = json['gender'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    maritalStatus = json['marital_status'];
    weddingDate = json['wedding_date'];
    birthDate = json['birth_date'];
    bloodGroup = json['blood_group'];
    phoneNumber = json['phone_number'];
    emergencyNumber = json['emergency_number'];
    personalEmail = json['personal_email'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    aadharName = json['aadhar_name'];
    aboutMe = json['about_me'];
    isActive = json['is_active'];
    isAdminUser = json['is_admin_user'];
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
        : null;
    if (json['teams_tl'] != null) {
      teamsTl = <TeamsTl>[];
      json['teams_tl'].forEach((v) {
        teamsTl!.add(TeamsTl.fromJson(v));
      });
    }
    if (json['pods'] != null) {
      pods = <Pods>[];
      json['pods'].forEach((v) {
        pods!.add(Pods.fromJson(v));
      });
    }
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['role'] = role;
    data['gender'] = gender;
    data['email'] = email;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['marital_status'] = maritalStatus;
    data['wedding_date'] = weddingDate;
    data['birth_date'] = birthDate;
    data['blood_group'] = bloodGroup;
    data['phone_number'] = phoneNumber;
    data['emergency_number'] = emergencyNumber;
    data['personal_email'] = personalEmail;
    data['pan_number'] = panNumber;
    data['aadhar_number'] = aadharNumber;
    data['aadhar_name'] = aadharName;
    data['about_me'] = aboutMe;
    data['is_active'] = isActive;
    data['is_admin_user'] = isAdminUser;
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
    }
    if (teamsTl != null) {
      data['teams_tl'] = teamsTl!.map((v) => v.toJson()).toList();
    }
    if (pods != null) {
      data['pods'] = pods!.map((v) => v.toJson()).toList();
    }
    data['permissions'] = permissions;
    return data;
  }
}

class Userdetails {
  int? id;
  String? taskEntryDate;
  bool? isTaskEntryEnable;
  String? code;
  String? worklogEntryDate;
  bool? isWorklogEntryEnable;
  int? team;

  Userdetails(
      {this.id,
        this.taskEntryDate,
        this.isTaskEntryEnable,
        this.code,
        this.worklogEntryDate,
        this.isWorklogEntryEnable,
        this.team});

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskEntryDate = json['task_entry_date'];
    isTaskEntryEnable = json['is_task_entry_enable'];
    code = json['code'];
    worklogEntryDate = json['worklog_entry_date'];
    isWorklogEntryEnable = json['is_worklog_entry_enable'];
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['task_entry_date'] = taskEntryDate;
    data['is_task_entry_enable'] = isTaskEntryEnable;
    data['code'] = code;
    data['worklog_entry_date'] = worklogEntryDate;
    data['is_worklog_entry_enable'] = isWorklogEntryEnable;
    data['team'] = team;
    return data;
  }
}

class TeamsTl {
  int? id;
  String? name;

  TeamsTl({this.id, this.name});

  TeamsTl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}class Pods {
  int? id;
  String? name;

  Pods({this.id, this.name});

  Pods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

