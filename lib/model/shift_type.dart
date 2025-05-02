class ShiftType {
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  ShiftType({this.status, this.result, this.error, this.version});

  ShiftType.fromJson(Map<String, dynamic> json) {
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
  String? description;
  int? modifiedBy;
  String? modifiedOn;
  String? modifiedAt;
  bool? available;
  String? startTime;
  String? endTime;
  String? minimumHoursForHalfday;
  String? minimumHoursForFullday;
  String? orgId;

  Result(
      {this.id,
      this.name,
      this.description,
      this.modifiedBy,
      this.modifiedOn,
      this.modifiedAt,
      this.available,
      this.startTime,
      this.endTime,
      this.minimumHoursForHalfday,
      this.minimumHoursForFullday,
      this.orgId});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    modifiedAt = json['modifiedAt'];
    available = json['available'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    minimumHoursForHalfday = json['minimumHoursForHalfday'];
    minimumHoursForFullday = json['minimumHoursForFullday'];
    orgId = json['org_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['modifiedAt'] = this.modifiedAt;
    data['available'] = this.available;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['minimumHoursForHalfday'] = this.minimumHoursForHalfday;
    data['minimumHoursForFullday'] = this.minimumHoursForFullday;
    data['org_id'] = this.orgId;
    return data;
  }
}
