// ignore_for_file: prefer_collection_literals

class PoliciesModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  PoliciesModel({this.count, this.next, this.previous, this.results});

  PoliciesModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? title;
  bool? isActive;
  String? file;
  String? fileData;
  int? fileSize;
  String? fileExtension;
  String? fileName;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;

  Results(
      {this.id,
        this.title,
        this.isActive,
        this.file,
        this.fileData,
        this.fileSize,
        this.fileExtension,
        this.fileName,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isActive = json['is_active'];
    file = json['file'];
    fileData = json['file_data'];
    fileSize = json['file_size'];
    fileExtension = json['file_extension'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['is_active'] = isActive;
    data['file'] = file;
    data['file_data'] = fileData;
    data['file_size'] = fileSize;
    data['file_extension'] = fileExtension;
    data['file_name'] = fileName;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
