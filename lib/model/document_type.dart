class DocumentType {
  DocumentType({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });

  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  DocumentType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null
        ? List.from(json['result']).map((e) => Result.fromJson(e)).toList()
        : null;
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    if (result != null) {
      _data['result'] = result!.map((v) => v.toJson()).toList();
    }
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
     this.id,
     this.name,
     this.isMandatory,
     this.modifiedOn,
     this.modifiedBy,
     this.modifiedAt,
     this.isCompanyDocument,
     this.available,
     this.orgId,
     this.modifiedByName,
  });

  late final int? id;
  late final String? name;
  late final bool? isMandatory;
  late final String? modifiedOn;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final bool? isCompanyDocument;
  late final bool? available;
  late final String? orgId;
  late final String? modifiedByName;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isMandatory = json['isMandatory'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    isCompanyDocument = json['isCompanyDocument'];
    available = json['available'];
    orgId = json['org_id'];
    modifiedByName = json['modifiedByName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['isMandatory'] = isMandatory;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['isCompanyDocument'] = isCompanyDocument;
    _data['available'] = available;
    _data['org_id'] = orgId;
    _data['modifiedByName'] = modifiedByName;
    return _data;
  }
}
