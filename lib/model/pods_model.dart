class PodsModel {
  int? id;
  String? name;

  PodsModel({this.id, this.name});

  PodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  static List<PodsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PodsModel.fromJson(json)).toList();
  }
}
