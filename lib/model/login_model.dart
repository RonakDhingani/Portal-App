// ignore_for_file: prefer_collection_literals, unnecessary_new

class LoginUserModel {
  String? refresh;
  String? access;
  bool? isActive;
  bool? isVerified;
  int? id;
  String? image;
  String? email;
  bool? isAdminUser;
  String? expires;
  String? firstName;
  String? lastName;

  LoginUserModel(
      {this.refresh,
        this.access,
        this.isActive,
        this.isVerified,
        this.id,
        this.image,
        this.email,
        this.isAdminUser,
        this.expires,
        this.firstName,
        this.lastName});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    id = json['id'];
    image = json['image'];
    email = json['email'];
    isAdminUser = json['is_admin_user'];
    expires = json['expires'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = refresh;
    data['access'] = access;
    data['is_active'] = isActive;
    data['is_verified'] = isVerified;
    data['id'] = id;
    data['image'] = image;
    data['email'] = email;
    data['is_admin_user'] = isAdminUser;
    data['expires'] = expires;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
