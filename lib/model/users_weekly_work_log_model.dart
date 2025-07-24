class UserWeeklyWorkLogModel {
  Data? data;
  Labels? labels;

  UserWeeklyWorkLogModel({this.data, this.labels});

  UserWeeklyWorkLogModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    labels =
    json['labels'] != null ? new Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.labels != null) {
      data['labels'] = this.labels!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  int? next;
  int? previous;
  List<Results>? results;

  Data({this.count, this.next, this.previous, this.results});

  Data.fromJson(Map<String, dynamic> json) {
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
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? logDate;
  String? totalDuration;
  String? employeeCode;
  String? employeeName;
  List<Log>? log;
  List<String>? duration;
  String? gamezoneDuration;
  Config? config;

  Results(
      {this.id,
        this.logDate,
        this.totalDuration,
        this.employeeCode,
        this.employeeName,
        this.log,
        this.duration,
        this.gamezoneDuration,
        this.config});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logDate = json['log_date'];
    totalDuration = json['total_duration'];
    employeeCode = json['employee_code'];
    employeeName = json['employee_name'];
    if (json['log'] != null) {
      log = <Log>[];
      json['log'].forEach((v) {
        log!.add(new Log.fromJson(v));
      });
    }
    duration = json['duration'].cast<String>();
    gamezoneDuration = json['gamezone_duration'];
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['log_date'] = this.logDate;
    data['total_duration'] = this.totalDuration;
    data['employee_code'] = this.employeeCode;
    data['employee_name'] = this.employeeName;
    if (this.log != null) {
      data['log'] = this.log!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['gamezone_duration'] = this.gamezoneDuration;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    return data;
  }
}

class Log {
  String? device;
  String? time;
  String? punch;

  Log({this.device, this.time, this.punch});

  Log.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    time = json['time'];
    punch = json['punch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device'] = this.device;
    data['time'] = this.time;
    data['punch'] = this.punch;
    return data;
  }
}

class Config {
  bool? isInDanger;
  bool? isHoliday;
  IsWfh? isWfh;
  IsWfh? leave;

  Config({this.isInDanger, this.isHoliday, this.isWfh, this.leave});

  Config.fromJson(Map<String, dynamic> json) {
    isInDanger = json['isInDanger'];
    isHoliday = json['isHoliday'];
    isWfh = json['isWfh'] != null ? new IsWfh.fromJson(json['isWfh']) : null;
    leave = json['leave'] != null ? new IsWfh.fromJson(json['leave']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isInDanger'] = this.isInDanger;
    data['isHoliday'] = this.isHoliday;
    if (this.isWfh != null) {
      data['isWfh'] = this.isWfh!.toJson();
    }
    if (this.leave != null) {
      data['leave'] = this.leave!.toJson();
    }
    return data;
  }
}

class IsWfh {
  bool? full;
  bool? firstHalf;
  bool? secondHalf;

  IsWfh({this.full, this.firstHalf, this.secondHalf});

  IsWfh.fromJson(Map<String, dynamic> json) {
    full = json['full'];
    firstHalf = json['first_half'];
    secondHalf = json['second_half'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full'] = this.full;
    data['first_half'] = this.firstHalf;
    data['second_half'] = this.secondHalf;
    return data;
  }
}

class Labels {
  var lastDay;
  var thisWeek;
  var thisMonthAverage;

  Labels({this.lastDay, this.thisWeek, this.thisMonthAverage});

  Labels.fromJson(Map<String, dynamic> json) {
    lastDay = json['last_day'];
    thisWeek = json['this_week'];
    thisMonthAverage = json['this_month_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_day'] = this.lastDay;
    data['this_week'] = this.thisWeek;
    data['this_month_average'] = this.thisMonthAverage;
    return data;
  }
}
