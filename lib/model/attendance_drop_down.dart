class AttendanceDropDown {
  AttendanceDropDown({
    required this.id,
    required this.name,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.modifiedOn,
    required this.description,
    required this.isGeofenced,
    required this.geofenceGroupId,
    required this.available,
    required this.lat,
    required this.lng,
    required this.radius,
    required this.orgId,
  });

  late final int? id;
  late final String? name;
  late final int? modifiedBy;
  late final String? modifiedAt;
  late final String? modifiedOn;
  late final String? description;
  late final bool? isGeofenced;
  late final String? geofenceGroupId;
  late final bool? available;
  late final String? lat;
  late final String? lng;
  late final String? radius;
  late final String? orgId;

  AttendanceDropDown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
    modifiedOn = json['modifiedOn'];
    description = json['description'];
    isGeofenced = json['isGeofenced'];
    geofenceGroupId = json['geofenceGroupId'];
    available = json['available'];
    lat = json['lat'];
    lng = json['lng'];
    radius = json['radius'];
    orgId = json['org_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedAt'] = modifiedAt;
    _data['modifiedOn'] = modifiedOn;
    _data['description'] = description;
    _data['isGeofenced'] = isGeofenced;
    _data['geofenceGroupId'] = geofenceGroupId;
    _data['available'] = available;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['radius'] = radius;
    _data['org_id'] = orgId;
    return _data;
  }
}
