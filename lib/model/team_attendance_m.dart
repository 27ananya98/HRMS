class TeamAttendanceReport {
  bool? status;
  Result? result;
  String? error;
  String? version;

  TeamAttendanceReport({this.status, this.result, this.error, this.version});

  TeamAttendanceReport.fromJson(Map<String, dynamic> json) {
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
  List<Team>? team;
  List<Attendance>? attendance;
  List<Leaves>? leaves;

  Result({this.team, this.attendance, this.leaves});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['team'] != null) {
      team = <Team>[];
      json['team'].forEach((v) {
        team!.add(new Team.fromJson(v));
      });
    }
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
    if (json['leaves'] != null) {
      leaves = <Leaves>[];
      json['leaves'].forEach((v) {
        leaves!.add(new Leaves.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.team != null) {
      data['team'] = this.team!.map((v) => v.toJson()).toList();
    }
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    if (this.leaves != null) {
      data['leaves'] = this.leaves!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  String? name;
  int? userId;
  String? employeeId;
  int? departmentId;
  String? profilePicture;
  String? departmentName;
  String? designationName;

  Team(
      {this.name,
        this.userId,
        this.employeeId,
        this.departmentId,
        this.profilePicture,
        this.departmentName,
        this.designationName});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['userId'];
    employeeId = json['employeeId'];
    departmentId = json['departmentId'];
    profilePicture = json['profilePicture'];
    departmentName = json['departmentName'];
    designationName = json['designationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['employeeId'] = this.employeeId;
    data['departmentId'] = this.departmentId;
    data['profilePicture'] = this.profilePicture;
    data['departmentName'] = this.departmentName;
    data['designationName'] = this.designationName;
    return data;
  }
}

class Attendance {
  int? id;
  String? source;
  String? ip;
  String? lat;
  String? lng;
  String? remark;
  int? userId;
  String? deviceId;
  int? attendanceTypeId;
  String? inTime;
  String? outTime;
  int? arDetailId;
  bool? available;
  int? shiftId;
  int? otDetailId;
  String? uid;
  String? otHours;
  int? attendanceStatusId;
  String? ipOutTime;
  String? latOutTime;
  String? lngOutTime;
  String? deviceIdOutTime;
  String? sourceOutTime;
  bool? checkInSelfie;
  bool? checkOutSelfie;
  String? attendanceTypeName;
  int? inTimeDay;
  num? inTimeUnix;
  num? outTimeUnix;

  Attendance(
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
        this.ipOutTime,
        this.latOutTime,
        this.lngOutTime,
        this.deviceIdOutTime,
        this.sourceOutTime,
        this.checkInSelfie,
        this.checkOutSelfie,
        this.attendanceTypeName,
        this.inTimeDay,
        this.inTimeUnix,
        this.outTimeUnix});

  Attendance.fromJson(Map<String, dynamic> json) {
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
    ipOutTime = json['ip_outTime'];
    latOutTime = json['lat_outTime'];
    lngOutTime = json['lng_outTime'];
    deviceIdOutTime = json['deviceId_outTime'];
    sourceOutTime = json['source_outTime'];
    checkInSelfie = json['checkInSelfie'];
    checkOutSelfie = json['checkOutSelfie'];
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
    data['ip_outTime'] = this.ipOutTime;
    data['lat_outTime'] = this.latOutTime;
    data['lng_outTime'] = this.lngOutTime;
    data['deviceId_outTime'] = this.deviceIdOutTime;
    data['source_outTime'] = this.sourceOutTime;
    data['checkInSelfie'] = this.checkInSelfie;
    data['checkOutSelfie'] = this.checkOutSelfie;
    data['attendanceTypeName'] = this.attendanceTypeName;
    data['inTimeDay'] = this.inTimeDay;
    data['inTimeUnix'] = this.inTimeUnix;
    data['outTimeUnix'] = this.outTimeUnix;
    return data;
  }
}

class Leaves {
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
  String? cancellationRequestedBy;
  String? cancellationRequestedAt;
  String? createdByDesignation;
  String? modifiedByDesignation;
  int? userId;
  String? uid;
  String? leaveTypeName;
  String? createdByName;
  String? modifiedByName;
  String? assignedToName;

  Leaves(
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

  Leaves.fromJson(Map<String, dynamic> json) {
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
