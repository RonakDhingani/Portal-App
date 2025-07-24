class YearFilterModel {
  List<Data>? data;
  List<CurrentFinancialYear>? currentFinancialYear;

  YearFilterModel({this.data, this.currentFinancialYear});

  YearFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['current_financial_year'] != null) {
      currentFinancialYear = <CurrentFinancialYear>[];
      json['current_financial_year'].forEach((v) {
        currentFinancialYear!.add(new CurrentFinancialYear.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.currentFinancialYear != null) {
      data['current_financial_year'] =
          this.currentFinancialYear!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? startYear;
  int? endYear;

  Data({this.startYear, this.endYear});

  Data.fromJson(Map<String, dynamic> json) {
    startYear = json['start_year'];
    endYear = json['end_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_year'] = this.startYear;
    data['end_year'] = this.endYear;
    return data;
  }
}

class CurrentFinancialYear {
  int? startYear;
  int? endYear;

  CurrentFinancialYear({this.startYear, this.endYear});

  CurrentFinancialYear.fromJson(Map<String, dynamic> json) {
    startYear = json['start_year'];
    endYear = json['end_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_year'] = this.startYear;
    data['end_year'] = this.endYear;
    return data;
  }
}
