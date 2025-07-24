class TeamStatusModel {
  List<Data>? data;
  double? overall;
  int? totalEmployee;

  TeamStatusModel({this.data, this.overall, this.totalEmployee});

  TeamStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    overall = json['overall'];
    totalEmployee = json['total_employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['overall'] = this.overall;
    data['total_employee'] = this.totalEmployee;
    return data;
  }
}

class Data {
  String? name;
  double? value;
  double? count;
  String? color;

  Data({this.name, this.value, this.count, this.color});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    count = json['count'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['count'] = this.count;
    data['color'] = this.color;
    return data;
  }
}
