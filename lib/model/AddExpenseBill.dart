class AddExpenseBill {
  AddExpenseBill({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  AddExpenseBill.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = Result.fromJson(json['result']);
    error = null;
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result?.toJson();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.fileName,
    required this.originalFile,
  });
  late final String? fileName;
  late final String? originalFile;

  Result.fromJson(Map<String, dynamic> json){
    fileName = json['fileName'];
    originalFile = json['originalFile'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fileName'] = fileName;
    _data['originalFile'] = originalFile;
    return _data;
  }
}