class CompOff {
  CompOff({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  CompOff.fromJson(Map<String, dynamic> json){
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
    required this.attendanceId,
    required this.comment,
    required this.createdOn,
    required this.createdBy,
    required this.createdAt,
    required this.statusId,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.modifiedAt,
    required this.leaveTypeId,
    required this.pendingWith,
    required this.cancelled,
    required this.cancelledOn,
    required this.createdByDesignation,
    required this.attendanceTypeId,
    required this.inTime,
    required this.outTime,
    required this.leaveTypeName,
    required this.assignedToName,
    required this.attendanceTypeName,
    required this.statusName,
    required this.modifiedByName,
    required this.createdByName,
  });
  late final int? id;
  late final int? attendanceId;
  late final String? comment;
  late final String? createdOn;
  late final int? createdBy;
  late final String? createdAt;
  late final int? statusId;
  late final int? modifiedBy;
  late final String? modifiedOn;
  late final String? modifiedAt;
  late final int? leaveTypeId;
  late final int? pendingWith;
  late final String? cancelled;
  late final String? cancelledOn;
  late final String? createdByDesignation;
  late final int? attendanceTypeId;
  late final String? inTime;
  late final String? outTime;
  late final String? leaveTypeName;
  late final String? assignedToName;
  late final String? attendanceTypeName;
  late final String? statusName;
  late final String? modifiedByName;
  late final String? createdByName;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    attendanceId = json['attendanceId'];
    comment = json['comment'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    statusId = json['statusId'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    modifiedAt = json['modifiedAt'];
    leaveTypeId = json['leaveTypeId'];
    pendingWith = json['pendingWith'];
    cancelled = json['cancelled'];
    cancelledOn = json['cancelledOn'];
    createdByDesignation = json['createdByDesignation'];
    attendanceTypeId = json['attendanceTypeId'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    leaveTypeName = json['leaveTypeName'];
    assignedToName = json['assignedToName'];
    attendanceTypeName = json['attendanceTypeName'];
    statusName = json['statusName'];
    modifiedByName = json['modifiedByName'];
    createdByName = json['createdByName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attendanceId'] = attendanceId;
    _data['comment'] = comment;
    _data['createdOn'] = createdOn;
    _data['createdBy'] = createdBy;
    _data['createdAt'] = createdAt;
    _data['statusId'] = statusId;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedAt'] = modifiedAt;
    _data['leaveTypeId'] = leaveTypeId;
    _data['pendingWith'] = pendingWith;
    _data['cancelled'] = cancelled;
    _data['cancelledOn'] = cancelledOn;
    _data['createdByDesignation'] = createdByDesignation;
    _data['attendanceTypeId'] = attendanceTypeId;
    _data['inTime'] = inTime;
    _data['outTime'] = outTime;
    _data['leaveTypeName'] = leaveTypeName;
    _data['assignedToName'] = assignedToName;
    _data['attendanceTypeName'] = attendanceTypeName;
    _data['statusName'] = statusName;
    _data['modifiedByName'] = modifiedByName;
    _data['createdByName'] = createdByName;
    return _data;
  }
}