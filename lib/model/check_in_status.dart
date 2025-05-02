class CheckInStatus {
  CheckInStatus({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });

  late final bool status;
  late final Result? result;
  late final String? error;
  late final String? version;

  CheckInStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json.containsKey('result') && json['result'] != null) {
      result = Result.fromJson(json['result']);
    } else {
      result = null; // Set result to null if 'result' is null in JSON
    }
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    if (result != null) {
      _data['result'] = result!.toJson();
    }
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.attendanceTypeId,
    required this.inTime,
    required this.inTimeUnix,
    required this.attendanceTypeName,
  });

  late final int attendanceTypeId;
  late final String inTime;
  late final int inTimeUnix;
  late final String attendanceTypeName;

  Result.fromJson(Map<String, dynamic> json) {
    attendanceTypeId = json['attendanceTypeId'];
    inTime = json['inTime'];
    inTimeUnix = json['inTimeUnix'];
    attendanceTypeName = json['attendanceTypeName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['attendanceTypeId'] = attendanceTypeId;
    _data['inTime'] = inTime;
    _data['inTimeUnix'] = inTimeUnix;
    _data['attendanceTypeName'] = attendanceTypeName;
    return _data;
  }
}
