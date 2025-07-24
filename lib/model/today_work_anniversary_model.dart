class TodayWorkAnniversaryModel {
  int? count;
  List<Data>? data;

  TodayWorkAnniversaryModel({this.count, this.data});

  TodayWorkAnniversaryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  Userdetails? userdetails;
  String? gender;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.image,
        this.userdetails,
        this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    userdetails = json['userdetails'] != null
        ? new Userdetails.fromJson(json['userdetails'])
        : null;
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.toJson();
    }
    data['gender'] = this.gender;
    return data;
  }
}

class Userdetails {
  int? id;
  String? joiningDate;
  String? team;
  int? expYearVal;

  Userdetails({this.id, this.joiningDate, this.team, this.expYearVal});

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joiningDate = json['joining_date'];
    team = json['team'];
    expYearVal = json['exp_year_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['joining_date'] = this.joiningDate;
    data['team'] = this.team;
    data['exp_year_val'] = this.expYearVal;
    return data;
  }
}
