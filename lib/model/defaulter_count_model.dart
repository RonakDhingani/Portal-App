class DefaulterCountModel {
  int? totalDefaulterCount;
  List<CategoryWiseCounts>? categoryWiseCounts;

  DefaulterCountModel({this.totalDefaulterCount, this.categoryWiseCounts});

  DefaulterCountModel.fromJson(Map<String, dynamic> json) {
    totalDefaulterCount = json['total_defaulter_count'];
    if (json['category_wise_counts'] != null) {
      categoryWiseCounts = <CategoryWiseCounts>[];
      json['category_wise_counts'].forEach((v) {
        categoryWiseCounts!.add(new CategoryWiseCounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_defaulter_count'] = this.totalDefaulterCount;
    if (this.categoryWiseCounts != null) {
      data['category_wise_counts'] =
          this.categoryWiseCounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryWiseCounts {
  int? categoryId;
  String? categoryName;
  List<DefaulterData>? defaulterData;
  int? count;

  CategoryWiseCounts(
      {this.categoryId, this.categoryName, this.defaulterData, this.count});

  CategoryWiseCounts.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['defaulter_data'] != null) {
      defaulterData = <DefaulterData>[];
      json['defaulter_data'].forEach((v) {
        defaulterData!.add(new DefaulterData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.defaulterData != null) {
      data['defaulter_data'] =
          this.defaulterData!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class DefaulterData {
  int? id;
  String? createdAt;
  String? modifiedAt;
  String? deletedAt;
  bool? isActive;
  String? description;
  String? status;
  bool? isDeducted;
  String? deductionDescription;
  String? inactiveComment;
  int? createdBy;
  int? modifiedBy;
  int? deletedBy;
  int? employee;
  Reason? reason;
  int? reportedBy;
  Reason? category;

  DefaulterData(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.deletedAt,
        this.isActive,
        this.description,
        this.status,
        this.isDeducted,
        this.deductionDescription,
        this.inactiveComment,
        this.createdBy,
        this.modifiedBy,
        this.deletedBy,
        this.employee,
        this.reason,
        this.reportedBy,
        this.category});

  DefaulterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deletedAt = json['deleted_at'];
    isActive = json['is_active'];
    description = json['description'];
    status = json['status'];
    isDeducted = json['is_deducted'];
    deductionDescription = json['deduction_description'];
    inactiveComment = json['inactive_comment'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    deletedBy = json['deleted_by'];
    employee = json['employee'];
    reason =
    json['reason'] != null ? new Reason.fromJson(json['reason']) : null;
    reportedBy = json['reported_by'];
    category =
    json['category'] != null ? new Reason.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_active'] = this.isActive;
    data['description'] = this.description;
    data['status'] = this.status;
    data['is_deducted'] = this.isDeducted;
    data['deduction_description'] = this.deductionDescription;
    data['inactive_comment'] = this.inactiveComment;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['deleted_by'] = this.deletedBy;
    data['employee'] = this.employee;
    if (this.reason != null) {
      data['reason'] = this.reason!.toJson();
    }
    data['reported_by'] = this.reportedBy;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Reason {
  int? id;
  String? name;

  Reason({this.id, this.name});

  Reason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
