class CompOffApprovalType {
  CompOffApprovalType({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  CompOffApprovalType.fromJson(Map<String, dynamic> json){
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
    required this.description,
    required this.createdBy,
    required this.createdOn,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.modifiedAt,
    required this.isAccrued,
    required this.accrualFrequencyInDays,
    required this.isQuotaBased,
    required this.isApprovalBased,
    required this.yearlyQuota,
    required this.available,
    required this.featured,
    required this.isEncashed,
    required this.orgId,
  });
  late final int? id;
  late final String? name;
  late final String? description;
  late final int? createdBy;
  late final String? createdOn;
  late final String? createdAt;
  late final int? modifiedBy;
  late final String? modifiedOn;
  late final String? modifiedAt;
  late final bool? isAccrued;
  late final String? accrualFrequencyInDays;
  late final bool? isQuotaBased;
  late final bool? isApprovalBased;
  late final String? yearlyQuota;
  late final bool? available;
  late final String? featured;
  late final bool? isEncashed;
  late final String? orgId;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = null;
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    modifiedAt = json['modifiedAt'];
    isAccrued = json['isAccrued'];
    accrualFrequencyInDays = null;
    isQuotaBased = json['isQuotaBased'];
    isApprovalBased = json['isApprovalBased'];
    yearlyQuota = json['yearlyQuota'];
    available = json['available'];
    featured = json['featured'];
    isEncashed = json['isEncashed'];
    orgId = json['org_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['createdBy'] = createdBy;
    _data['createdOn'] = createdOn;
    _data['createdAt'] = createdAt;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedAt'] = modifiedAt;
    _data['isAccrued'] = isAccrued;
    _data['accrualFrequencyInDays'] = accrualFrequencyInDays;
    _data['isQuotaBased'] = isQuotaBased;
    _data['isApprovalBased'] = isApprovalBased;
    _data['yearlyQuota'] = yearlyQuota;
    _data['available'] = available;
    _data['featured'] = featured;
    _data['isEncashed'] = isEncashed;
    _data['org_id'] = orgId;
    return _data;
  }
}