class ApprovalTypes {
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  ApprovalTypes({this.status, this.result, this.error, this.version});

  ApprovalTypes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['version'] = this.version;
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? description;
  int? createdBy;
  String? createdOn;
  String? createdAt;
  int? modifiedBy;
  String? modifiedOn;
  String? modifiedAt;
  bool? isAccrued;
  String? accrualFrequencyInDays;
  bool? isQuotaBased;
  bool? isApprovalBased;
  String? yearlyQuota;
  bool? available;
  String? featured;
  bool? isEncashed;
  String? orgId;

  Result(
      {this.id,
      this.name,
      this.description,
      this.createdBy,
      this.createdOn,
      this.createdAt,
      this.modifiedBy,
      this.modifiedOn,
      this.modifiedAt,
      this.isAccrued,
      this.accrualFrequencyInDays,
      this.isQuotaBased,
      this.isApprovalBased,
      this.yearlyQuota,
      this.available,
      this.featured,
      this.isEncashed,
      this.orgId});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    modifiedAt = json['modifiedAt'];
    isAccrued = json['isAccrued'];
    accrualFrequencyInDays = json['accrualFrequencyInDays'];
    isQuotaBased = json['isQuotaBased'];
    isApprovalBased = json['isApprovalBased'];
    yearlyQuota = json['yearlyQuota'];
    available = json['available'];
    featured = json['featured'];
    isEncashed = json['isEncashed'];
    orgId = json['org_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['modifiedAt'] = this.modifiedAt;
    data['isAccrued'] = this.isAccrued;
    data['accrualFrequencyInDays'] = this.accrualFrequencyInDays;
    data['isQuotaBased'] = this.isQuotaBased;
    data['isApprovalBased'] = this.isApprovalBased;
    data['yearlyQuota'] = this.yearlyQuota;
    data['available'] = this.available;
    data['featured'] = this.featured;
    data['isEncashed'] = this.isEncashed;
    data['org_id'] = this.orgId;
    return data;
  }
}
