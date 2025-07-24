class GameZoneUserModel {
  int? id;
  String? label;
  String? value;

  GameZoneUserModel({this.id, this.label, this.value});

  GameZoneUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['value'] = value;
    return data;
  }
  static List<GameZoneUserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GameZoneUserModel.fromJson(json)).toList();
  }

}
