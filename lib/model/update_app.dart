class UpdateApp {
  UpdateApp({
    required this.status,
    required this.result,
    this.error,
    required this.version,
  });
  late final bool status;
  late final Result result;
  late final Null error;
  late final String version;

  UpdateApp.fromJson(Map<String, dynamic> json){
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
    required this.VERSIONID,
    required this.VERSIONCODE,
    required this.APPNAME,
    required this.ISDATACLEARED,
    required this.PUBLISHEDON,
  });
  late final int VERSIONID;
  late final String VERSIONCODE;
  late final String APPNAME;
  late final bool ISDATACLEARED;
  late final String PUBLISHEDON;

  Result.fromJson(Map<String, dynamic> json){
    VERSIONID = json['VERSION_ID'];
    VERSIONCODE = json['VERSION_CODE'];
    APPNAME = json['APP_NAME'];
    ISDATACLEARED = json['IS_DATA_CLEARED'];
    PUBLISHEDON = json['PUBLISHED_ON'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['VERSION_ID'] = VERSIONID;
    _data['VERSION_CODE'] = VERSIONCODE;
    _data['APP_NAME'] = APPNAME;
    _data['IS_DATA_CLEARED'] = ISDATACLEARED;
    _data['PUBLISHED_ON'] = PUBLISHEDON;
    return _data;
  }
}