import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';
import '../../../../api/api_handler.dart';
import '../../../../model/attendance_report_m.dart';
import '../../../../model/holidays_list_model.dart';
import '../../../../model/leaves_report.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/graph.dart';
import '../../../../widget/progress_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> with AutomaticKeepAliveClientMixin<Dashboard> {
  late DateTime currentDate;
  String sMonthName = "00";
  String currentListMonth = "00";
  String currentListYear = "00";
  String presentDays = "00";
  String weekendCount = "00";
  double leaveCount = 0;
  int iPresnt = 0;
  int iLeaves = 0;
  int iHolidays = 0;
  int iAbsent = 0;
  int daysInMonth = 30;
  bool loading = false;
  List<FlSpot> graphList = [];

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    updateDashboardData();
  }

  void updateDashboardData() {
    setState(() {
      sMonthName = TimeHandler.getYearName(currentDate);
      currentListMonth = DateFormat('MM').format(currentDate);
      currentListYear = DateFormat('yyyy').format(currentDate);
      weekendCount = Fun.getWeekendCount(currentDate).toString();
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });
    updateLeaveReport();
  }

  Future<void> updateLeaveReport() async {
    startProgress();
    try {
      await Future.wait([
        getLeaveReports(currentListYear, currentListMonth),
        getMonthlyReport(currentListMonth, currentListYear),
        getHolidayLists(currentListYear),
      ]);
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      stopProgress();
    }
  }

  Future<MonthlyEmployeeLeaveReport> getLeaveReports(String year, String month) async {
    leaveCount = 0;
    final rLeave = await ApiHandler().getMonthlyEmployeeLeave(year, month);
    rLeave.result?.others.forEach((element) {
      if (element.leaveStatusId == 1) {
        leaveCount += double.parse(element.numberOfDays ?? '0');
      }
    });
    iLeaves = rLeave.result!.others.where((element) => element.leaveStatusId == 1).length;
    return rLeave;
  }

  Future<AttendanceReportM> getMonthlyReport(String month, String year) async {
    final response = await ApiHandler().getAttendanceReportMonthly(month, year);
    graphList = List.generate(31, (i) {
      final input = extractValueBeforeColon(Fun.calculateTotalHours(i + 1, response.result!));
      return FlSpot((i + 1).toDouble(), input > 12 ? 12 : input);
    });
    setState(() {
      presentDays = graphList.where((spot) => spot.y > 0).length.toString();
    });

    final countDay = <int>[];
    iPresnt = 0;
    response.result?.forEach((element) {
      if (element.dailyTaskStatus != false && !countDay.contains(element.inTimeDay)) {
        iPresnt++;
        countDay.add(element.inTimeDay!);
      }
    });
    return response;
  }

  Future<HolidayListModel> getHolidayLists(String year) async {
    final response = await ApiHandler().getHolidayList(year);
    iHolidays = response.result!.where((holiday) {
      return holiday.date!.startsWith("$currentListYear-$currentListMonth");
    }).length;
    setState(() {});
    return response;
  }

  double extractValueBeforeColon(String input) {
    try {
      return double.parse(input.split(':').first.trim());
    } catch (e) {
      return 0.0;
    }
  }

  void startProgress() => setState(() => loading = true);

  void stopProgress() => setState(() => loading = false);

  Widget getContainer(String title, String sCount) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 4),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sCount,
              style: GoogleFonts.roboto(
                color: SColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.roboto(color: SColors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProgressDialog(
      loading: loading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenWidget.disBetween(15),
            buildMonthNavigation(),
            ScreenWidget.disBetween(25),
            buildStatsContainer(),
            ScreenWidget.disBetween(10),
            buildGraphSection(),
          ],
        ),
      ),
    );
  }

  Widget buildMonthNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildMonthNavigationButton(FontAwesomeIcons.angleLeft, () => changeMonth(-1)),
        Column(
          children: [
            Text(
              sMonthName,
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/ic_attendance.png',
                  width: 20,
                  height: 20,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  "$daysInMonth Days",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        buildMonthNavigationButton(FontAwesomeIcons.angleRight, () => changeMonth(1)),
      ],
    );
  }

  Widget buildMonthNavigationButton(IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.only(left: 30.0),
          child: FaIcon(icon, color: Colors.black, size: 30),
        ),
      ),
    );
  }

  void changeMonth(int offset) {
    setState(() {
      currentDate = offset == -0 ? TimeHandler.getLastMonth(currentDate) : TimeHandler.getNextMonth(currentDate);
      updateDashboardData();
    });
  }

  Widget buildStatsContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getContainer('Present', iPresnt.toString()),
            getContainer('Weekends', weekendCount),
            getContainer('Holidays', iHolidays.toString()),
          ],
        ),
        ScreenWidget.disBetween(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getContainer('Total Days', daysInMonth.toString()),
            getContainer('Absent', iAbsent.toString()),
            getContainer('Leave', leaveCount == 0.0 ? '0' : leaveCount.toString()),
          ],
        ),
      ],
    );
  }

  Widget buildGraphSection() {
    return Column(
      children: [
        Text(
          'In-Time Trend',
          style: GoogleFonts.roboto(color: SColors.black, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Graph(flSpot: graphList),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}