// ignore_for_file: prefer_collection_literals

class SlotBookedModel {
  Data? data;
  String? message;

  SlotBookedModel({this.data, this.message});

  SlotBookedModel.fromJson(Map<String, dynamic> json) {
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
  List<int>? employees;
  int? nonEmployees;
  String? eventChoice;
  String? date;
  int? game;
  String? startTime;
  String? duration;
  String? description;
  List<String>? pods;
  List<String>? teams;
  bool? allEmployee;
  String? meetingArea;

  Data(
      {this.id,
        this.employees,
        this.nonEmployees,
        this.eventChoice,
        this.date,
        this.game,
        this.startTime,
        this.duration,
        this.description,
        this.pods,
        this.teams,
        this.allEmployee,
        this.meetingArea});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employees = json['employees'].cast<int>();
    nonEmployees = json['non_employees'];
    eventChoice = json['event_choice'];
    date = json['date'];
    game = json['game'];
    startTime = json['start_time'];
    duration = json['duration'];
    description = json['description'];
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
    meetingArea = json['meeting_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['employees'] = employees;
    data['non_employees'] = nonEmployees;
    data['event_choice'] = eventChoice;
    data['date'] = date;
    data['game'] = game;
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['description'] = description;
    if (pods != null) {
      data['pods'] = pods!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    if (teams != null) {
      data['teams'] = teams!.map((v) => v is Map<String, dynamic> ? v : {}).toList();
    }
    data['all_employee'] = allEmployee;
    data['meeting_area'] = meetingArea;
    return data;
  }
}
