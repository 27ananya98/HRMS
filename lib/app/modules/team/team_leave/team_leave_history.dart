import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/team_leave_report.dart';
import '../../../../../widget/cards/team_leave_card.dart';
import '../../../../../widget/progress_dialog.dart';

class TeamLeaveHistory extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<TeamLeaveHistory>
    with AutomaticKeepAliveClientMixin<TeamLeaveHistory> {
  String sMonthName = "00";
  int daysInMonth = 0;
  late DateTime currentDate;
  bool loading = false;
  bool isEmpty = false;
  Future<TeamLeaveReport>? _myFuture;

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
      sMonthName = TimeHandler.sMonthYear(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });
    _myFuture = monthlyTeamEmployeeLeave(
        DateFormat('yyyy').format(currentDate).toString(),
        DateFormat('MM').format(currentDate).toString());
  }

  Future<TeamLeaveReport> monthlyTeamEmployeeLeave(
      String sYear, String sMonth) async {
    TeamLeaveReport response =
        await ApiHandler().getTeamLeaveReport(sYear, sMonth);
    if (response.result!.others!.isEmpty) {
      setState(() {
        isEmpty = true;
      });
    } else {
      isEmpty = false;
    }
    stopProgress();
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
                                sMonthName = TimeHandler.sMonthYear(
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
                                      _myFuture = monthlyTeamEmployeeLeave(
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
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(sMonthName,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    //fontStyle: FontStyle.italic,
                                  )),
                              Text("$daysInMonth Days",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    //fontStyle: FontStyle.italic,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              startProgress();
                              setState(() {
                                sMonthName = TimeHandler.sMonthYear(
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
                                      _myFuture = monthlyTeamEmployeeLeave(
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
                                color: Colors.black,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<TeamLeaveReport>(
                  future: _myFuture,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as TeamLeaveReport;
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
                                  String sRequestID = items.result!.others![index].id.toString();
                                  String createOn = TimeHandler.getDateFromUnix(
                                      items.result!.others![index].createdOn
                                          .toString());
                                  String createdByName =
                                  items.result!.others![index].createdByName
                                      .toString();
                                  String modifiedByName =
                                  items.result!.others![index].modifiedByName
                                      .toString();
                                  int? leaveStatusId = items
                                      .result!.others![index].leaveStatusId;
                                  String numberOfDays = items
                                      .result!.others![index].numberOfDays
                                      .toString();
                                  String startDate = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.others![index].startDate
                                          .toString()
                                          .substring(0, 10)));
                                  String endDate = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.others![index].endDate
                                          .toString()
                                          .substring(0, 10)));
                                  String leaveTypeName = items
                                      .result!.others![index].leaveTypeName
                                      .toString();
                                  String assignedToName = items
                                      .result!.others![index].assignedToName
                                      .toString();
                                  bool? isPending =
                                      items.result!.others![index].pending;
                                  int? cancellationRequestedBy = items.result!
                                      .others![index].cancellationRequestedBy;
                                  String reason =
                                  items.result!.others![index].reason
                                      .toString();
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      print("GestureDetector");
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child:
                                    TeamLeaveRequests.teamLeaveHistoryRequestCard(
                                        context,
                                        isPending,
                                        createdByName,
                                        "LEREQ" + sRequestID,
                                        leaveStatusId,
                                        numberOfDays,
                                        startDate + " - " + endDate,
                                        createOn,
                                        leaveTypeName,
                                        assignedToName,
                                        cancellationRequestedBy,modifiedByName,reason),
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
