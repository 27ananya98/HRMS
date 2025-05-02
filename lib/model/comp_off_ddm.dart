class AddCompOffDdm {
  AddCompOffDdm({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  AddCompOffDdm.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result!.map((e)=>e.toJson()).toList();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.source,
    required this.ip,
    required this.lat,
    required this.lng,
    required this.remark,
    required this.userId,
    required this.deviceId,
    required this.attendanceTypeId,
    required this.inTime,
    required this.outTime,
    required this.arDetailId,
    required this.available,
    required this.shiftId,
    required this.otDetailId,
    required this.uid,
    required this.otHours,
    required this.attendanceStatusId,
    required this.ipOutTime,
    required this.latOutTime,
    required this.lngOutTime,
    required this.deviceIdOutTime,
    required this.sourceOutTime,
    required this.attendanceTypeName,
    required this.inTimeDay,
    required this.inTimeUnix,
    required this.outTimeUnix,
  });
  late final num? id;
  late final String? source;
  late final String? ip;
  late final String? lat;
  late final String? lng;
  late final String? remark;
  late final num? userId;
  late final String? deviceId;
  late final num? attendanceTypeId;
  late final String? inTime;
  late final String? outTime;
  late final num? arDetailId;
  late final bool? available;
  late final num? shiftId;
  late final String? otDetailId;
  late final String? uid;
  late final String? otHours;
  late final String? attendanceStatusId;
  late final String? ipOutTime;
  late final String? latOutTime;
  late final String? lngOutTime;
  late final String? deviceIdOutTime;
  late final String? sourceOutTime;
  late final String? attendanceTypeName;
  late final num? inTimeDay;
  late final num? inTimeUnix;
  late final num? outTimeUnix;

  Result.fromJson(Map<String, dynamic> json){
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
    ipOutTime = json['ipOutTime'];
    latOutTime = json['latOutTime'];
    lngOutTime = json['lngOutTime'];
    deviceIdOutTime = json['deviceIdOutTime'];
    sourceOutTime = json['sourceOutTime'];
    attendanceTypeName = json['attendanceTypeName'];
    inTimeDay = json['inTimeDay'];
    inTimeUnix = json['inTimeUnix'];
    outTimeUnix = json['outTimeUnix'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['source'] = source;
    _data['ip'] = ip;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['remark'] = remark;
    _data['userId'] = userId;
    _data['deviceId'] = deviceId;
    _data['attendanceTypeId'] = attendanceTypeId;
    _data['inTime'] = inTime;
    _data['outTime'] = outTime;
    _data['arDetailId'] = arDetailId;
    _data['available'] = available;
    _data['shiftId'] = shiftId;
    _data['otDetailId'] = otDetailId;
    _data['uid'] = uid;
    _data['otHours'] = otHours;
    _data['attendanceStatusId'] = attendanceStatusId;
    _data['ip_outTime'] = ipOutTime;
    _data['lat_outTime'] = latOutTime;
    _data['lng_outTime'] = lngOutTime;
    _data['deviceId_outTime'] = deviceIdOutTime;
    _data['source_outTime'] = sourceOutTime;
    _data['attendanceTypeName'] = attendanceTypeName;
    _data['inTimeDay'] = inTimeDay;
    _data['inTimeUnix'] = inTimeUnix;
    _data['outTimeUnix'] = outTimeUnix;
    return _data;
  }
}