class GameZoneGamesModel {
  int? id;
  String? name;
  String? image;
  bool? isActive;
  String? createdAt;
  String? modifiedAt;

  GameZoneGamesModel(
      {this.id,
        this.name,
        this.image,
        this.isActive,
        this.createdAt,
        this.modifiedAt});

  GameZoneGamesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    return data;
  }
  static List<GameZoneGamesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GameZoneGamesModel.fromJson(json)).toList();
  }
}
