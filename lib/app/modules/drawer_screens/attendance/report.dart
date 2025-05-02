import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/attendance_report_m.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:hrms/widget/cards/attendance_report_card.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_handler.dart';
import '../../../../model/holidays_list_model.dart';
import '../../../../model/leaves_report.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/progress_dialog.dart';

class Report extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<Report> with AutomaticKeepAliveClientMixin<Report> {
  Future<AttendanceReportM>? _myFuture;
  DateTime currentDate = DateTime.now();
  String sMonthName = "--";
  int daysInMonth = 0;
  String currentListMonth = '';
  String currentListYear = '';
  bool loading = false;
  List<String> leaveList = <String>[];
  List<String?> holidayList = <String>[];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    String sLastMonth = DateFormat('MM').format(currentDate);
    String sLastYear = DateFormat('yyyy').format(currentDate);
    sMonthName = TimeHandler.getYearName(currentDate);
    currentListMonth = sLastMonth;
    currentListYear = sLastYear;
    daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    _myFuture = getMonthlyReport(sLastMonth, sLastYear);
    _loadLeaveAndHolidayData(sLastYear, sLastMonth);
  }

  void _loadLeaveAndHolidayData(String year, String month) async {
    List<String> leaves = await getLeaveReports(year, month);
    List<String?> holidays = await getCurrentMonthHolidayList(year, "01");

    setState(() {
      leaveList = leaves;
      holidayList = holidays;
    });
  }

  Future<AttendanceReportM> getMonthlyReport(String sMonth, String sYear) async {
    return await ApiHandler().getAttendanceReportMonthly(sMonth, sYear);
  }

  Future<List<String>> getLeaveReports(String sYear, String sMonth) async {
    List<String> lsLeaveList = <String>[];
    MonthlyEmployeeLeaveReport response = await ApiHandler().getMonthlyEmployeeLeave(sYear, sMonth);
    response.result!.others.forEach((ele) {
      if (ele.cancellationStatusId == null) {
        if (ele.startDate == ele.endDate) {
          lsLeaveList.add(DateFormat('yyyy-MM-dd').format(DateTime.parse(ele.startDate!)));
        } else {
          lsLeaveList.addAll(Fun.printAllDaysBetweenDates(ele.startDate!, ele.endDate!).map((e) => e.toString()));
        }
      }
    });
    return lsLeaveList;
  }

  Future<List<String?>> getCurrentMonthHolidayList(String sYear, String sMonth) async {
    HolidayListModel response = await ApiHandler().getHolidayList(sYear);
    return response.result?.map((e) => e.date).toList() ?? [];
  }

  void _onMonthChange(bool isNext) async {
    setState(() {
      loading = true;
    });

    currentDate = isNext ? TimeHandler.getNextMonth(currentDate) : TimeHandler.getLastMonth(currentDate);
    String sLastMonth = DateFormat('MM').format(currentDate);
    String sLastYear = DateFormat('yyyy').format(currentDate);

    setState(() {
      sMonthName = TimeHandler.getYearName(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
      currentListMonth = sLastMonth;
      currentListYear = sLastYear;
    });

    _loadLeaveAndHolidayData(sLastYear, sLastMonth);
    _myFuture = getMonthlyReport(sLastMonth, sLastYear).whenComplete(() => setState(() {
      loading = false;
    }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required due to AutomaticKeepAliveClientMixin

    return ProgressDialog(
      loading: loading,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _monthNavigationIcon(FontAwesomeIcons.angleLeft, false),
                _monthDisplay(),
                _monthNavigationIcon(FontAwesomeIcons.angleRight, true),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: _myFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    return _buildAttendanceList(snapshot.data as AttendanceReportM);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _monthNavigationIcon(IconData icon, bool isNext) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onMonthChange(isNext),
        child: Container(
          margin: isNext ? const EdgeInsets.only(left: 30.0) : const EdgeInsets.only(left: 90.0),
          child: FaIcon(icon, color: Colors.black, size: 30),
        ),
      ),
    );
  }

  Widget _monthDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(sMonthName, style: GoogleFonts.roboto(color: SColors.black, fontWeight: FontWeight.w500, fontSize: 16)),
        Row(
          children: [
            Image.asset('assets/images/ic_attendance.png', width: 20, height: 20, color: Colors.blue),
            const SizedBox(width: 5),
            Text("$daysInMonth Days", style: GoogleFonts.roboto(color: SColors.black, fontWeight: FontWeight.w500, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildAttendanceList(AttendanceReportM attendanceReport) {
    final reportList = attendanceReport.result!;
    final dailyAttendance = Fun.showList(int.parse(currentListMonth), int.parse(currentListYear), reportList);

    return ListView.builder(
      itemCount: dailyAttendance.length,
      itemBuilder: (context, index) {
        var attendance = dailyAttendance[index];
        DateTime date = DateTime.parse(attendance.inTime.toString());
        String weekDay = Fun.getWeekDayAbbreviation(date.weekday);

        // Time conversions and progress calculations
        String checkInTime = _getIndianTime(attendance.inTime);
        String checkOutTime = "--";
        String totalTime = "--";
        double progressBar = 0.0;

        try {
          checkOutTime = _getIndianTime(attendance.outTime);
          totalTime = Fun.calculateTotalHours(attendance.inTimeDay!, reportList);
          progressBar = _calculateProgressBar(totalTime);
        } catch (_) {}

        return attendanceReportCard(
          context,
          checkInTime,
          TimeHandler.convertDate(date.toString()),
          checkOutTime,
          TimeHandler.convertDate(date.toString()),
          progressBar,
          totalTime,
          weekDay,
          attendance.inTimeDay!,
          date,
          leaveList,
          holidayList,
          reportList,
          attendance.dailyTaskStatus,
        );
      },
    );
  }

  String _getIndianTime(String? utcTimestamp) {
    if (utcTimestamp == null) return "--";
    DateTime dateTime = DateTime.parse(utcTimestamp).add(const Duration(hours: 5, minutes: 30));
    String time = DateFormat('HH:mm').format(dateTime);
    return time == "05:30" ? "--" : time;
  }

  double _calculateProgressBar(String totalTime) {
    int userSec = Fun.calculateTotalSeconds(totalTime);
    const int totalSec = 34200; // 9.5 hours in seconds
    return userSec <= totalSec ? userSec / totalSec : 1.0;
  }

  @override
  bool get wantKeepAlive => true;
}
