// ignore_for_file: prefer_collection_literals

class UserProfileDetailsModel {
  Data? data;
  String? message;

  UserProfileDetailsModel({this.data, this.message});

  UserProfileDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  int? role;
  String? roleName;
  String? roleColor;
  String? roleVariant;
  String? image;
  String? firstName;
  String? lastName;
  String? gender;
  String? maritalStatus;
  String? aboutMe;
  String? weddingDate;
  String? birthDate;
  String? bloodGroup;
  String? phoneNumber;
  String? emergencyNumber;
  String? personalEmail;
  String? email;
  String? panNumber;
  String? aadharNumber;
  String? aadharName;
  String? aadharImage;
  String? panImage;
  String? employeeType;
  bool? isDeveloper;
  bool? isActive;
  Userdetails? userdetails;
  List<Experiences>? experiences;
  List<Educations>? educations;
  List<Family>? family;
  BankDetails? bankDetails;
  Address? address;
  String? monthlyAverage;
  String? panName;
  List<TeamsTl>? teamsTl;
  Leaves? leaves;
  bool? isAddressSame;

  Data(
      {this.id,
        this.username,
        this.role,
        this.roleName,
        this.roleColor,
        this.roleVariant,
        this.image,
        this.firstName,
        this.lastName,
        this.gender,
        this.maritalStatus,
        this.aboutMe,
        this.weddingDate,
        this.birthDate,
        this.bloodGroup,
        this.phoneNumber,
        this.emergencyNumber,
        this.personalEmail,
        this.email,
        this.panNumber,
        this.aadharNumber,
        this.aadharName,
        this.aadharImage,
        this.panImage,
        this.employeeType,
        this.isDeveloper,
        this.isActive,
        this.userdetails,
        this.experiences,
        this.educations,
        this.family,
        this.bankDetails,
        this.address,
        this.monthlyAverage,
        this.panName,
        this.teamsTl,
        this.leaves,
        this.isAddressSame});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    roleName = json['role_name'];
    roleColor = json['role_color'];
    roleVariant = json['role_variant'];
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    aboutMe = json['about_me'];
    weddingDate = json['wedding_date'];
    birthDate = json['birth_date'];
    bloodGroup = json['blood_group'];
    phoneNumber = json['phone_number'];
    emergencyNumber = json['emergency_number'];
    personalEmail = json['personal_email'];
    email = json['email'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    aadharName = json['aadhar_name'];
    aadharImage = json['aadhar_image'];
    panImage = json['pan_image'];
    employeeType = json['employee_type'];
    isDeveloper = json['is_developer'];
    isActive = json['is_active'];
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
        : null;
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
    if (json['family'] != null) {
      family = <Family>[];
      json['family'].forEach((v) {
        family!.add(Family.fromJson(v));
      });
    }
    bankDetails = json['bank_details'] != null
        ? BankDetails.fromJson(json['bank_details'])
        : null;
    address =
    json['Address'] != null ? Address.fromJson(json['Address']) : null;
    monthlyAverage = json['monthly_average'];
    panName = json['pan_name'];
    if (json['teams_tl'] != null) {
      teamsTl = <TeamsTl>[];
      json['teams_tl'].forEach((v) {
        teamsTl!.add(TeamsTl.fromJson(v));
      });
    }
    leaves =
    json['leaves'] != null ? Leaves.fromJson(json['leaves']) : null;
    isAddressSame = json['is_address_same'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['role'] = role;
    data['role_name'] = roleName;
    data['role_color'] = roleColor;
    data['role_variant'] = roleVariant;
    data['image'] = image;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['marital_status'] = maritalStatus;
    data['about_me'] = aboutMe;
    data['wedding_date'] = weddingDate;
    data['birth_date'] = birthDate;
    data['blood_group'] = bloodGroup;
    data['phone_number'] = phoneNumber;
    data['emergency_number'] = emergencyNumber;
    data['personal_email'] = personalEmail;
    data['email'] = email;
    data['pan_number'] = panNumber;
    data['aadhar_number'] = aadharNumber;
    data['aadhar_name'] = aadharName;
    data['aadhar_image'] = aadharImage;
    data['pan_image'] = panImage;
    data['employee_type'] = employeeType;
    data['is_developer'] = isDeveloper;
    data['is_active'] = isActive;
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
    }
    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    if (educations != null) {
      data['educations'] = educations!.map((v) => v.toJson()).toList();
    }
    if (family != null) {
      data['family'] = family!.map((v) => v.toJson()).toList();
    }
    if (bankDetails != null) {
      data['bank_details'] = bankDetails!.toJson();
    }
    if (address != null) {
      data['Address'] = address!.toJson();
    }
    data['monthly_average'] = monthlyAverage;
    data['pan_name'] = panName;
    if (teamsTl != null) {
      data['teams_tl'] = teamsTl!.map((v) => v.toJson()).toList();
    }
    if (leaves != null) {
      data['leaves'] = leaves!.toJson();
    }
    data['is_address_same'] = isAddressSame;
    return data;
  }
}

class Userdetails {
  int? id;
  int? user;
  String? code;
  String? joiningDate;
  String? confirmationDate;
  String? resignedDate;
  String? probationStartDate;
  String? probationEndDate;
  String? noticePeriodStartDate;
  String? noticePeriodEndDate;
  String? offeredCtc;
  String? currentCtc;
  int? experienceYear;
  int? experienceMonth;
  int? designation;
  DesignationName? designationName;
  int? department;
  DepartmentName? departmentName;
  List<int>? technology;
  List<TechnologyDetails>? technologyDetails;
  String? skype;
  String? gmail;
  String? gitlab;
  String? github;
  String? taskEntryDate;
  bool? isTaskEntryEnable;
  int? team;
  TeamName? teamName;
  int? pod;
  TeamName? podName;
  String? worklogEntryDate;
  bool? isWorklogEntryEnable;
  int? previousExperienceYear;
  int? previousExperienceMonth;
  List<TeamLeads>? teamLeads;
  TeamLeads? podManager;
  Experience? experience;

  Userdetails(
      {this.id,
        this.user,
        this.code,
        this.joiningDate,
        this.confirmationDate,
        this.resignedDate,
        this.probationStartDate,
        this.probationEndDate,
        this.noticePeriodStartDate,
        this.noticePeriodEndDate,
        this.offeredCtc,
        this.currentCtc,
        this.experienceYear,
        this.experienceMonth,
        this.designation,
        this.designationName,
        this.department,
        this.departmentName,
        this.technology,
        this.technologyDetails,
        this.skype,
        this.gmail,
        this.gitlab,
        this.github,
        this.taskEntryDate,
        this.isTaskEntryEnable,
        this.team,
        this.teamName,
        this.pod,
        this.podName,
        this.worklogEntryDate,
        this.isWorklogEntryEnable,
        this.previousExperienceYear,
        this.previousExperienceMonth,
        this.teamLeads,
        this.podManager,
        this.experience});

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    code = json['code'];
    joiningDate = json['joining_date'];
    confirmationDate = json['confirmation_date'];
    resignedDate = json['resigned_date'];
    probationStartDate = json['probation_start_date'];
    probationEndDate = json['probation_end_date'];
    noticePeriodStartDate = json['notice_period_start_date'];
    noticePeriodEndDate = json['notice_period_end_date'];
    offeredCtc = json['offered_ctc'];
    currentCtc = json['current_ctc'];
    experienceYear = json['experience_year'];
    experienceMonth = json['experience_month'];
    designation = json['designation'];
    designationName = json['designation_name'] != null
        ? DesignationName.fromJson(json['designation_name'])
        : null;
    department = json['department'];
    departmentName = json['department_name'] != null
        ? DepartmentName.fromJson(json['department_name'])
        : null;
    technology = json['technology'].cast<int>();
    if (json['technology_details'] != null) {
      technologyDetails = <TechnologyDetails>[];
      json['technology_details'].forEach((v) {
        technologyDetails!.add(TechnologyDetails.fromJson(v));
      });
    }
    skype = json['skype'];
    gmail = json['gmail'];
    gitlab = json['gitlab'];
    github = json['github'];
    taskEntryDate = json['task_entry_date'];
    isTaskEntryEnable = json['is_task_entry_enable'];
    team = json['team'];
    teamName = json['team_name'] != null
        ? TeamName.fromJson(json['team_name'])
        : null;
    pod = json['pod'];
    podName = json['pod_name'] != null
        ? TeamName.fromJson(json['pod_name'])
        : null;
    worklogEntryDate = json['worklog_entry_date'];
    isWorklogEntryEnable = json['is_worklog_entry_enable'];
    previousExperienceYear = json['previous_experience_year'];
    previousExperienceMonth = json['previous_experience_month'];
    if (json['team_leads'] != null) {
      teamLeads = <TeamLeads>[];
      json['team_leads'].forEach((v) {
        teamLeads!.add(TeamLeads.fromJson(v));
      });
    }
    podManager = json['pod_manager'] != null
        ? TeamLeads.fromJson(json['pod_manager'])
        : null;
    experience = json['experience'] != null
        ? Experience.fromJson(json['experience'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['code'] = code;
    data['joining_date'] = joiningDate;
    data['confirmation_date'] = confirmationDate;
    data['resigned_date'] = resignedDate;
    data['probation_start_date'] = probationStartDate;
    data['probation_end_date'] = probationEndDate;
    data['notice_period_start_date'] = noticePeriodStartDate;
    data['notice_period_end_date'] = noticePeriodEndDate;
    data['offered_ctc'] = offeredCtc;
    data['current_ctc'] = currentCtc;
    data['experience_year'] = experienceYear;
    data['experience_month'] = experienceMonth;
    data['designation'] = designation;
    if (designationName != null) {
      data['designation_name'] = designationName!.toJson();
    }
    data['department'] = department;
    if (departmentName != null) {
      data['department_name'] = departmentName!.toJson();
    }
    data['technology'] = technology;
    if (technologyDetails != null) {
      data['technology_details'] =
          technologyDetails!.map((v) => v.toJson()).toList();
    }
    data['skype'] = skype;
    data['gmail'] = gmail;
    data['gitlab'] = gitlab;
    data['github'] = github;
    data['task_entry_date'] = taskEntryDate;
    data['is_task_entry_enable'] = isTaskEntryEnable;
    data['team'] = team;
    if (teamName != null) {
      data['team_name'] = teamName!.toJson();
    }
    data['pod'] = pod;
    if (podName != null) {
      data['pod_name'] = podName!.toJson();
    }
    data['worklog_entry_date'] = worklogEntryDate;
    data['is_worklog_entry_enable'] = isWorklogEntryEnable;
    data['previous_experience_year'] = previousExperienceYear;
    data['previous_experience_month'] = previousExperienceMonth;
    if (teamLeads != null) {
      data['team_leads'] = teamLeads!.map((v) => v.toJson()).toList();
    }
    if (podManager != null) {
      data['pod_manager'] = podManager!.toJson();
    }
    if (experience != null) {
      data['experience'] = experience!.toJson();
    }
    return data;
  }
}

class DesignationName {
  int? id;
  String? name;
  String? code;
  String? color;
  String? variant;

  DesignationName({this.id, this.name, this.code, this.color, this.variant});

  DesignationName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    color = json['color'];
    variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['color'] = color;
    data['variant'] = variant;
    return data;
  }
}

class DepartmentName {
  int? id;
  String? name;
  String? color;
  String? variant;

  DepartmentName({this.id, this.name, this.color, this.variant});

  DepartmentName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['variant'] = variant;
    return data;
  }
}

class TechnologyDetails {
  int? id;
  String? name;
  String? description;

  TechnologyDetails({this.id, this.name, this.description});

  TechnologyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class TeamName {
  int? id;
  String? name;

  TeamName({this.id, this.name});

  TeamName.fromJson(Map<String, dynamic> json) {
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

class TeamLeads {
  int? id;
  String? firstName;
  String? lastName;
  String? userImage;

  TeamLeads({this.id, this.firstName, this.lastName, this.userImage});

  TeamLeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_image'] = userImage;
    return data;
  }
}

class TeamsTl {
  int? id;
  String? name;

  TeamsTl({this.id, this.name});

  TeamsTl.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Experience {
  Current? current;
  Current? previous;
  Current? total;

  Experience({this.current, this.previous, this.total});

  Experience.fromJson(Map<String, dynamic> json) {
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
    previous = json['previous'] != null
        ? Current.fromJson(json['previous'])
        : null;
    total = json['total'] != null ? Current.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (previous != null) {
      data['previous'] = previous!.toJson();
    }
    if (total != null) {
      data['total'] = total!.toJson();
    }
    return data;
  }
}

class Current {
  int? month;
  int? year;

  Current({this.month, this.year});

  Current.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}

class Experiences {
  int? id;
  int? user;
  String? company;
  String? joinedDate;
  String? releasedDate;
  String? designation;

  Experiences(
      {this.id,
        this.user,
        this.company,
        this.joinedDate,
        this.releasedDate,
        this.designation});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    company = json['company'];
    joinedDate = json['joined_date'];
    releasedDate = json['released_date'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['company'] = company;
    data['joined_date'] = joinedDate;
    data['released_date'] = releasedDate;
    data['designation'] = designation;
    return data;
  }
}

class Educations {
  int? id;
  int? user;
  String? qualification;
  String? universityBoard;
  String? grade;
  int? passingYear;

  Educations(
      {this.id,
        this.user,
        this.qualification,
        this.universityBoard,
        this.grade,
        this.passingYear});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    qualification = json['qualification'];
    universityBoard = json['university_board'];
    grade = json['grade'];
    passingYear = json['passing_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['qualification'] = qualification;
    data['university_board'] = universityBoard;
    data['grade'] = grade;
    data['passing_year'] = passingYear;
    return data;
  }
}

class Family {
  int? id;
  int? user;
  String? name;
  String? relation;
  String? occupation;
  String? contactNumber;

  Family(
      {this.id,
        this.user,
        this.name,
        this.relation,
        this.occupation,
        this.contactNumber});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    name = json['name'];
    relation = json['relation'];
    occupation = json['occupation'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['name'] = name;
    data['relation'] = relation;
    data['occupation'] = occupation;
    data['contact_number'] = contactNumber;
    return data;
  }
}

class BankDetails {
  int? id;
  int? user;
  String? name;
  String? accountNumber;
  String? ifscCode;

  BankDetails(
      {this.id, this.user, this.name, this.accountNumber, this.ifscCode});

  BankDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    name = json['name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['name'] = name;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    return data;
  }
}

class Address {
  CurrentAddress? current;
  CurrentAddress? permanent;

  Address({this.current, this.permanent});

  Address.fromJson(Map<String, dynamic> json) {
    current =
    json['current'] != null ? CurrentAddress.fromJson(json['current']) : null;
    permanent = json['permanent'] != null
        ? CurrentAddress.fromJson(json['permanent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (permanent != null) {
      data['permanent'] = permanent!.toJson();
    }
    return data;
  }
}

class CurrentAddress {
  int? id;
  String? address;
  String? city;
  int? state;
  int? country;
  int? zipcode;
  bool? isPermanent;
  bool? isSame;

  CurrentAddress(
      {this.id,
        this.address,
        this.city,
        this.state,
        this.country,
        this.zipcode,
        this.isPermanent,
        this.isSame});

  CurrentAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    isPermanent = json['is_permanent'];
    isSame = json['is_same'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipcode'] = zipcode;
    data['is_permanent'] = isPermanent;
    data['is_same'] = isSame;
    return data;
  }
}

class Leaves {
  int? userId;
  double? allocatedLeave;
  String? usedLeave;
  double? remainingLeave;
  bool? isActive;
  String? remainingCompensationLeaves;
  String? totalCompensationLeaves;
  String? exceedLeave;
  String? lossOfPay;

  Leaves(
      {this.userId,
        this.allocatedLeave,
        this.usedLeave,
        this.remainingLeave,
        this.isActive,
        this.remainingCompensationLeaves,
        this.totalCompensationLeaves,
        this.exceedLeave,
        this.lossOfPay});

  Leaves.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    allocatedLeave = json['allocated_leave'];
    usedLeave = json['used_leave'];
    remainingLeave = json['remaining_leave'];
    isActive = json['is_active'];
    remainingCompensationLeaves = json['remaining_compensation_leaves'];
    totalCompensationLeaves = json['total_compensation_leaves'];
    exceedLeave = json['exceed_leave'];
    lossOfPay = json['loss_of_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['allocated_leave'] = allocatedLeave;
    data['used_leave'] = usedLeave;
    data['remaining_leave'] = remainingLeave;
    data['is_active'] = isActive;
    data['remaining_compensation_leaves'] = remainingCompensationLeaves;
    data['total_compensation_leaves'] = totalCompensationLeaves;
    data['exceed_leave'] = exceedLeave;
    data['loss_of_pay'] = lossOfPay;
    return data;
  }
}
