class StoredUser {
  final String name;
  final String email;
  final String accessToken;
  final String refreshToken;
  final String image;
  final bool isCurrent;

  StoredUser({
    required this.name,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.image,
    this.isCurrent = false,
  });

  factory StoredUser.fromJson(Map<String, dynamic> json) => StoredUser(
    name: json['name'],
    email: json['email'],
    accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],
    image: json['image'] ?? '',
    isCurrent: json['isCurrent'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'image': image,
    'isCurrent': isCurrent,
  };

  StoredUser copyWith({
    bool? isCurrent,
    String? name,
    String? email,
    String? accessToken,
    String? refreshToken,
    String? image,
  }) {
    return StoredUser(
      name: name ?? this.name,
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      image: image ?? this.image,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
