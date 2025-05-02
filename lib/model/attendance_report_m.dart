class AttendanceReportM {
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  AttendanceReportM({this.status, this.result, this.error, this.version});

  AttendanceReportM.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != String) {
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
    if (this.result != String) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['version'] = this.version;
    return data;
  }
}

class Result {
  num? id;
  String? source;
  String? ip;
  String? lat;
  String? lng;
  String? remark;
  num? userId;
  String? deviceId;
  num? attendanceTypeId;
  String? inTime;
  String? outTime;
  num? arDetailId;
  bool? available;
  num? shiftId;
  String? otDetailId;
  String? uid;
  String? otHours;
  num? attendanceStatusId;
  String? sourceOutTime;
  String? ipOutTime;
  String? latOutTime;
  String? lngOutTime;
  String? deviceIdOutTime;
  bool? dailyTaskStatus;
  String? attendanceTypeName;
  int? inTimeDay;
  num? inTimeUnix;
  num? outTimeUnix;

  Result(
      {this.id,
      this.source,
      this.ip,
      this.lat,
      this.lng,
      this.remark,
      this.userId,
      this.deviceId,
      this.attendanceTypeId,
      this.inTime,
      this.outTime,
      this.arDetailId,
      this.available,
      this.shiftId,
      this.otDetailId,
      this.uid,
      this.otHours,
      this.attendanceStatusId,
      this.sourceOutTime,
      this.ipOutTime,
      this.latOutTime,
      this.lngOutTime,
      this.deviceIdOutTime,
        this.dailyTaskStatus,
      this.attendanceTypeName,
      this.inTimeDay,
      this.inTimeUnix,
      this.outTimeUnix});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    ip = json['ip'];
    lat = json['lat'];
    lng = json['lng'];
    remark = json['remark'];
    userId = json['userId'];
    deviceId = json['deviceId'];
    attendanceTypeId = json['attendanceTypeId'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    arDetailId = json['arDetailId'];
    available = json['available'];
    shiftId = json['shiftId'];
    otDetailId = json['otDetailId'];
    uid = json['uid'];
    otHours = json['otHours'];
    attendanceStatusId = json['attendanceStatusId'];
    sourceOutTime = json['source_outTime'];
    ipOutTime = json['ip_outTime'];
    latOutTime = json['lat_outTime'];
    lngOutTime = json['lng_outTime'];
    deviceIdOutTime = json['deviceId_outTime'];
    dailyTaskStatus = json['daily_task_status'];
    attendanceTypeName = json['attendanceTypeName'];
    inTimeDay = json['inTimeDay'];
    inTimeUnix = json['inTimeUnix'];
    outTimeUnix = json['outTimeUnix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source'] = this.source;
    data['ip'] = this.ip;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['remark'] = this.remark;
    data['userId'] = this.userId;
    data['deviceId'] = this.deviceId;
    data['attendanceTypeId'] = this.attendanceTypeId;
    data['inTime'] = this.inTime;
    data['outTime'] = this.outTime;
    data['arDetailId'] = this.arDetailId;
    data['available'] = this.available;
    data['shiftId'] = this.shiftId;
    data['otDetailId'] = this.otDetailId;
    data['uid'] = this.uid;
    data['otHours'] = this.otHours;
    data['attendanceStatusId'] = this.attendanceStatusId;
    data['source_outTime'] = this.sourceOutTime;
    data['ip_outTime'] = this.ipOutTime;
    data['lat_outTime'] = this.latOutTime;
    data['lng_outTime'] = this.lngOutTime;
    data['deviceId_outTime'] = this.deviceIdOutTime;
    data['daily_task_status'] = this.dailyTaskStatus;
    data['attendanceTypeName'] = this.attendanceTypeName;
    data['inTimeDay'] = this.inTimeDay;
    data['inTimeUnix'] = this.inTimeUnix;
    data['outTimeUnix'] = this.outTimeUnix;
    return data;
  }
}
