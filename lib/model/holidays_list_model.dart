class HolidayListModel {
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  HolidayListModel({this.status, this.result, this.error, this.version});

  HolidayListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['version'] = this.version;
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? date;
  String? description;
  String? holidayTypeName;

  Result(
      {this.id, this.name, this.date, this.description, this.holidayTypeName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    description = json['description'];
    holidayTypeName = json['holidayTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['description'] = this.description;
    data['holidayTypeName'] = this.holidayTypeName;
    return data;
  }
}
