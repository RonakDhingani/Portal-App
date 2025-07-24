class GamZoneBookedSlotModel {
  int? count;
  Null next;
  Null previous;
  List<Results>? results;

  GamZoneBookedSlotModel({this.count, this.next, this.previous, this.results});

  GamZoneBookedSlotModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<Null>? nonEmployees;
  String? eventChoice;
  Game? game;
  String? startTime;
  String? endTime;
  String? duration;
  String? description;
  String? date;
  List<String>? pods;
  List<String>? teams;
  bool? allEmployee;
  Employees? createdBy;
  bool? isActive;
  String? meetingArea;
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
        employees!.add(Employees.fromJson(v));
      });
    }
    if (json['non_employees'] != null) {
      nonEmployees = <Null>[];
      json['non_employees'].forEach((v) {
        nonEmployees!.add(v);
      });
    }
    eventChoice = json['event_choice'];
    game = json['game'] != null ? Game.fromJson(json['game']) : null;
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    description = json['description'];
    date = json['date'];
    if (json['pods'] != null) {
      pods = <String>[];
      json['pods'].forEach((v) {
        pods!.add(v);
      });
    }
    if (json['teams'] != null) {
      teams = <String>[];
      json['teams'].forEach((v) {
        teams!.add(v);
      });
    }
    allEmployee = json['all_employee'];
    createdBy = json['created_by'] != null
        ? Employees.fromJson(json['created_by'])
        : null;
    isActive = json['is_active'];
    meetingArea = json['meeting_area'];
    createdAt = json['created_at'];
    meetingAreaName = json['meeting_area_name'];
    isDisable = json['is_disable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    if (nonEmployees != null) {
      data['non_employees'] =
          nonEmployees!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    data['event_choice'] = eventChoice;
    if (game != null) {
      data['game'] = game!.toJson();
    }
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['description'] = description;
    data['date'] = date;
    if (pods != null) {
      data['pods'] = pods!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    if (teams != null) {
      data['teams'] = teams!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_image'] = userImage;
    data['gender'] = gender;
    return data;
  }
}

class Game {
  int? id;
  String? name;
  String? image;
  bool? isActive;
  String? createdAt;
  String? modifiedAt;

  Game(
      {this.id,
        this.name,
        this.image,
        this.isActive,
        this.createdAt,
        this.modifiedAt});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    return data;
  }
}