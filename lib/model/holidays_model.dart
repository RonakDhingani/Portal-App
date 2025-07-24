class HolidaysResponse {
  List<HolidaysModel>? results;

  HolidaysResponse({this.results});

  HolidaysResponse.fromJson(List<dynamic> jsonList) {
    results = jsonList.map((x) => HolidaysModel.fromJson(x)).toList();
  }

  List<dynamic> toJson() {
    return results?.map((x) => x.toJson()).toList() ?? [];
  }
}

class HolidaysModel {
  int? id;
  String? name;
  String? date;
  bool? isActive;
  String? holidayImage;
  String? holidayImageData;
  String? createdAt;
  String? modifiedAt;
  String? month;
  String? deletedAt;
  int? year;
  Count? count;
  int? day;

  HolidaysModel(
      {this.id,
        this.name,
        this.date,
        this.isActive,
        this.holidayImage,
        this.holidayImageData,
        this.createdAt,
        this.modifiedAt,
        this.month,
        this.deletedAt,
        this.year,
        this.count,
        this.day});

  HolidaysModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    isActive = json['is_active'];
    holidayImage = json['holiday_image'];
    holidayImageData = json['holiday_image_data'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    month = json['month'];
    deletedAt = json['deleted_at'];
    year = json['year'];
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['is_active'] = this.isActive;
    data['holiday_image'] = this.holidayImage;
    data['holiday_image_data'] = this.holidayImageData;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['month'] = this.month;
    data['deleted_at'] = this.deletedAt;
    data['year'] = this.year;
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    data['day'] = this.day;
    return data;
  }
}

class Count {
  int? active;
  int? inactive;

  Count({this.active, this.inactive});

  Count.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    inactive = json['inactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['inactive'] = this.inactive;
    return data;
  }
}
