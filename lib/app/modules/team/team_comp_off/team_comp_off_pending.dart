import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/team_comoff_report.dart';
import '../../../../../widget/cards/team_comp.dart';
import '../../../../../widget/progress_dialog.dart';

class TeamCompOffPending extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<TeamCompOffPending>
    with AutomaticKeepAliveClientMixin<TeamCompOffPending> {
  String sMonthName = "00";
  int daysInMonth = 0;
  late DateTime currentDate;
  bool loading = false;
  bool isEmpty = false;
  Future<TeamComoffReport>? _myFuture;

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
    updatePendingRequest();
  }
  updatePendingRequest() {
    _myFuture = monthlyTeamEmployeeLeave(
        DateFormat('yyyy').format(currentDate).toString(),
        DateFormat('MM').format(currentDate).toString());
  }
  Future<TeamComoffReport> monthlyTeamEmployeeLeave(
      String sYear, String sMonth) async {
    TeamComoffReport response = await ApiHandler().getTeamCompOffReport(sYear, sMonth);
    if (response.result!.pending.isEmpty) {
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
                FutureBuilder<TeamComoffReport>(
                  future: _myFuture,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as TeamComoffReport;
                      return Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items == null
                                    ? 0
                                    : items.result?.pending?.length,
                                itemBuilder: (context, index) {
                                  String sRequestID = items
                                      .result!.pending![index].id
                                      .toString();
                                  String createdByName = items
                                      .result!.pending![index].createdByName
                                      .toString();
                                  String attendanceTypeName = items.result!
                                      .pending![index].attendanceTypeName
                                      .toString();
                                  String outTime = TimeHandler.convertDate(
                                      TimeHandler.getDateFromUnix(items
                                          .result!.pending![index].outTime
                                          .toString()
                                          .substring(0, 10)));

                                  String sInTime = TimeHandler.convertUtcToIndianTime(items
                                      .result!.pending![index].inTime
                                      .toString());
                                  String sOutTime = TimeHandler.convertUtcToIndianTime(items
                                      .result!.pending![index].outTime
                                      .toString());
                                  String comment =  items.result!
                                      .pending![index].comment
                                      .toString();
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      print(GestureDetector);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child:
                                    TeamComp.teamCompOffPendingRequestCard(
                                        context,
                                        createdByName,
                                        sRequestID,
                                        attendanceTypeName,
                                        outTime,sInTime+"-"+sOutTime,comment,updatePendingRequest),
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
