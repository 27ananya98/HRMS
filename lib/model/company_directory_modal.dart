class CompanyDirectoryModal {
  bool? status;
  Result? result;
  String? error;
  String? version;

  CompanyDirectoryModal({this.status, this.result, this.error, this.version});

  CompanyDirectoryModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['error'] = this.error;
    data['version'] = this.version;
    return data;
  }
}

class Result {
  List<AllEmpList>? list;
  int? count;

  Result({this.list, this.count});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <AllEmpList>[];
      json['list'].forEach((v) {
        list!.add(new AllEmpList.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class AllEmpList {
  int? id;
  String? name;
  String? email;
  String? mobile;
  bool? isOnboard;
  int? loginStatusId;
  bool? isSystemUser;
  String? employeeId;
  String? dateOfExit;
  String? workLocation;
  String? designation;
  String? department;
  String? profilePicture;
  String? loginStatusName;
  String? reportingManager;

  AllEmpList(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.isOnboard,
      this.loginStatusId,
      this.isSystemUser,
      this.employeeId,
      this.dateOfExit,
      this.workLocation,
      this.designation,
      this.department,
      this.profilePicture,
      this.loginStatusName,
      this.reportingManager});

  AllEmpList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    isOnboard = json['isOnboard'];
    loginStatusId = json['loginStatusId'];
    isSystemUser = json['isSystemUser'];
    employeeId = json['employeeId'];
    dateOfExit = json['dateOfExit'];
    workLocation = json['workLocation'];
    designation = json['designation'];
    department = json['department'];
    profilePicture = json['profilePicture'];
    loginStatusName = json['loginStatusName'];
    reportingManager = json['reportingManager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['isOnboard'] = this.isOnboard;
    data['loginStatusId'] = this.loginStatusId;
    data['isSystemUser'] = this.isSystemUser;
    data['employeeId'] = this.employeeId;
    data['dateOfExit'] = this.dateOfExit;
    data['workLocation'] = this.workLocation;
    data['designation'] = this.designation;
    data['department'] = this.department;
    data['profilePicture'] = this.profilePicture;
    data['loginStatusName'] = this.loginStatusName;
    data['reportingManager'] = this.reportingManager;
    return data;
  }
}
