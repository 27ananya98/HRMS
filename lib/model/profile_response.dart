class ProfileResponse {
  ProfileResponse({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  ProfileResponse.fromJson(Map<String, dynamic> json){
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
    required this.authDetail,
    required this.addressDetail,
    required this.bankDetail,
    required this.basicDetail,
    required this.deviceDetail,
    required this.documentDetail,
    required this.educationDetail,
    required this.experienceDetail,
    required this.familyDetail,
    required this.taxDetail,
    required this.leaveBalanceDetail,
    required this.salaryDetail,
    required this.workDetail,
    required this.teamDetail,
    required this.members,
    required this.assetsDetail,
  });
  late final AuthDetail? authDetail;
  late final List<AddressDetail>? addressDetail;
  late final BankDetail? bankDetail;
  late final BasicDetail? basicDetail;
  late final List<DeviceDetail>? deviceDetail;
  late final List<DocumentDetail>? documentDetail;
  late final List<EducationDetail>? educationDetail;
  late final List<ExperienceDetail>? experienceDetail;
  late final List<FamilyDetail>? familyDetail;
  late final String? taxDetail;
  late final List<LeaveBalanceDetail>? leaveBalanceDetail;
  late final List<dynamic>? salaryDetail;
  late final WorkDetail? workDetail;
  late final List<dynamic>? teamDetail;
  late final List<dynamic>? members;
  late final List<dynamic>? assetsDetail;

  Result.fromJson(Map<String, dynamic> json){
    authDetail = AuthDetail.fromJson(json['authDetail']);
    addressDetail = List.from(json['addressDetail']).map((e)=>AddressDetail.fromJson(e)).toList();
    bankDetail = BankDetail.fromJson(json['bankDetail']);
    basicDetail = BasicDetail.fromJson(json['basicDetail']);
    deviceDetail = List.from(json['deviceDetail']).map((e)=>DeviceDetail.fromJson(e)).toList();
    documentDetail = List.from(json['documentDetail']).map((e)=>DocumentDetail.fromJson(e)).toList();
    educationDetail = List.from(json['educationDetail']).map((e)=>EducationDetail.fromJson(e)).toList();
    experienceDetail = List.from(json['experienceDetail']).map((e)=>ExperienceDetail.fromJson(e)).toList();
    familyDetail = List.from(json['familyDetail']).map((e)=>FamilyDetail.fromJson(e)).toList();
    taxDetail = null;
    leaveBalanceDetail = List.from(json['leaveBalanceDetail']).map((e)=>LeaveBalanceDetail.fromJson(e)).toList();
    salaryDetail = List.castFrom<dynamic, dynamic>(json['salaryDetail']);
    workDetail = WorkDetail.fromJson(json['workDetail']);
    teamDetail = List.castFrom<dynamic, dynamic>(json['teamDetail']);
    members = List.castFrom<dynamic, dynamic>(json['members']);
    assetsDetail = List.castFrom<dynamic, dynamic>(json['assetsDetail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['authDetail'] = authDetail!.toJson();
    _data['addressDetail'] = addressDetail!.map((e)=>e.toJson()).toList();
    _data['bankDetail'] = bankDetail!.toJson();
    _data['basicDetail'] = basicDetail!.toJson();
    _data['deviceDetail'] = deviceDetail!.map((e)=>e.toJson()).toList();
    _data['documentDetail'] = documentDetail!.map((e)=>e.toJson()).toList();
    _data['educationDetail'] = educationDetail!.map((e)=>e.toJson()).toList();
    _data['experienceDetail'] = experienceDetail!.map((e)=>e.toJson()).toList();
    _data['familyDetail'] = familyDetail!.map((e)=>e.toJson()).toList();
    _data['taxDetail'] = taxDetail;
    _data['leaveBalanceDetail'] = leaveBalanceDetail!.map((e)=>e.toJson()).toList();
    _data['salaryDetail'] = salaryDetail;
    _data['workDetail'] = workDetail!.toJson();
    _data['teamDetail'] = teamDetail;
    _data['members'] = members;
    _data['assetsDetail'] = assetsDetail;
    return _data;
  }
}

class AuthDetail {
  AuthDetail({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.loginStatusId,
    required this.isOnboard,
    required this.roleId,
    required this.roleName,
  });
  late final int? id;
  late final String? name;
  late final String? email;
  late final String? mobile;
  late final int? loginStatusId;
  late final bool? isOnboard;
  late final int? roleId;
  late final String? roleName;

  AuthDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    loginStatusId = json['loginStatusId'];
    isOnboard = json['isOnboard'];
    roleId = json['roleId'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['loginStatusId'] = loginStatusId;
    _data['isOnboard'] = isOnboard;
    _data['roleId'] = roleId;
    _data['roleName'] = roleName;
    return _data;
  }
}

class AddressDetail {
  AddressDetail({
    required this.userId,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.pinCode,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isPermanent,
    required this.id,
    required this.isDelete,
  });
  late final int? userId;
  late final String? country;
  late final String? state;
  late final String? city;
  late final String? address;
  late final String? pinCode;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final bool? isPermanent;
  late final int? id;
  late final String? isDelete;

  AddressDetail.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    pinCode = json['pinCode'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isPermanent = json['isPermanent'];
    id = json['id'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['country'] = country;
    _data['state'] = state;
    _data['city'] = city;
    _data['address'] = address;
    _data['pinCode'] = pinCode;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isPermanent'] = isPermanent;
    _data['id'] = id;
    _data['isDelete'] = isDelete;
    return _data;
  }
}

class BankDetail {
  BankDetail({
    required this.userId,
    required this.accountNumber,
    required this.accountType,
    required this.bankName,
    required this.branchName,
    required this.branchCode,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isDelete,
  });
  late final int? userId;
  late final String? accountNumber;
  late final String? accountType;
  late final String? bankName;
  late final String? branchName;
  late final String? branchCode;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? isDelete;

  BankDetail.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    branchCode = json['branchCode'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['accountNumber'] = accountNumber;
    _data['accountType'] = accountType;
    _data['bankName'] = bankName;
    _data['branchName'] = branchName;
    _data['branchCode'] = branchCode;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isDelete'] = isDelete;
    return _data;
  }
}

class BasicDetail {
  BasicDetail({
    required this.userId,
    required this.genderId,
    required this.gender,
    required this.fatherName,
    required this.motherName,
    required this.nationality,
    required this.dateOfBirth,
    required this.maritalStatusId,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.profilePicture,
    required this.personalEmail,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
  });
  late final int? userId;
  late final int? genderId;
  late final String? gender;
  late final String? fatherName;
  late final String? motherName;
  late final String? nationality;
  late final String? dateOfBirth;
  late final int? maritalStatusId;
  late final String? maritalStatus;
  late final String? bloodGroup;
  late final String? profilePicture;
  late final String? personalEmail;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;

  BasicDetail.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    genderId = json['genderId'];
    gender = json['gender'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    nationality = json['nationality'];
    dateOfBirth = json['dateOfBirth'];
    maritalStatusId = json['maritalStatusId'];
    maritalStatus = json['maritalStatus'];
    bloodGroup = json['bloodGroup'];
    profilePicture = json['profilePicture'];
    personalEmail = json['personalEmail'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['genderId'] = genderId;
    _data['gender'] = gender;
    _data['fatherName'] = fatherName;
    _data['motherName'] = motherName;
    _data['nationality'] = nationality;
    _data['dateOfBirth'] = dateOfBirth;
    _data['maritalStatusId'] = maritalStatusId;
    _data['maritalStatus'] = maritalStatus;
    _data['bloodGroup'] = bloodGroup;
    _data['profilePicture'] = profilePicture;
    _data['personalEmail'] = personalEmail;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    return _data;
  }
}

class DeviceDetail {
  DeviceDetail({
    required this.id,
    required this.deviceId,
    required this.os,
    required this.model,
    required this.fcmToken,
    required this.userId,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.modifiedAt,
    required this.isDelete,
  });
  late final int? id;
  late final String? deviceId;
  late final String? os;
  late final String? model;
  late final String? fcmToken;
  late final int? userId;
  late final String? modifiedBy;
  late final String? modifiedOn;
  late final String? modifiedAt;
  late final String? isDelete;

  DeviceDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    deviceId = json['deviceId'];
    os = json['os'];
    model = json['model'];
    fcmToken = json['fcmToken'];
    userId = json['userId'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    modifiedAt = json['modifiedAt'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['deviceId'] = deviceId;
    _data['os'] = os;
    _data['model'] = model;
    _data['fcmToken'] = fcmToken;
    _data['userId'] = userId;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedAt'] = modifiedAt;
    _data['isDelete'] = isDelete;
    return _data;
  }
}

class DocumentDetail {
  DocumentDetail({
    required this.id,
    required this.userId,
    required this.documentNumber,
    required this.documentTypeId,
    required this.fileName,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isDelete,
    required this.documentTypeName,
  });
  late final int? id;
  late final int? userId;
  late final String? documentNumber;
  late final int? documentTypeId;
  late final String? fileName;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? isDelete;
  late final String? documentTypeName;

  DocumentDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    documentNumber = json['documentNumber'];
    documentTypeId = json['documentTypeId'];
    fileName = json['fileName'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isDelete = json['isDelete'];
    documentTypeName = json['documentTypeName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['documentNumber'] = documentNumber;
    _data['documentTypeId'] = documentTypeId;
    _data['fileName'] = fileName;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isDelete'] = isDelete;
    _data['documentTypeName'] = documentTypeName;
    return _data;
  }
}

class EducationDetail {
  EducationDetail({
    required this.id,
    required this.userId,
    required this.course,
    required this.institute,
    required this.startYear,
    required this.endYear,
    required this.marks,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isDelete,
  });
  late final int? id;
  late final int? userId;
  late final String? course;
  late final String? institute;
  late final int? startYear;
  late final int? endYear;
  late final String? marks;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? isDelete;

  EducationDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    course = json['course'];
    institute = json['institute'];
    startYear = json['startYear'];
    endYear = json['endYear'];
    marks = json['marks'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['course'] = course;
    _data['institute'] = institute;
    _data['startYear'] = startYear;
    _data['endYear'] = endYear;
    _data['marks'] = marks;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isDelete'] = isDelete;
    return _data;
  }
}

class ExperienceDetail {
  ExperienceDetail({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.jobProfile,
    required this.from,
    required this.to,
    required this.remarks,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isDelete,
  });
  late final int? id;
  late final int? userId;
  late final String? companyName;
  late final String? jobProfile;
  late final String? from;
  late final String? to;
  late final String? remarks;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? isDelete;

  ExperienceDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    companyName = json['companyName'];
    jobProfile = json['jobProfile'];
    from = json['from'];
    to = json['to'];
    remarks = json['remarks'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['companyName'] = companyName;
    _data['jobProfile'] = jobProfile;
    _data['from'] = from;
    _data['to'] = to;
    _data['remarks'] = remarks;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isDelete'] = isDelete;
    return _data;
  }
}

class FamilyDetail {
  FamilyDetail({
    required this.id,
    required this.userId,
    required this.name,
    required this.relationship,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.isDependant,
    required this.isEmergencyContact,
    required this.address,
    required this.email,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isDelete,
  });
  late final int? id;
  late final int? userId;
  late final String? name;
  late final String? relationship;
  late final String? dateOfBirth;
  late final String? contactNumber;
  late final bool? isDependant;
  late final bool? isEmergencyContact;
  late final String? address;
  late final String? email;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? isDelete;

  FamilyDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    relationship = json['relationship'];
    dateOfBirth = json['dateOfBirth'];
    contactNumber = json['contactNumber'];
    isDependant = json['isDependant'];
    isEmergencyContact = json['isEmergencyContact'];
    address = json['address'];
    email = json['email'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['name'] = name;
    _data['relationship'] = relationship;
    _data['dateOfBirth'] = dateOfBirth;
    _data['contactNumber'] = contactNumber;
    _data['isDependant'] = isDependant;
    _data['isEmergencyContact'] = isEmergencyContact;
    _data['address'] = address;
    _data['email'] = email;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isDelete'] = isDelete;
    return _data;
  }
}

class LeaveBalanceDetail {
  LeaveBalanceDetail({
    required this.id,
    required this.leaveTypeId,
    required this.used,
    required this.userId,
    required this.year,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.total,
    required this.balance,
    required this.pending,
    required this.name,
  });
  late final int? id;
  late final int? leaveTypeId;
  late final String? used;
  late final int? userId;
  late final String? year;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? total;
  late final String? balance;
  late final String? pending;
  late final String? name;

  LeaveBalanceDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    leaveTypeId = json['leaveTypeId'];
    used = json['used'];
    userId = json['userId'];
    year = json['year'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    total = json['total'];
    balance = json['balance'];
    pending = json['pending'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['leaveTypeId'] = leaveTypeId;
    _data['used'] = used;
    _data['userId'] = userId;
    _data['year'] = year;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['total'] = total;
    _data['balance'] = balance;
    _data['pending'] = pending;
    _data['name'] = name;
    return _data;
  }
}

class WorkDetail {
  WorkDetail({
    required this.employmentTypeId,
    required this.employmentTypeName,
    required this.designationId,
    required this.reportingManagerId,
    required this.reportingManagerName,
    required this.designation,
    required this.userId,
    required this.employeeId,
    required this.departmentId,
    required this.department,
    required this.workLocationId,
    required this.workLocation,
    required this.dateOfJoining,
    required this.dateOfConfirmation,
    required this.dateOfExit,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.costCenterId,
    required this.noticePeriod,
    required this.probationPeriod,
    required this.personalEmail,
    required this.noticePeriodTime,
    required this.probationPeriodTime,
    required this.costCenterName,
  });
  late final int? employmentTypeId;
  late final String? employmentTypeName;
  late final int? designationId;
  late final int? reportingManagerId;
  late final String? reportingManagerName;
  late final String? designation;
  late final int? userId;
  late final String? employeeId;
  late final int? departmentId;
  late final String? department;
  late final int? workLocationId;
  late final String? workLocation;
  late final String? dateOfJoining;
  late final String? dateOfConfirmation;
  late final String? dateOfExit;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final int? costCenterId;
  late final String? noticePeriod;
  late final String? probationPeriod;
  late final String? personalEmail;
  late final String? noticePeriodTime;
  late final String? probationPeriodTime;
  late final String? costCenterName;

  WorkDetail.fromJson(Map<String, dynamic> json){
    employmentTypeId = json['employmentTypeId'];
    employmentTypeName = json['employmentTypeName'];
    designationId = json['designationId'];
    reportingManagerId = json['reportingManagerId'];
    reportingManagerName = json['reportingManagerName'];
    designation = json['designation'];
    userId = json['userId'];
    employeeId = json['employeeId'];
    departmentId = json['departmentId'];
    department = json['department'];
    workLocationId = json['workLocationId'];
    workLocation = json['workLocation'];
    dateOfJoining = json['dateOfJoining'];
    dateOfConfirmation = json['dateOfConfirmation'];
    dateOfExit = json['dateOfExit'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    costCenterId = json['costCenterId'];
    noticePeriod = json['noticePeriod'];
    probationPeriod = json['probationPeriod'];
    personalEmail = json['personalEmail'];
    noticePeriodTime = json['noticePeriodTime'];
    probationPeriodTime = json['probationPeriodTime'];
    costCenterName = json['costCenterName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employmentTypeId'] = employmentTypeId;
    _data['employmentTypeName'] = employmentTypeName;
    _data['designationId'] = designationId;
    _data['reportingManagerId'] = reportingManagerId;
    _data['reportingManagerName'] = reportingManagerName;
    _data['designation'] = designation;
    _data['userId'] = userId;
    _data['employeeId'] = employeeId;
    _data['departmentId'] = departmentId;
    _data['department'] = department;
    _data['workLocationId'] = workLocationId;
    _data['workLocation'] = workLocation;
    _data['dateOfJoining'] = dateOfJoining;
    _data['dateOfConfirmation'] = dateOfConfirmation;
    _data['dateOfExit'] = dateOfExit;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['costCenterId'] = costCenterId;
    _data['noticePeriod'] = noticePeriod;
    _data['probationPeriod'] = probationPeriod;
    _data['personalEmail'] = personalEmail;
    _data['noticePeriodTime'] = noticePeriodTime;
    _data['probationPeriodTime'] = probationPeriodTime;
    _data['costCenterName'] = costCenterName;
    return _data;
  }
}