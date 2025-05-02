class AssigneTo {
  AssigneTo({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  AssigneTo.fromJson(Map<String, dynamic> json){
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
    required this.name,
    required this.employeeId,
    required this.designation,
    required this.department,
  });
  late final int? id;
  late final String? name;
  late final String? employeeId;
  late final String? designation;
  late final String? department;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    employeeId = json['employeeId'];
    designation = json['designation'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['employeeId'] = employeeId;
    _data['designation'] = designation;
    _data['department'] = department;
    return _data;
  }
}