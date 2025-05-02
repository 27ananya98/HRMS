class AddDailyTaskModel {
  AddDailyTaskModel({
    required this.status,
    required this.result,    // Result can be nullable
    required this.error,
    required this.version,
  });

  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  AddDailyTaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null; // Handle null case
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    if (result != null) {
      _data['result'] = result!.toJson();  // Only call toJson if result is not null
    }
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.userid,
    required this.managerId,
    required this.managerName,
    required this.title,
    required this.description,
    required this.status,
  });

  late final int? id;
  late final int? userid;
  late final int? managerId;
  late final String? managerName;
  late final String? title;
  late final String? description;
  late final String? status;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    managerId = json['manager_id'];
    managerName = json['manager_name'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userid'] = userid;
    _data['manager_id'] = managerId;
    _data['manager_name'] = managerName;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    return _data;
  }
}
