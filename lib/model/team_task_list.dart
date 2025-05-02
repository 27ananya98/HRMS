class TeamTaskList {
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  TeamTaskList({this.status, this.result, this.error, this.version});

  TeamTaskList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];  // Initialize an empty list
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));  // Add each item to the list
      });
    }
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['version'] = version;
    return data;
  }
}

class Result {
  int? id;
  int? userid;
  int? assignedTo;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? modifiedAt;
  int? createdBy;
  int? modifiedBy;
  String? orgId;
  String? name;
  Result({
    this.id,
    this.userid,
    this.assignedTo,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.modifiedBy,
    this.orgId,
    this.name
  });

  Result.fromJson(Map<String, dynamic> json) {
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
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['assigned_to'] = assignedTo;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['created_by'] = createdBy;
    data['modified_by'] = modifiedBy;
    data['org_id'] = orgId;
    data['name'] = name;
    return data;
  }
}
