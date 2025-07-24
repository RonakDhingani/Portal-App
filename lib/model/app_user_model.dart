class AppUser {
  final String id;
  final String fireUserID;
  final String fireUserName;
  final String password;

  AppUser({
    required this.id,
    required this.fireUserID,
    required this.fireUserName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'fireUserID': fireUserID,
      'fireUserName': fireUserName,
      'password': password,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map, String id) {
    return AppUser(
      id: id,
      fireUserID: map['fireUserID'] ?? '',
      fireUserName: map['fireUserName'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
