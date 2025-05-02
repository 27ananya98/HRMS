import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_handler.dart';
import '../../../../model/leave_status.dart';
import '../../../../model/leaves_report.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/bottom_sheet/leave_request_report.dart';
import '../../../../widget/cards/leave_requests.dart';
import '../../../../widget/progress_dialog.dart';

class LeaveRequest extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<LeaveRequest>
    with AutomaticKeepAliveClientMixin<LeaveRequest> {
  String sMonthName = "00";
  int daysInMonth = 0;
  late DateTime currentDate;
  Future<MonthlyEmployeeLeaveReport>? _myFuture;
  bool loading = false;
  bool isEmpty = false;

  void startProgress() {
    setState(() {
      loading = true;
    });
    Future.delayed(Duration(seconds: 6), () {
      stopProgress();
    });
  }

  void stopProgress() {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    setState(() {
      sMonthName = TimeHandler.getYearName(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });

    _myFuture = monthlyEmployeeLeave(
        DateFormat('yyyy').format(currentDate).toString(),
        DateFormat('MM').format(currentDate).toString());
  }

  Future<MonthlyEmployeeLeaveReport> monthlyEmployeeLeave(
      String sYear, String sMonth) async {
    MonthlyEmployeeLeaveReport response =
        await ApiHandler().getMonthlyEmployeeLeave(sYear, sMonth);
    if (response.result!.others.isEmpty && response.result!.pending.isEmpty) {
      setState(() {
        isEmpty = true;
      });
    } else {
      isEmpty = false;
    }
    stopProgress();
    return response;
  }

  Future<LeaveStatus> getLeaveStatus(id) async {
    LeaveStatus response = await ApiHandler().getLeaveStatus(id);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loading: loading,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScreenWidget.disBetween(15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              startProgress();
                              setState(() {
                                sMonthName = TimeHandler.getYearName(
                                    TimeHandler.getLastMonth(currentDate));
                                daysInMonth = DateTime(
                                        TimeHandler.getLastMonth(currentDate)
                                            .year,
                                        TimeHandler.getLastMonth(currentDate)
                                                .month +
                                            1,
                                        0)
                                    .day;
                                String sLastMonth = DateFormat('MM').format(
                                    TimeHandler.getLastMonth(currentDate));
                                String sLastYear = DateFormat('yyyy').format(
                                    TimeHandler.getLastMonth(currentDate));
                                setState(() => {
                                      _myFuture = monthlyEmployeeLeave(
                                          sLastYear, sLastMonth)
                                    });

                                currentDate =
                                    TimeHandler.getLastMonth(currentDate);
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 90.0),
                                child: FaIcon(
                                  FontAwesomeIcons.angleLeft,
                                  // Define the icon you want to use
                                  color: Colors.black,
                                  size: 30, // Customize the color
                                ))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(sMonthName,
                              style: GoogleFonts.roboto(
                                  color: SColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/ic_attendance.png', // Replace with your icon's file path
                                width: 20, // Set the width as needed
                                height: 20, // Set the height as needed
                                color: Colors.blue, // Customize the icon's color
                              ),
                              SizedBox(width: 5),
                              Text("$daysInMonth Days",
                                  style: GoogleFonts.roboto(
                                      color: SColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              startProgress();
                              setState(() {
                                sMonthName = TimeHandler.getYearName(
                                    TimeHandler.getNextMonth(currentDate));
                                daysInMonth = DateTime(
                                        TimeHandler.getNextMonth(currentDate)
                                            .year,
                                        TimeHandler.getNextMonth(currentDate)
                                                .month +
                                            1,
                                        0)
                                    .day;
                                String sLastMonth = DateFormat('MM').format(
                                    TimeHandler.getNextMonth(currentDate));
                                String sLastYear = DateFormat('yyyy').format(
                                    TimeHandler.getNextMonth(currentDate));
                                setState(() => {
                                      _myFuture = monthlyEmployeeLeave(
                                          sLastYear, sLastMonth)
                                    });
                                currentDate =
                                    TimeHandler.getNextMonth(currentDate);
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  // Define the icon you want to use
                                  color: Colors.black,
                                  size: 30, // Customize the color
                                ))),
                      ),
                    ]),
                ScreenWidget.disBetween(15),
                Visibility(
                  visible: isEmpty,
                  child: Column(
                    children: [
                      Container(
                          width: 250,
                          height: 250,
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('assets/images/img_comp_off.png'),
                          )),
                      Container(
                        alignment: Alignment.center,
                        child: Text("No Record Found",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: SColors.black,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<MonthlyEmployeeLeaveReport>(
                  future: _myFuture,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as MonthlyEmployeeLeaveReport;
                      return Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items == null
                                    ? 0
                                    : items.result?.others?.length,
                                itemBuilder: (context, index) {
                                  String createOn = TimeHandler.getDateFromUnix(
                                      items.result!.others[index].createdOn
                                          .toString());
                                  int? leaveStatusId =
                                      items.result!.others[index].leaveStatusId;
                                  bool? isPending =
                                      items.result!.others[index].pending;
                                  String numberOfDays = items
                                      .result!.others[index].numberOfDays
                                      .toString();
                                  String startDate = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.others[index].startDate
                                          .toString()
                                          .substring(0, 10)));
                                  String endDate = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.others[index].endDate
                                          .toString()
                                          .substring(0, 10)));
                                  String leaveTypeName = items
                                      .result!.others[index].leaveTypeName
                                      .toString();
                                  String assignedToName = items
                                      .result!.others[index].assignedToName
                                      .toString();
                                  int? id = items.result!.others[index].id;
                                  int? cancellationRequestedBy = items.result!
                                      .others[index].cancellationRequestedBy;
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      LeaveStatus response =
                                          await getLeaveStatus(id);
                                      leaveRepBottomSheet(
                                          context, response, leaveTypeName);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: LeaveRequests.leaveRequestCard(
                                        context,
                                        isPending,
                                        "Req On: " + createOn,
                                        leaveStatusId,
                                        numberOfDays,
                                        startDate + "-" + endDate,
                                        leaveTypeName,
                                        assignedToName,
                                        cancellationRequestedBy),
                                  );
                                }),
                          ),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items == null
                                    ? 0
                                    : items.result?.pending?.length,
                                itemBuilder: (context, index) {
                                  String createOn = TimeHandler.getDateFromUnix(
                                      items.result!.pending[index].createdOn
                                          .toString());
                                  int? leaveStatusId = items
                                      .result!.pending[index].leaveStatusId;
                                  String numberOfDays = items
                                      .result!.pending[index].numberOfDays
                                      .toString();
                                  String startDate = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.pending[index].startDate
                                          .toString()
                                          .substring(0, 10)));
                                  String endDate = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.pending[index].endDate
                                          .toString()
                                          .substring(0, 10)));
                                  String leaveTypeName = items
                                      .result!.pending[index].leaveTypeName
                                      .toString();
                                  String assignedToName = items
                                      .result!.pending[index].assignedToName
                                      .toString();
                                  bool? isPending =
                                      items.result!.pending[index].pending;
                                  int? cancellationRequestedBy = items.result!
                                      .pending[index].cancellationRequestedBy;
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      leavePendingBottomSheet(
                                          context,
                                          items.result!.pending[index],
                                          leaveTypeName);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: LeaveRequests.leaveRequestCard(
                                        context,
                                        isPending,
                                        "Req On: " + createOn,
                                        leaveStatusId,
                                        numberOfDays,
                                        startDate + " - " + endDate,
                                        leaveTypeName,
                                        assignedToName,
                                        cancellationRequestedBy),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
