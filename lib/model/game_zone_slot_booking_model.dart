class GameZoneSlotBookingModel {
  List<Result>? result;

  GameZoneSlotBookingModel({this.result});

  GameZoneSlotBookingModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? flag;
  String? startTime;
  String? endTime;
  bool? mine;
  int? instance;
  bool? idDisable;

  Result(
      {this.flag,
        this.startTime,
        this.endTime,
        this.mine,
        this.instance,
        this.idDisable});

  Result.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    mine = json['mine'];
    instance = json['instance'];
    idDisable = json['id_disable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flag'] = flag;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['mine'] = mine;
    data['instance'] = instance;
    data['id_disable'] = idDisable;
    return data;
  }
}
