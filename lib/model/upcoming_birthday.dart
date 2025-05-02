class UpcomingBirthday {
  UpcomingBirthday({
     this.status,
     this.result,
     this.error,
     this.version,
  });

  late final bool? status;
  late final List<Result>? result;
  late final String? error;
  late final String? version;

  UpcomingBirthday.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json.containsKey('result') && json['result'] != null) {
      result =
          List.from(json['result']).map((e) => Result.fromJson(e)).toList();
    } else {
      result = null;
    }
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    if (result != null) {
      _data['result'] = result!.map((e) => e.toJson()).toList();
    }
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.name,
    required this.userId,
    required this.dateOfBirth,
    this.profilePicture,
    required this.day,
    required this.department,
    this.designation,
  });

  late final String? name;
  late final int? userId;
  late final String? dateOfBirth;
  late final String? profilePicture;
  late final int? day;
  late final String? department;
  late final String? designation;

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['userId'];
    dateOfBirth = json['dateOfBirth'];
    profilePicture = json['profilePicture'];
    day = json['day'];
    department = json['department'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['userId'] = userId;
    _data['dateOfBirth'] = dateOfBirth;
    _data['profilePicture'] = profilePicture;
    _data['day'] = day;
    _data['department'] = department;
    _data['designation'] = designation;
    return _data;
  }
}
