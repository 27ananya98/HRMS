class SalarySlipModel {
  bool? status;
  Result? result;
  String? error;
  String? version;

  SalarySlipModel({this.status, this.result, this.error, this.version});

  SalarySlipModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  ProfileDetail? profileDetail;
  List<SalaryList>? salaryList;

  Result({this.profileDetail, this.salaryList});

  Result.fromJson(Map<String, dynamic> json) {
    profileDetail = json['profileDetail'] != null
        ? new ProfileDetail.fromJson(json['profileDetail'])
        : null;
    if (json['salaryList'] != null) {
      salaryList = <SalaryList>[];
      json['salaryList'].forEach((v) {
        salaryList!.add(new SalaryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileDetail != null) {
      data['profileDetail'] = this.profileDetail!.toJson();
    }
    if (this.salaryList != null) {
      data['salaryList'] = this.salaryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileDetail {
  String? name;
  String? dateOfJoining;
  String? mobile;
  String? employeeId;
  String? designationName;
  int? designationId;
  int? id;
  String? payrollStartDate;
  String? payrollEndDate;
  bool? isProcessed;
  int? userId;
  int? monthlyGross;
  int? earnedGross;
  String? ctc;
  String? ctcEarned;
  String? deduction;
  String? deducted;
  String? paidDays;
  String? totalWorkingDays;
  int? createdBy;
  String? createdOn;
  String? createdAt;
  String? orgName;
  String? addressLine1;
  String? addressLine2;
  String? city;
  int? pinCode;

  ProfileDetail(
      {required this.name,
        required this.dateOfJoining,
        required this.mobile,
        required this.employeeId,
        required this.designationName,
        required this.designationId,
        required this.id,
        required this.payrollStartDate,
        required this.payrollEndDate,
        required this.isProcessed,
        required this.userId,
        required this.monthlyGross,
        required this.earnedGross,
        required this.ctc,
        required this.ctcEarned,
        required this.deduction,
        required this.deducted,
        required this.paidDays,
        required this.totalWorkingDays,
        required this.createdBy,
        required this.createdOn,
        required this.createdAt,
        required this.orgName,
        required this.addressLine1,
        required this.addressLine2,
        required this.city,
        required this.pinCode});

  ProfileDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfJoining = json['dateOfJoining'];
    mobile = json['mobile'];
    employeeId = json['employeeId'];
    designationName = json['designationName'];
    designationId = json['designationId'];
    id = json['id'];
    payrollStartDate = json['payrollStartDate'];
    payrollEndDate = json['payrollEndDate'];
    isProcessed = json['isProcessed'];
    userId = json['userId'];
    monthlyGross = json['monthlyGross'];
    earnedGross = json['earnedGross'];
    ctc = json['ctc'];
    ctcEarned = json['ctcEarned'];
    deduction = json['deduction'];
    deducted = json['deducted'];
    paidDays = json['paidDays'];
    totalWorkingDays = json['totalWorkingDays'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    orgName = json['org_name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    pinCode = json['pin_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateOfJoining'] = this.dateOfJoining;
    data['mobile'] = this.mobile;
    data['employeeId'] = this.employeeId;
    data['designationName'] = this.designationName;
    data['designationId'] = this.designationId;
    data['id'] = this.id;
    data['payrollStartDate'] = this.payrollStartDate;
    data['payrollEndDate'] = this.payrollEndDate;
    data['isProcessed'] = this.isProcessed;
    data['userId'] = this.userId;
    data['monthlyGross'] = this.monthlyGross;
    data['earnedGross'] = this.earnedGross;
    data['ctc'] = this.ctc;
    data['ctcEarned'] = this.ctcEarned;
    data['deduction'] = this.deduction;
    data['deducted'] = this.deducted;
    data['paidDays'] = this.paidDays;
    data['totalWorkingDays'] = this.totalWorkingDays;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['createdAt'] = this.createdAt;
    data['org_name'] = this.orgName;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    return data;
  }
}

class SalaryList {
  int? id;
  int? componentId;
  String? value;
  String? earned;
  int? salaryDataId;
  int? operationType;
  String? name;
  int? componentType;

  SalaryList(
      { required this.id,
        required this.componentId,
        required this.value,
        required this.earned,
        required this.salaryDataId,
        required this.operationType,
        required this.name,
        required this.componentType});

  SalaryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    componentId = json['componentId'];
    value = json['value'];
    earned = json['earned'];
    salaryDataId = json['salaryDataId'];
    operationType = json['operationType'];
    name = json['name'];
    componentType = json['componentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['componentId'] = this.componentId;
    data['value'] = this.value;
    data['earned'] = this.earned;
    data['salaryDataId'] = this.salaryDataId;
    data['operationType'] = this.operationType;
    data['name'] = this.name;
    data['componentType'] = this.componentType;
    return data;
  }
}
