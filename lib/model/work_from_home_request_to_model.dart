class WorkFromHomeRequestToModel {
  List<Data>? data;
  String? message;

  WorkFromHomeRequestToModel({this.data, this.message});

  WorkFromHomeRequestToModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
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
  String? gender;
  String? roleName;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.image,
        this.gender,
        this.roleName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image'] = image;
    data['gender'] = gender;
    data['role_name'] = roleName;
    return data;
  }
}
