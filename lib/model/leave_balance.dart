class LeaveBalance {
  bool? status;
  Result? result;
  String? error;
  String? version;

  LeaveBalance({this.status, this.result, this.error, this.version});

  LeaveBalance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['error'] = this.error;
    data['version'] = this.version;
    return data;
  }
}

class Result {
  String? userId;
  List<LeaveTypeList>? leaveTypeList;

  Result({this.userId, this.leaveTypeList});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['leaveTypeList'] != null) {
      leaveTypeList = <LeaveTypeList>[];
      json['leaveTypeList'].forEach((v) {
        leaveTypeList!.add(new LeaveTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    if (this.leaveTypeList != null) {
      data['leaveTypeList'] =
          this.leaveTypeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypeList {
  num? id;
  String? name;
  num? total;
  num? used;

  LeaveTypeList({this.id, this.name, this.total, this.used});

  LeaveTypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    total = json['total'];
    used = json['used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total'] = this.total;
    data['used'] = this.used;
    return data;
  }
}
