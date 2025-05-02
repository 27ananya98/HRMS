class AnnouncementModal {
  AnnouncementModal({
    required this.status,
    required this.result,
    this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  AnnouncementModal.fromJson(Map<String, dynamic> json){
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
    required this.detail,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.modifiedAt,
    required this.available,
    required this.notifiedOn,
    required this.orgId,
    required this.userId,
    required this.userName,
    this.profilePicture,
  });
  late final int? id;
  late final String? detail;
  late final int? modifiedBy;
  late final String? modifiedOn;
  late final String? modifiedAt;
  late final bool? available;
  late final String? notifiedOn;
  late final String? orgId;
  late final int? userId;
  late final String userName;
  late final String? profilePicture;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    detail = json['detail'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    modifiedAt = json['modifiedAt'];
    available = json['available'];
    notifiedOn = json['notifiedOn'];
    orgId = json['org_id'];
    userId = json['userId'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['detail'] = detail;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedAt'] = modifiedAt;
    _data['available'] = available;
    _data['notifiedOn'] = notifiedOn;
    _data['org_id'] = orgId;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['profilePicture'] = profilePicture;
    return _data;
  }
}