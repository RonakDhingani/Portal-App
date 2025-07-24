class HolidayDateModel {
  int? id;
  String? date;

  HolidayDateModel({this.id, this.date});

  // Factory constructor to handle parsing from JSON
  factory HolidayDateModel.fromJson(Map<String, dynamic> json) {
    return HolidayDateModel(
      id: json['id'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'date': this.date,
    };
  }
}
