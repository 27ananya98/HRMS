class FamilyDetails {
  FamilyDetails({
    required this.status,
    required this.result,
    this.error,
    required this.version,
  });
  late final bool status;
  late final List<Result> result;
  late final Null error;
  late final String version;

  FamilyDetails.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
    error = null;
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e)=>e.toJson()).toList();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.userId,
    required this.name,
    this.email,
    required this.relationship,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.isDependant,
    required this.isEmergencyContact,
    this.address,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.modifiedAt,
  });
  late final int id;
  late final int userId;
  late final String name;
  late final String? email;
  late final String relationship;
  late final String dateOfBirth;
  late final String contactNumber;
  late final bool isDependant;
  late final bool isEmergencyContact;
  late final String? address;
  late final String modifiedOn;
  late final int modifiedBy;
  late final String modifiedAt;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    email = null;
    relationship = json['relationship'];
    dateOfBirth = json['dateOfBirth'];
    contactNumber = json['contactNumber'];
    isDependant = json['isDependant'];
    isEmergencyContact = json['isEmergencyContact'];
    address = null;
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['name'] = name;
    _data['email'] = email;
    _data['relationship'] = relationship;
    _data['dateOfBirth'] = dateOfBirth;
    _data['contactNumber'] = contactNumber;
    _data['isDependant'] = isDependant;
    _data['isEmergencyContact'] = isEmergencyContact;
    _data['address'] = address;
    _data['modifiedOn'] = modifiedOn;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    return _data;
  }
}