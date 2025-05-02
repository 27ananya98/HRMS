class EditBasicDetailModel {
  EditBasicDetailModel({
    required this.status,
    required this.result,
    this.error,
    required this.version,
  });
  late final bool status;
  late final Result result;
  late final Null error;
  late final String version;

  EditBasicDetailModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = Result.fromJson(json['result']);
    error = null;
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.toJson();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.userId,
    required this.fatherName,
    required this.motherName,
    required this.nationality,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.profilePicture,
    required this.personalEmail,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.genderId,
    required this.maritalStatusId,
    this.isDelete,
  });
  late final int userId;
  late final String fatherName;
  late final String motherName;
  late final String nationality;
  late final String dateOfBirth;
  late final String bloodGroup;
  late final String profilePicture;
  late final String personalEmail;
  late final String modifiedOn;
  late final int modifiedBy;
  late final String modifiedAt;
  late final int genderId;
  late final int maritalStatusId;
  late final Null isDelete;

  Result.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    nationality = json['nationality'];
    dateOfBirth = json['dateOfBirth'];
    bloodGroup = json['bloodGroup'];
    profilePicture = json['profilePicture'];
    personalEmail = json['personalEmail'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    genderId = json['genderId'];
    maritalStatusId = json['maritalStatusId'];
    isDelete = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['fatherName'] = fatherName;
    _data['motherName'] = motherName;
    _data['nationality'] = nationality;
    _data['dateOfBirth'] = dateOfBirth;
    _data['bloodGroup'] = bloodGroup;
    _data['profilePicture'] = profilePicture;
    _data['personalEmail'] = personalEmail;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['genderId'] = genderId;
    _data['maritalStatusId'] = maritalStatusId;
    _data['isDelete'] = isDelete;
    return _data;
  }
}