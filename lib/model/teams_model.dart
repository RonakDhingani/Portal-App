class TeamsModal {
  int? id;
  String? name;

  TeamsModal({this.id, this.name});

  TeamsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  // Function to parse a list of TeamsModal from JSON
  static List<TeamsModal> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TeamsModal.fromJson(json)).toList();
  }
}
