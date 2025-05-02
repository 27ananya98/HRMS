import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/team_attendance_m.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../widget/cards/team_attendance_card.dart';
import '../../../../widget/progress_dialog.dart';

class TeamAttendance extends StatefulWidget {
  @override
  _TeamAttendanceState createState() => _TeamAttendanceState();
}

class _TeamAttendanceState extends State<TeamAttendance> {
  late Future<TeamAttendanceReport> _myFuture;
  late DateTime currentDate;
  DateTime _selectDate = DateTime.now();
  List<Attendance>? list = <Attendance>[];
  String? sMonth;
  String? sYear;
  String? sDate;
  String? date;
  int sTotal = 0;
  int sPresent = 0;
  int sAbsent = 0;
  int sLeave = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    date = DateFormat('yyyy-MM-dd').format(currentDate).toString();
    _myFuture = getTeamAttendance(date);
  }

  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectDate) {
      setState(() {
        _selectDate = picked;
        try {
          _myFuture = getTeamAttendance(
              DateFormat('yyyy-MM-dd').format(_selectDate).toString());
        } catch (e) {
          loading = false;
        }
      });
    }
  }

  List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  Future<TeamAttendanceReport> getTeamAttendance(date) async {
    setState(() {
      loading = true;
    });
    TeamAttendanceReport response =
        await ApiHandler().getTeamAttendanceReport(date);
    setState(() {
      sTotal = response.result!.team!.length;
    });
    List<int> attendanceList = <int>[];
    List<int> leaveList = <int>[];
    response.result!.attendance!.forEach((element) {
      attendanceList.add(element.userId!);
    });
    attendanceList = removeDuplicates(attendanceList);
    if (response.result!.leaves != null) {
      response.result!.leaves!.forEach((element) {
        leaveList.add(element.userId!);
      });
    }
    leaveList = removeDuplicates(leaveList);
    setState(() {
      sLeave = leaveList.length;
      sPresent = attendanceList.length;
      sAbsent = sTotal - sPresent - sLeave;
      loading = false;
    });
    return response;
  }

  getTeamStatus(id, List<Attendance>? list, List<Leaves>? leaves) {
    List<Attendance> reversedList = list!.reversed.toList();
    Map<String, dynamic> status = {
      'isPresent': "Absent",
      'sCheckInTime': "--",
      'sCheckOutTime': "--",
      'sTotalTime': "--",
    };
    if (reversedList != null) {
      for (var element in reversedList) {
        if (element.userId == id) {
          status["sCheckInTime"] =
              TimeHandler.convertUtcToIndianTime(element.inTime.toString());
          status["isPresent"] = "Active";
          if (element.inTime != null && element.outTime != null) {
            try {
              status["sTotalTime"] = TimeHandler.calculateTimeDifference(
                  element.inTime!, element.outTime!);
            } catch (e) {
              status["sTotalTime"] = "--";
            }
          }
          break;
        }
      }
    }
    if (leaves != null) {
      for (var element in leaves) {
        if (element.userId == id) {
          status["isPresent"] = "Leave";
          break;
        }
      }
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SColors.rozgarRed,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('TEAM ATTENDANCE',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: SColors.white,
                  fontSize: 18)),
        ),
        body: ProgressDialog(
            loading: loading,
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                         decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                  '${DateFormat('MMMM dd, yyyy').format(_selectDate)}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(color: Color(0xFF000000))),
                              onTap: () {
                                _selectInDate(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              tooltip: 'Tap to open date picker',
                              onPressed: () {
                                _selectInDate(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () {
                              print("Press");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: BorderSide(
                                color: SColors.rozgarRed,
                                width: 2,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              elevation: 0,
                              primary: Colors.transparent,
                              onPrimary: SColors.rozgarRed,
                            ),
                            child: Text('Download  Excel'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(8.0),
                     height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sTotal.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Total',
                          style: GoogleFonts.roboto(
                              color: SColors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                       height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sPresent.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Present',
                            style: GoogleFonts.roboto(
                                color: SColors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sAbsent.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: SColors.rozgarRed,
                            ),
                          ),
                          Text(
                            'Absent',
                            style: GoogleFonts.roboto(
                                color: SColors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sLeave.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            'Leave',
                            style: GoogleFonts.roboto(
                                color: SColors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Expanded(
                    child: FutureBuilder(
                  future: _myFuture,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as TeamAttendanceReport;
                      return Container(
                         decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                            itemCount:
                                items == null ? 0 : items.result!.team!.length,
                            itemBuilder: (context, index) {
                              var status = getTeamStatus(
                                  items.result!.team![index].userId,
                                  items.result!.attendance,
                                  items.result!.leaves);
                              return getTeamAttendanceCard(
                                  items.result!.team![index].name.toString(),
                                  items.result!.team![index].userId.toString(),
                                  status["sTotalTime"],
                                  items.result!.team![index].designationName
                                      .toString(),
                                  status["sCheckInTime"],
                                  status["isPresent"]);
                            }),
                      );
                    }
                    return Container();
                  },
                )),
              ],
            )));
  }
}
