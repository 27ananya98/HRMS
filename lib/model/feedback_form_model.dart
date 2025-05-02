class FeedbackFormModel {
  FeedbackFormModel({
    required this.status,
    required this.result,
    required this.error,
    required this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  FeedbackFormModel.fromJson(Map<String, dynamic> json){
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
  Result({
    required this.id,
    required this.hrFeed,
    required this.hrRat,
    required this.repmFeed,
    required this.repmRat,
    required this.comPolFeed,
    required this.comPolRat,
    required this.healthenvFeed,
    required this.healthenvRat,
    required this.satetyFeed,
    required this.safetyRat,
    required this.overallSug,
    required this.userid,
    required this.createdAt,
  });
  late final int? id;
  late final String? hrFeed;
  late final int? hrRat;
  late final String? repmFeed;
  late final int? repmRat;
  late final String? comPolFeed;
  late final int? comPolRat;
  late final String? healthenvFeed;
  late final int? healthenvRat;
  late final String? satetyFeed;
  late final int? safetyRat;
  late final String? overallSug;
  late final int? userid;
  late final String? createdAt;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    hrFeed = json['hr_feed'];
    hrRat = json['hr_rat'];
    repmFeed = json['repm_feed'];
    repmRat = json['repm_rat'];
    comPolFeed = json['comPol_feed'];
    comPolRat = json['comPol_rat'];
    healthenvFeed = json['healthenv_feed'];
    healthenvRat = json['healthenv_rat'];
    satetyFeed = json['satety_feed'];
    safetyRat = json['safety_rat'];
    overallSug = json['overall_sug'];
    userid = json['userid'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['hr_feed'] = hrFeed;
    _data['hr_rat'] = hrRat;
    _data['repm_feed'] = repmFeed;
    _data['repm_rat'] = repmRat;
    _data['comPol_feed'] = comPolFeed;
    _data['comPol_rat'] = comPolRat;
    _data['healthenv_feed'] = healthenvFeed;
    _data['healthenv_rat'] = healthenvRat;
    _data['satety_feed'] = satetyFeed;
    _data['safety_rat'] = safetyRat;
    _data['overall_sug'] = overallSug;
    _data['userid'] = userid;
    _data['created_at'] = createdAt;
    return _data;
  }
}