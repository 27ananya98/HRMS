class UpcomingEvent {
  UpcomingEvent({
    this.status,
    this.result,
    this.error,
    this.version,
  });
  bool? status;
  List<Result>? result;
  String? error;
  String? version;

  UpcomingEvent.fromJson(Map<String, dynamic> json){
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
    this.id,
    this.title,
    this.description,
    this.eventDt,
    this.createdOn,
    this.modifiedOn,
  });
   int? id;
   String? title;
   String? description;
   String? eventDt;
   String? createdOn;
   String? modifiedOn;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
    eventDt = json['event_dt'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['event_dt'] = eventDt;
    _data['created_on'] = createdOn;
    _data['modified_on'] = modifiedOn;
    return _data;
  }
}