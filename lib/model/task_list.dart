class TaskList {
  TaskList({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  TaskList.fromJson(Map<String, dynamic> json){
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
    required this.userid,
    required this.assignedTo,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.orgId,
  });
  late final int? id;
  late final int? userid;
  late final int? assignedTo;
  late final String? title;
  late final String? description;
  late final String? status;
  late final String? createdAt;
  late final String? modifiedAt;
  late final int? createdBy;
  late final int? modifiedBy;
  late final String? orgId;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userid = json['userid'];
    assignedTo = json['assigned_to'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    orgId = json['org_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userid'] = userid;
    _data['assigned_to'] = assignedTo;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['modified_at'] = modifiedAt;
    _data['created_by'] = createdBy;
    _data['modified_by'] = modifiedBy;
    _data['org_id'] = orgId;
    return _data;
  }
}