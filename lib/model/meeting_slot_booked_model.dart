class MeetingSlotBookedModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  MeetingSlotBookedModel({this.count, this.next, this.previous, this.results});

  MeetingSlotBookedModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  List<Employees>? employees;
  List<Employees>? nonEmployees;
  String? eventChoice;
  String? game;
  String? startTime;
  String? endTime;
  String? duration;
  String? description;
  String? date;
  List<Pods>? pods;
  List<Teams>? teams;
  bool? allEmployee;
  Employees? createdBy;
  bool? isActive;
  int? meetingArea;
  String? createdAt;
  String? meetingAreaName;
  bool? isDisable;

  Results(
      {this.id,
        this.employees,
        this.nonEmployees,
        this.eventChoice,
        this.game,
        this.startTime,
        this.endTime,
        this.duration,
        this.description,
        this.date,
        this.pods,
        this.teams,
        this.allEmployee,
        this.createdBy,
        this.isActive,
        this.meetingArea,
        this.createdAt,
        this.meetingAreaName,
        this.isDisable});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(new Employees.fromJson(v));
      });
    }
    if (json['non_employees'] != null) {
      nonEmployees = <Employees>[];
      json['non_employees'].forEach((v) {
        nonEmployees!.add(new Employees.fromJson(v));
      });
    }
    eventChoice = json['event_choice'];
    game = json['game'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    description = json['description'];
    date = json['date'];
    if (json['pods'] != null) {
      pods = <Pods>[];
      json['pods'].forEach((v) {
        pods!.add(new Pods.fromJson(v));
      });
    }
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
    allEmployee = json['all_employee'];
    createdBy = json['created_by'] != null
        ? new Employees.fromJson(json['created_by'])
        : null;
    isActive = json['is_active'];
    meetingArea = json['meeting_area'];
    createdAt = json['created_at'];
    meetingAreaName = json['meeting_area_name'];
    isDisable = json['is_disable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    if (nonEmployees != null) {
      data['non_employees'] =
          nonEmployees!.map((v) => v.toJson()).toList();
    }
    data['event_choice'] = eventChoice;
    data['game'] = game;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['description'] = description;
    data['date'] = date;
    if (pods != null) {
      data['pods'] = pods!.map((v) => v.toJson()).toList();
    }
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['all_employee'] = allEmployee;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['is_active'] = isActive;
    data['meeting_area'] = meetingArea;
    data['created_at'] = createdAt;
    data['meeting_area_name'] = meetingAreaName;
    data['is_disable'] = isDisable;
    return data;
  }
}

class Employees {
  int? id;
  String? firstName;
  String? lastName;
  String? userImage;
  String? gender;

  Employees(
      {this.id, this.firstName, this.lastName, this.userImage, this.gender});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userImage = json['user_image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_image'] = userImage;
    data['gender'] = gender;
    return data;
  }
}

class Pods {
  int? id;
  String? name;

  Pods({this.id, this.name});

  Pods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Teams {
  int? id;
  String? name;

  Teams({this.id, this.name});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
