class LeaveReportOther {
  List<Others>? others;

  LeaveReportOther({this.others});

  LeaveReportOther.fromJson(Map<String, dynamic> json) {
    if (json['others'] != null) {
      others = <Others>[];
      json['others'].forEach((v) {
        others!.add(new Others.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.others != null) {
      data['others'] = this.others!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Others {
  int? id;
  String? startDate;
  String? endDate;
  String? reason;
  int? leaveTypeId;
  int? leaveStatusId;
  int? createdBy;
  String? createdOn;
  String? createdAt;
  String? modifiedOn;
  int? modifiedBy;
  String? modifiedAt;
  String? numberOfDays;
  int? assignedTo;
  bool? pending;
  int? cancellationStatusId;
  String? cancellationRequestedOn;
  int? cancellationRequestedBy;
  String? cancellationRequestedAt;
  String? createdByDesignation;
  String? modifiedByDesignation;
  int? userId;
  String? uid;
  String? leaveTypeName;
  String? createdByName;
  String? modifiedByName;
  String? assignedToName;

  Others(
      {this.id,
      this.startDate,
      this.endDate,
      this.reason,
      this.leaveTypeId,
      this.leaveStatusId,
      this.createdBy,
      this.createdOn,
      this.createdAt,
      this.modifiedOn,
      this.modifiedBy,
      this.modifiedAt,
      this.numberOfDays,
      this.assignedTo,
      this.pending,
      this.cancellationStatusId,
      this.cancellationRequestedOn,
      this.cancellationRequestedBy,
      this.cancellationRequestedAt,
      this.createdByDesignation,
      this.modifiedByDesignation,
      this.userId,
      this.uid,
      this.leaveTypeName,
      this.createdByName,
      this.modifiedByName,
      this.assignedToName});

  Others.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['reason'] = this.reason;
    data['leaveTypeId'] = this.leaveTypeId;
    data['leaveStatusId'] = this.leaveStatusId;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['createdAt'] = this.createdAt;
    data['modifiedOn'] = this.modifiedOn;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    data['numberOfDays'] = this.numberOfDays;
    data['assignedTo'] = this.assignedTo;
    data['pending'] = this.pending;
    data['cancellationStatusId'] = this.cancellationStatusId;
    data['cancellationRequestedOn'] = this.cancellationRequestedOn;
    data['cancellationRequestedBy'] = this.cancellationRequestedBy;
    data['cancellationRequestedAt'] = this.cancellationRequestedAt;
    data['createdByDesignation'] = this.createdByDesignation;
    data['modifiedByDesignation'] = this.modifiedByDesignation;
    data['userId'] = this.userId;
    data['uid'] = this.uid;
    data['leaveTypeName'] = this.leaveTypeName;
    data['createdByName'] = this.createdByName;
    data['modifiedByName'] = this.modifiedByName;
    data['assignedToName'] = this.assignedToName;
    return data;
  }
}
