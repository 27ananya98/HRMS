class TeamLeaveReport {
  TeamLeaveReport({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  TeamLeaveReport.fromJson(Map<String, dynamic> json){
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
    required this.other,
    required this.watchers,
  });
  late final List<Pending>? pending;
  late final List<Others>? others;
  late final List<Other>? other;
  late final List<Watchers>? watchers;

  Result.fromJson(Map<String, dynamic> json){
    pending = List.from(json['pending']).map((e)=>Pending.fromJson(e)).toList();
    others = List.from(json['others']).map((e)=>Others.fromJson(e)).toList();
    other = List.from(json['other']).map((e)=>Other.fromJson(e)).toList();
    watchers = List.from(json['watchers']).map((e)=>Watchers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pending'] = pending!.map((e)=>e.toJson()).toList();
    _data['others'] = others!.map((e)=>e.toJson()).toList();
    _data['other'] = other!.map((e)=>e.toJson()).toList();
    _data['watchers'] = watchers!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Pending {
  Pending({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.leaveTypeId,
    required this.leaveStatusId,
    required this.createdBy,
    required this.createdOn,
    required this.createdAt,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.numberOfDays,
    required this.assignedTo,
    required this.pending,
    required this.cancellationStatusId,
    required this.cancellationRequestedOn,
    required this.cancellationRequestedBy,
    required this.cancellationRequestedAt,
    required this.createdByDesignation,
    required this.modifiedByDesignation,
    required this.userId,
    required this.uid,
    required this.leaveTypeName,
    required this.createdByName,
    required this.modifiedByName,
    required this.assignedToName,
  });
  late final int? id;
  late final String? startDate;
  late final String? endDate;
  late final String? reason;
  late final int? leaveTypeId;
  late final int? leaveStatusId;
  late final int? createdBy;
  late final String? createdOn;
  late final String? createdAt;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? numberOfDays;
  late final int? assignedTo;
  late final bool? pending;
  late final int? cancellationStatusId;
  late final String? cancellationRequestedOn;
  late final int? cancellationRequestedBy;
  late final String? cancellationRequestedAt;
  late final String? createdByDesignation;
  late final String? modifiedByDesignation;
  late final int? userId;
  late final String? uid;
  late final String? leaveTypeName;
  late final String? createdByName;
  late final String? modifiedByName;
  late final String? assignedToName;

  Pending.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    leaveTypeId = json['leaveTypeId'];
    leaveStatusId = json['leaveStatusId'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['created'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    numberOfDays = json['numberOfDays'];
    assignedTo = json['assignedTo'];
    pending = json['pending'];
    cancellationStatusId = json['cancellationStatusId'];
    cancellationRequestedOn = json['cancellationRequestedOn'];
    cancellationRequestedBy = json['cancellationRequestedBy'];
    cancellationRequestedAt = json['cancellationRequestedAt'];
    createdByDesignation = json['createdByDesignation'];
    modifiedByDesignation = json['modifiedByDesignation'];
    userId = json['userId'];
    uid = json['uid'];
    leaveTypeName = json['leaveTypeName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
    assignedToName = json['assignedToName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['reason'] = reason;
    _data['leaveTypeId'] = leaveTypeId;
    _data['leaveStatusId'] = leaveStatusId;
    _data['createdBy'] = createdBy;
    _data['createdOn'] = createdOn;
    _data['createdAt'] = createdAt;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['numberOfDays'] = numberOfDays;
    _data['assignedTo'] = assignedTo;
    _data['pending'] = pending;
    _data['cancellationStatusId'] = cancellationStatusId;
    _data['cancellationRequestedOn'] = cancellationRequestedOn;
    _data['cancellationRequestedBy'] = cancellationRequestedBy;
    _data['cancellationRequestedAt'] = cancellationRequestedAt;
    _data['createdByDesignation'] = createdByDesignation;
    _data['modifiedByDesignation'] = modifiedByDesignation;
    _data['userId'] = userId;
    _data['uid'] = uid;
    _data['leaveTypeName'] = leaveTypeName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    _data['assignedToName'] = assignedToName;
    return _data;
  }
}

class Other {
  Other({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.leaveTypeId,
    required this.leaveStatusId,
    required this.createdBy,
    required this.createdOn,
    required this.createdAt,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.numberOfDays,
    required this.assignedTo,
    required this.pending,
    required this.cancellationStatusId,
    required this.cancellationRequestedOn,
    required this.cancellationRequestedBy,
    required this.cancellationRequestedAt,
    required this.createdByDesignation,
    required this.modifiedByDesignation,
    required this.userId,
    required this.uid,
    required this.startDay,
    required this.endDay,
    required this.leaveTypeName,
    required this.createdByName,
    required this.modifiedByName,
    required this.assignedToName,
  });
  late final int? id;
  late final String? startDate;
  late final String? endDate;
  late final String? reason;
  late final int? leaveTypeId;
  late final int? leaveStatusId;
  late final int? createdBy;
  late final String? createdOn;
  late final String? createdAt;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? numberOfDays;
  late final int? assignedTo;
  late final bool? pending;
  late final int? cancellationStatusId;
  late final String? cancellationRequestedOn;
  late final int? cancellationRequestedBy;
  late final String? cancellationRequestedAt;
  late final String? createdByDesignation;
  late final String? modifiedByDesignation;
  late final int? userId;
  late final String? uid;
  late final int? startDay;
  late final int? endDay;
  late final String? leaveTypeName;
  late final String? createdByName;
  late final String? modifiedByName;
  late final String? assignedToName;

  Other.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    leaveTypeId = json['leaveTypeId'];
    leaveStatusId = json['leaveStatusId'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    numberOfDays = json['numberOfDays'];
    assignedTo = json['assignedTo'];
    pending = json['pending'];
    cancellationStatusId = json['cancellationStatusId'];
    cancellationRequestedOn = json['cancellationRequestedOn'];
    cancellationRequestedBy = json['cancellationRequestedBy'];
    cancellationRequestedAt = json['cancellationRequestedAt'];
    createdByDesignation = json['createdByDesignation'];
    modifiedByDesignation = json['modifiedByDesignation'];
    userId = json['userId'];
    uid = json['uid'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    leaveTypeName = json['leaveTypeName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
    assignedToName = json['assignedToName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['reason'] = reason;
    _data['leaveTypeId'] = leaveTypeId;
    _data['leaveStatusId'] = leaveStatusId;
    _data['createdBy'] = createdBy;
    _data['createdOn'] = createdOn;
    _data['createdAt'] = createdAt;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['numberOfDays'] = numberOfDays;
    _data['assignedTo'] = assignedTo;
    _data['pending'] = pending;
    _data['cancellationStatusId'] = cancellationStatusId;
    _data['cancellationRequestedOn'] = cancellationRequestedOn;
    _data['cancellationRequestedBy'] = cancellationRequestedBy;
    _data['cancellationRequestedAt'] = cancellationRequestedAt;
    _data['createdByDesignation'] = createdByDesignation;
    _data['modifiedByDesignation'] = modifiedByDesignation;
    _data['userId'] = userId;
    _data['uid'] = uid;
    _data['startDay'] = startDay;
    _data['endDay'] = endDay;
    _data['leaveTypeName'] = leaveTypeName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    _data['assignedToName'] = assignedToName;
    return _data;
  }
}

class Watchers {
  Watchers({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.leaveTypeId,
    required this.leaveStatusId,
    required this.createdBy,
    required this.createdOn,
    required this.createdAt,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.numberOfDays,
    required this.assignedTo,
    required this.pending,
    required this.cancellationStatusId,
    required this.cancellationRequestedOn,
    required this.cancellationRequestedBy,
    required this.cancellationRequestedAt,
    required this.createdByDesignation,
    required this.modifiedByDesignation,
    required this.userId,
    required this.uid,
    required this.leaveTypeName,
    required this.createdByName,
    required this.modifiedByName,
    required this.assignedToName,
  });
  late final int? id;
  late final String? startDate;
  late final String? endDate;
  late final String? reason;
  late final int? leaveTypeId;
  late final int? leaveStatusId;
  late final int? createdBy;
  late final String? createdOn;
  late final String? createdAt;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? numberOfDays;
  late final int? assignedTo;
  late final bool? pending;
  late final int? cancellationStatusId;
  late final String? cancellationRequestedOn;
  late final int? cancellationRequestedBy;
  late final String? cancellationRequestedAt;
  late final String? createdByDesignation;
  late final String? modifiedByDesignation;
  late final int? userId;
  late final String? uid;
  late final String? leaveTypeName;
  late final String? createdByName;
  late final String? modifiedByName;
  late final String? assignedToName;

  Watchers.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    leaveTypeId = json['leaveTypeId'];
    leaveStatusId = json['leaveStatusId'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    numberOfDays = json['numberOfDays'];
    assignedTo = json['assignedTo'];
    pending = json['pending'];
    cancellationStatusId = json['cancellationStatusId'];
    cancellationRequestedOn = json['cancellationRequestedOn'];
    cancellationRequestedBy = json['cancellationRequestedBy'];
    cancellationRequestedAt = json['cancellationRequestedAt'];
    createdByDesignation = json['createdByDesignation'];
    modifiedByDesignation = json['modifiedByDesignation'];
    userId = json['userId'];
    uid = json['uid'];
    leaveTypeName = json['leaveTypeName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
    assignedToName = json['assignedToName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['reason'] = reason;
    _data['leaveTypeId'] = leaveTypeId;
    _data['leaveStatusId'] = leaveStatusId;
    _data['createdBy'] = createdBy;
    _data['createdOn'] = createdOn;
    _data['createdAt'] = createdAt;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['numberOfDays'] = numberOfDays;
    _data['assignedTo'] = assignedTo;
    _data['pending'] = pending;
    _data['cancellationStatusId'] = cancellationStatusId;
    _data['cancellationRequestedOn'] = cancellationRequestedOn;
    _data['cancellationRequestedBy'] = cancellationRequestedBy;
    _data['cancellationRequestedAt'] = cancellationRequestedAt;
    _data['createdByDesignation'] = createdByDesignation;
    _data['modifiedByDesignation'] = modifiedByDesignation;
    _data['userId'] = userId;
    _data['uid'] = uid;
    _data['leaveTypeName'] = leaveTypeName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    _data['assignedToName'] = assignedToName;
    return _data;
  }
}

class Others {
  Others({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.leaveTypeId,
    required this.leaveStatusId,
    required this.createdBy,
    required this.createdOn,
    required this.createdAt,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.numberOfDays,
    required this.assignedTo,
    required this.pending,
    required this.cancellationStatusId,
    required this.cancellationRequestedOn,
    required this.cancellationRequestedBy,
    required this.cancellationRequestedAt,
    required this.createdByDesignation,
    required this.modifiedByDesignation,
    required this.userId,
    required this.uid,
    required this.startDay,
    required this.endDay,
    required this.leaveTypeName,
    required this.createdByName,
    required this.modifiedByName,
    required this.assignedToName,
  });
  late final int? id;
  late final String? startDate;
  late final String? endDate;
  late final String? reason;
  late final int? leaveTypeId;
  late final int? leaveStatusId;
  late final int? createdBy;
  late final String? createdOn;
  late final String? createdAt;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? numberOfDays;
  late final int? assignedTo;
  late final bool? pending;
  late final int? cancellationStatusId;
  late final String? cancellationRequestedOn;
  late final int? cancellationRequestedBy;
  late final String? cancellationRequestedAt;
  late final String? createdByDesignation;
  late final String? modifiedByDesignation;
  late final int? userId;
  late final String? uid;
  late final int? startDay;
  late final int? endDay;
  late final String? leaveTypeName;
  late final String? createdByName;
  late final String? modifiedByName;
  late final String? assignedToName;

  Others.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reason = json['reason'];
    leaveTypeId = json['leaveTypeId'];
    leaveStatusId = json['leaveStatusId'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    numberOfDays = json['numberOfDays'];
    assignedTo = json['assignedTo'];
    pending = json['pending'];
    cancellationStatusId = json['cancellationStatusId'];
    cancellationRequestedOn = json['cancellationRequestedOn'];
    cancellationRequestedBy = json['cancellationRequestedBy'];
    cancellationRequestedAt = json['cancellationRequestedAt'];
    createdByDesignation = json['createdByDesignation'];
    modifiedByDesignation = json['modifiedByDesignation'];
    userId = json['userId'];
    uid = json['uid'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    leaveTypeName = json['leaveTypeName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
    assignedToName = json['assignedToName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['reason'] = reason;
    _data['leaveTypeId'] = leaveTypeId;
    _data['leaveStatusId'] = leaveStatusId;
    _data['createdBy'] = createdBy;
    _data['createdOn'] = createdOn;
    _data['createdAt'] = createdAt;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['numberOfDays'] = numberOfDays;
    _data['assignedTo'] = assignedTo;
    _data['pending'] = pending;
    _data['cancellationStatusId'] = cancellationStatusId;
    _data['cancellationRequestedOn'] = cancellationRequestedOn;
    _data['cancellationRequestedBy'] = cancellationRequestedBy;
    _data['cancellationRequestedAt'] = cancellationRequestedAt;
    _data['createdByDesignation'] = createdByDesignation;
    _data['modifiedByDesignation'] = modifiedByDesignation;
    _data['userId'] = userId;
    _data['uid'] = uid;
    _data['startDay'] = startDay;
    _data['endDay'] = endDay;
    _data['leaveTypeName'] = leaveTypeName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    _data['assignedToName'] = assignedToName;
    return _data;
  }
}