class MyTimeEntryMonthModel {
  int? total;
  int? pageSize;
  int? page;
  List<Result>? results;
  Labels? labels;

  MyTimeEntryMonthModel(
      {this.total, this.pageSize, this.page, this.results, this.labels});

  MyTimeEntryMonthModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['page_size'];
    page = json['page'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
    labels =
    json['labels'] != null ? Labels.fromJson(json['labels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class Result {
  int? id;
  String? logDate;
  String? totalDuration;
  String? employeeCode;
  String? employeeName;
  List<Log>? log;
  List<String>? duration;
  String? gamezoneDuration;

  Result(
      {this.id,
        this.logDate,
        this.totalDuration,
        this.employeeCode,
        this.employeeName,
        this.log,
        this.duration,
        this.gamezoneDuration});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logDate = json['log_date'];
    totalDuration = json['total_duration'];
    employeeCode = json['employee_code'];
    employeeName = json['employee_name'];
    if (json['log'] != null) {
      log = <Log>[];
      json['log'].forEach((v) {
        log!.add(Log.fromJson(v));
      });
    }
    duration = json['duration'].cast<String>();
    gamezoneDuration = json['gamezone_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['log_date'] = logDate;
    data['total_duration'] = totalDuration;
    data['employee_code'] = employeeCode;
    data['employee_name'] = employeeName;
    if (log != null) {
      data['log'] = log!.map((v) => v.toJson()).toList();
    }
    data['duration'] = duration;
    data['gamezone_duration'] = gamezoneDuration;
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

class Labels {
  dynamic lastDay;
  dynamic thisWeek;
  dynamic thisMonthAverage;

  Labels({this.lastDay, this.thisWeek, this.thisMonthAverage});

  Labels.fromJson(Map<String, dynamic> json) {
    lastDay = json['last_day'];
    thisWeek = json['this_week'];
    thisMonthAverage = json['this_month_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_day'] = lastDay;
    data['this_week'] = thisWeek;
    data['this_month_average'] = thisMonthAverage;
    return data;
  }
}
