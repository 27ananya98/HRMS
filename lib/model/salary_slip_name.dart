class SalarySlipName {
  SalarySlipName({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  SalarySlipName.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
    error = null;
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
    required this.fileName,
    required this.originalFileName,
    required this.createdOn,
    required this.createdBy,
    this.createdAt,
    this.modifiedOn,
    required this.modifiedBy,
    this.modifiedAt,
    required this.employeeId,
  });
  late final int id;
  late final String fileName;
  late final String originalFileName;
  late final String createdOn;
  late final int createdBy;
  late final Null createdAt;
  late final Null modifiedOn;
  late final int modifiedBy;
  late final Null modifiedAt;
  late final String employeeId;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fileName = json['file_name'];
    originalFileName = json['original_file_name'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    createdAt = null;
    modifiedOn = null;
    modifiedBy = json['modifiedBy'];
    modifiedAt = null;
    employeeId = json['employee_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['file_name'] = fileName;
    _data['original_file_name'] = originalFileName;
    _data['createdOn'] = createdOn;
    _data['createdBy'] = createdBy;
    _data['createdAt'] = createdAt;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['employee_id'] = employeeId;
    return _data;
  }
}