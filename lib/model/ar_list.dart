class ArList {
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  ArList({this.status, this.result, this.error, this.version});

  ArList.fromJson(Map<String, dynamic> json) {
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
  String? inTime;
  String? outTime;
  String? comment;
  int? attendanceTypeId;
  String? attendanceTypeName;
  int? shiftId;
  String? shiftName;
  int? pendingWith;
  String? pendingWithName;
  String? createdOn;
  String? modifiedOn;
  int? statusId;
  String? statusName;
  String? createdByName;
  String? modifiedByName;

  Result(
      {this.id,
      this.inTime,
      this.outTime,
      this.comment,
      this.attendanceTypeId,
      this.attendanceTypeName,
      this.shiftId,
      this.shiftName,
      this.pendingWith,
      this.pendingWithName,
      this.createdOn,
      this.modifiedOn,
      this.statusId,
      this.statusName,
      this.createdByName,
      this.modifiedByName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    comment = json['comment'];
    attendanceTypeId = json['attendanceTypeId'];
    attendanceTypeName = json['attendanceTypeName'];
    shiftId = json['shiftId'];
    shiftName = json['shiftName'];
    pendingWith = json['pendingWith'];
    pendingWithName = json['pendingWithName'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inTime'] = this.inTime;
    data['outTime'] = this.outTime;
    data['comment'] = this.comment;
    data['attendanceTypeId'] = this.attendanceTypeId;
    data['attendanceTypeName'] = this.attendanceTypeName;
    data['shiftId'] = this.shiftId;
    data['shiftName'] = this.shiftName;
    data['pendingWith'] = this.pendingWith;
    data['pendingWithName'] = this.pendingWithName;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['createdByName'] = this.createdByName;
    data['modifiedByName'] = this.modifiedByName;
    return data;
  }
}
