class UpcomingBirthdayModel {
  int? count;
  List<Data>? data;
  String? message;

  UpcomingBirthdayModel({this.count, this.data, this.message});

  UpcomingBirthdayModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? image;
  String? birthDate;
  String? gender;
  UserOfficialDetails? userOfficialDetails;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.birthDate,
        this.gender,
        this.userOfficialDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    userOfficialDetails = json['user_official_details'] != null
        ? new UserOfficialDetails.fromJson(json['user_official_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['image'] = this.image;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    if (this.userOfficialDetails != null) {
      data['user_official_details'] = this.userOfficialDetails!.toJson();
    }
    return data;
  }
}

class UserOfficialDetails {
  String? code;
  String? designation;
  String? team;
  int? experienceYear;
  int? experienceMonth;

  UserOfficialDetails(
      {this.code,
        this.designation,
        this.team,
        this.experienceYear,
        this.experienceMonth});

  UserOfficialDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    designation = json['designation'];
    team = json['team'];
    experienceYear = json['experience_year'];
    experienceMonth = json['experience_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['designation'] = this.designation;
    data['team'] = this.team;
    data['experience_year'] = this.experienceYear;
    data['experience_month'] = this.experienceMonth;
    return data;
  }
}
