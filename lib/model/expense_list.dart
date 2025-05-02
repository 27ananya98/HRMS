class ExpenseList {
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  ExpenseList({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });

  ExpenseList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = Result.fromJson(json['result']);
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result!.toJson();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  late final List<Expenses> expenses;

  Result({
    required this.expenses,
  });

  Result.fromJson(Map<String, dynamic> json) {
    expenses = List.from(json['expenses']).map((e) => Expenses.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['expenses'] = expenses.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Expenses {
  late final int? Id;
  late final String? Date;
  late final int? TotalAmount;
  late final bool? IsFinalApproved;
  late final String? status;
  late final String? CreatedBy;
  late final String? ModifiedBy;
  late final String? AssignedTo;

  Expenses({
    required this.Id,
    required this.Date,
    required this.TotalAmount,
    required this.IsFinalApproved,
    required this.status,
    required this.CreatedBy,
    required this.ModifiedBy,
    required this.AssignedTo,
  });

  Expenses.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Date = json['Date'];
    TotalAmount = json['Total Amount'];
    IsFinalApproved = json['Is Final Approved'];
    status = json['status'];
    CreatedBy = json['Created By'];
    ModifiedBy = json['Modified By'];
    AssignedTo = json['AssignedTo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['Date'] = Date;
    _data['Total Amount'] = TotalAmount;
    _data['Is Final Approved'] = IsFinalApproved;
    _data['status'] = status;
    _data['Created By'] = CreatedBy;
    _data['Modified By'] = ModifiedBy;
    _data['AssignedTo'] = AssignedTo;
    return _data;
  }
}
