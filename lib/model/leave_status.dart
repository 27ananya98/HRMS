class LeaveStatus {
  LeaveStatus({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  LeaveStatus.fromJson(Map<String, dynamic> json){
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
    required this.detail,
    required this.comments,
  });
  late final Detail? detail;
  late final List<Comments>? comments;

  Result.fromJson(Map<String, dynamic> json){
    detail = Detail.fromJson(json['detail']);
    comments = List.from(json['comments']).map((e)=>Comments.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['detail'] = detail!.toJson();
    _data['comments'] = comments!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Detail {
  Detail({
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
    required this.leaveStatusName,
    required this.assignedToName,
    required this.createdByName,
    required this.modifiedByName,
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
  late final String? leaveStatusName;
  late final String? assignedToName;
  late final String? createdByName;
  late final String? modifiedByName;

  Detail.fromJson(Map<String, dynamic> json){
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
    leaveStatusName = json['leaveStatusName'];
    assignedToName = json['assignedToName'];
    createdByName = json['createdByName'];
    modifiedByName = json['modifiedByName'];
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
    _data['leaveStatusName'] = leaveStatusName;
    _data['assignedToName'] = assignedToName;
    _data['createdByName'] = createdByName;
    _data['modifiedByName'] = modifiedByName;
    return _data;
  }
}

class Comments {
  Comments({
    required this.id,
    required this.comment,
    required this.leaveId,
    required this.statusId,
    required this.createdBy,
    required this.createdOn,
    required this.createdAt,
    required this.requestedCancellation,
    required this.createdByDesignation,
    required this.statusName,
    required this.createdByName,
  });
  late final int? id;
  late final String? comment;
  late final int? leaveId;
  late final int? statusId;
  late final int? createdBy;
  late final String? createdOn;
  late final String? createdAt;
  late final bool? requestedCancellation;
  late final String? createdByDesignation;
  late final String? statusName;
  late final String? createdByName;

  Comments.fromJson(Map<String, dynamic> json){
    id = json['id'];
    comment = json['comment'];
    leaveId = json['leaveId'];
    statusId = json['statusId'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    requestedCancellation = json['requestedCancellation'];
    createdByDesignation = json['createdByDesignation'];
    statusName = json['statusName'];
    createdByName = json['createdByName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['comment'] = comment;
    _data['leaveId'] = leaveId;
    _data['statusId'] = statusId;
    _data['createdBy'] = createdBy;
    _data['createdOn'] = createdOn;
    _data['createdAt'] = createdAt;
    _data['requestedCancellation'] = requestedCancellation;
    _data['createdByDesignation'] = createdByDesignation;
    _data['statusName'] = statusName;
    _data['createdByName'] = createdByName;
    return _data;
  }
}