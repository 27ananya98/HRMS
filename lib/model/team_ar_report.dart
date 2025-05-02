class TeamArReport {
  TeamArReport({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  TeamArReport.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = Result.fromJson(json['result']);
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result!.toJson();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.pending,
    required this.others,
  });
  late final List<Pending>? pending;
  late final List<Others>? others;

  Result.fromJson(Map<String, dynamic> json){
    pending = List.from(json['pending']).map((e)=>Pending.fromJson(e)).toList();
    others = List.from(json['others']).map((e)=>Others.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pending'] = pending!.map((e)=>e.toJson()).toList();
    _data['others'] = others!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Pending {
  Pending({
    required this.id,
    required this.inTime,
    required this.outTime,
    required this.comment,
    required this.attendanceTypeId,
    required this.attendanceTypeName,
    required this.createdOn,
    required this.modifiedOn,
    required this.statusId,
    required this.statusName,
    required this.createdByName,
    required this.modifiedByName,
  });
  late final int? id;
  late final String? inTime;
  late final String? outTime;
  late final String? comment;
  late final int? attendanceTypeId;
  late final String? attendanceTypeName;
  late final String? createdOn;
  late final String? modifiedOn;
  late final int? statusId;
  late final String? statusName;
  late final String? createdByName;
  late final String? modifiedByName;

  Pending.fromJson(Map<String, dynamic> json){
    id = json['id'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    comment = json['comment'];
    attendanceTypeId = json['attendanceTypeId'];
    attendanceTypeName = json['attendanceTypeName'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['inTime'] = inTime;
    _data['outTime'] = outTime;
    _data['comment'] = comment;
    _data['attendanceTypeId'] = attendanceTypeId;
    _data['attendanceTypeName'] = attendanceTypeName;
    _data['createdOn'] = createdOn;
    _data['modifiedOn'] = modifiedOn;
    _data['statusId'] = statusId;
    _data['statusName'] = statusName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    return _data;
  }
}

class Others {
  Others({
    required this.id,
    required this.inTime,
    required this.outTime,
    required this.comment,
    required this.attendanceTypeId,
    required this.attendanceTypeName,
    required this.createdOn,
    required this.modifiedOn,
    required this.statusId,
    required this.statusName,
    required this.createdByName,
    required this.modifiedByName,
  });
  late final int? id;
  late final String? inTime;
  late final String? outTime;
  late final String? comment;
  late final int? attendanceTypeId;
  late final String? attendanceTypeName;
  late final String? createdOn;
  late final String? modifiedOn;
  late final int? statusId;
  late final String? statusName;
  late final String? createdByName;
  late final String? modifiedByName;

  Others.fromJson(Map<String, dynamic> json){
    id = json['id'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    comment = json['comment'];
    attendanceTypeId = json['attendanceTypeId'];
    attendanceTypeName = json['attendanceTypeName'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['inTime'] = inTime;
    _data['outTime'] = outTime;
    _data['comment'] = comment;
    _data['attendanceTypeId'] = attendanceTypeId;
    _data['attendanceTypeName'] = attendanceTypeName;
    _data['createdOn'] = createdOn;
    _data['modifiedOn'] = modifiedOn;
    _data['statusId'] = statusId;
    _data['statusName'] = statusName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    return _data;
  }
}