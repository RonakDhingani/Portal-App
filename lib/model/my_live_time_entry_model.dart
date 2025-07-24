class MyLiveTimeEntryModel {
  List<Results>? results;

  MyLiveTimeEntryModel({this.results});

  MyLiveTimeEntryModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? totalDuration;
  String? employeeCode;
  String? logDate;
  String? employeeName;
  List<Log>? log;
  List<String>? duration;
  String? gamezoneDuration;
  Config? config;

  Results(
      {this.totalDuration,
      this.employeeCode,
      this.logDate,
      this.employeeName,
      this.log,
      this.duration,
      this.gamezoneDuration,
      this.config});

  Results.fromJson(Map<String, dynamic> json) {
    totalDuration = json['total_duration'];
    employeeCode = json['employee_code'];
    logDate = json['log_date'];
    employeeName = json['employee_name'];
    if (json['log'] != null) {
      log = <Log>[];
      json['log'].forEach((v) {
        log!.add(Log.fromJson(v));
      });
    }
    if (json['duration'] != null) {
      duration = <String>[];
      json['duration'].forEach((v) {
        duration!.add(v);
      });
    }
    gamezoneDuration = json['gamezone_duration'];
    config =
        json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_duration'] = totalDuration;
    data['employee_code'] = employeeCode;
    data['log_date'] = logDate;
    data['employee_name'] = employeeName;
    if (log != null) {
      data['log'] = log!.map((v) => v.toJson()).toList();
    }
    if (duration != null) {
      data['duration'] = duration!
          .map((v) => v is Map<String, dynamic> ? v : {})
          .toList();
    }
    data['gamezone_duration'] = gamezoneDuration;
    if (config != null) {
      data['config'] = config!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device'] = device;
    data['time'] = time;
    data['punch'] = punch;
    return data;
  }
}

class Config {
  bool? isInDanger;
  bool? isHoliday;
  IsWfh? isWfh;
  bool? leave;

  Config({this.isInDanger, this.isHoliday, this.isWfh, this.leave});

  Config.fromJson(Map<String, dynamic> json) {
    isInDanger = json['isInDanger'];
    isHoliday = json['isHoliday'];
    isWfh = json['isWfh'] != null ? IsWfh.fromJson(json['isWfh']) : null;
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isInDanger'] = isInDanger;
    data['isHoliday'] = isHoliday;
    if (isWfh != null) {
      data['isWfh'] = isWfh!.toJson();
    }
    data['leave'] = leave;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full'] = full;
    data['first_half'] = firstHalf;
    data['second_half'] = secondHalf;
    return data;
  }
}
