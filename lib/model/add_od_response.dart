class AddOdResponse {
  bool? status;
  Result? result;
  String? error;
  String? version;

  AddOdResponse({this.status, this.result, this.error, this.version});

  AddOdResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    error = json['error'];
    version = json['version'];
  }
}

class Result {
  int? id;
  String? inDate;
  String? outTime;
  String? source;
  String? ip;
  String? lat;
  String? lng;
  String? remark;
  String? category;
  String? inTime;
  String? outDate;
  int? compOffId;
  int? onDutyId;
  int? wfhId;
  int? employeeId;
  String? deviceId;

  Result({this.id, this.inDate, this.outTime, this.source, this.ip, this.lat, this.lng, this.remark, this.category, this.inTime, this.outDate, this.compOffId, this.onDutyId, this.wfhId, this.employeeId, this.deviceId});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inDate = json['inDate'];
    outTime = json['outTime'];
    source = json['source'];
    ip = json['ip'];
    lat = json['lat'];
    lng = json['lng'];
    remark = json['remark'];
    category = json['category'];
    inTime = json['inTime'];
    outDate = json['outDate'];
    compOffId = json['compOffId'];
    onDutyId = json['onDutyId'];
    wfhId = json['wfhId'];
    employeeId = json['employeeId'];
    deviceId = json['deviceId'];
  }
}