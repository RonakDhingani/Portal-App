class AllActiveUserModel {
  List<Data>? data;
  String? message;

  AllActiveUserModel({this.data, this.message});

  AllActiveUserModel.fromJson(Map<String, dynamic> json) {
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
  Designation? designation;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.designation,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
  static List<Data> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Data.fromJson(json)).toList();
  }
}

class Designation {
  int? id;
  String? name;
  String? code;

  Designation({this.id, this.name, this.code});

  Designation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }


}
