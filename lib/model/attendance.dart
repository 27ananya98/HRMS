 
class Attendance {
  final int id;
  final String inTime;
  final String outTime;
  final String comment;
  final int attendanceTypeId;
  final String attendanceTypeName;
  final int shiftId;
  final String shiftName;
  final int pendingWith;
  final String pendingWithName;
  final String createdOn;
  final String modifiedOn;
  final int statusId;
  final String statusName;
  final String createdByName;
  final String modifiedByName;

  Attendance({
    required this.id,
    required this.inTime,
    required this.outTime,
    required this.comment,
    required this.attendanceTypeId,
    required this.attendanceTypeName,
    required this.shiftId,
    required this.shiftName,
    required this.pendingWith,
    required this.pendingWithName,
    required this.createdOn,
    required this.modifiedOn,
    required this.statusId,
    required this.statusName,
    required this.createdByName,
    required this.modifiedByName,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      inTime: json['inTime'],
      outTime: json['outTime'],
      comment: json['comment'],
      attendanceTypeId: json['attendanceTypeId'],
      attendanceTypeName: json['attendanceTypeName'],
      shiftId: json['shiftId'],
      shiftName: json['shiftName'],
      pendingWith: json['pendingWith'],
      pendingWithName: json['pendingWithName'],
      createdOn: json['createdOn'],
      modifiedOn: json['modifiedOn'],
      statusId: json['statusId'],
      statusName: json['statusName'],
      createdByName: json['createdByName'],
      modifiedByName: json['modifiedByName'],
    );
  }
}
 