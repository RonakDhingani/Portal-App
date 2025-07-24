class EmployeeOfTheMonthModel {
  List<Data>? data;

  EmployeeOfTheMonthModel({this.data});

  EmployeeOfTheMonthModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? month;
  int? year;
  bool? isActive;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  User? user;
  String? eomImage;

  Data(
      {this.id,
        this.month,
        this.year,
        this.isActive,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt,
        this.user,
        this.eomImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    month = json['month'];
    year = json['year'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    eomImage = json['eom_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['month'] = this.month;
    data['year'] = this.year;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['eom_image'] = this.eomImage;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? gender;
  String? team;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.team});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['team'] = this.team;
    return data;
  }
}
