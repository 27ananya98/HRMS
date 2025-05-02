import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/drawer_screens/attendance/regularization_dialog.dart';
import 'package:hrms/model/ar_list.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_handler.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/progress_dialog.dart';

class Regularization extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<Regularization>
    with AutomaticKeepAliveClientMixin<Regularization> {
  String sMonthName = "00";
  String sTotal = "00";
  int sApproved = 0;
  int sRejected = 0;
  int daysInMonth = 0;
  late DateTime currentDate;
  Future<ArList>? _myFuture;
  bool loading = false;
  String isEmpty = 'Attendance Regularization';

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
    upDateRegularization();
  }

  upDateRegularization() {
    startProgress();
    _myFuture = getArLists(DateFormat('MM').format(currentDate).toString(),
        DateFormat('yyyy').format(currentDate).toString()) as Future<ArList>?;
    _myFuture!.then((value) => {
          sApproved = 0,
          sRejected = 0,
          value.result!.forEach((element) {
            if (element.statusId == 1) {
              sApproved++;
            } else if (element.statusName == "Rejected") {
              sRejected++;
            }
          }),
          setState(() {
            sTotal = value.result!.length.toString();
          }),
          stopProgress()
        });
    setState(() {
      sMonthName = TimeHandler.getYearName(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });
  }

  Future<ArList> getArLists(String sMonth, String sYear) async {
    ArList list = await ApiHandler().getArList(sMonth, sYear);
    if (list.result!.length <= 0) {
      setState(() {
        isEmpty = "No Records Found";
      });
    } else {
      isEmpty = 'Attendance Regularization';
    }
    return list;
  }

  Widget getArStatus(String? value) {
    if (value == null) {
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 16),
      );
    } else if (value == "Rejected") {
      return Text(
        "Rejected",
        style: GoogleFonts.roboto(color: SColors.orangeYellow, fontSize: 16),
      );
    } else {
      return Text(
        value,
        style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
      );
    }
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

                                currentDate =
                                    TimeHandler.getLastMonth(currentDate);
                                _myFuture = getArLists(sLastMonth, sLastYear)
                                    as Future<ArList>?;
                                _myFuture!.then((value) => {
                                      sApproved = 0,
                                      sRejected = 0,
                                      value.result!.forEach((element) {
                                        if (element.statusId == 1) {
                                          sApproved++;
                                        } else if (element.statusName ==
                                            "Rejected") {
                                          sRejected++;
                                        }
                                      }),
                                      setState(() {
                                        sTotal =
                                            value.result!.length.toString();
                                      }),
                                      stopProgress()
                                    });
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
                                'assets/images/ic_attendance.png',
                                // Replace with your icon's file path
                                width: 20, // Set the width as needed
                                height: 20, // Set the height as needed
                                color:
                                    Colors.blue, // Customize the icon's color
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
                                currentDate =
                                    TimeHandler.getNextMonth(currentDate);
                                _myFuture = getArLists(sLastMonth, sLastYear)
                                    as Future<ArList>?;
                                _myFuture!.then((value) => {
                                      sApproved = 0,
                                      sRejected = 0,
                                      value.result!.forEach((element) {
                                        if (element.statusId == 1) {
                                          sApproved++;
                                        } else if (element.statusName ==
                                            "Rejected") {
                                          sRejected++;
                                        }
                                      }),
                                      setState(() {
                                        sTotal =
                                            value.result!.length.toString();
                                      }),
                                      stopProgress()
                                    });
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
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(8.0),
                      width: 200,
                      height: 120,
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
                            sTotal,
                            style: GoogleFonts.roboto(
                                color: SColors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Total',
                            style: GoogleFonts.roboto(
                                color: SColors.black,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        width: 200,
                        height: 120,
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
                              sApproved.toString(),
                              style: GoogleFonts.roboto(
                                  color: SColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              'Approved',
                              style: GoogleFonts.roboto(
                                  color: SColors.black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        width: 200,
                        height: 120,
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
                              sRejected.toString(),
                              style: GoogleFonts.roboto(
                                  color: SColors.rozgarRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              'Rejected',
                              style: GoogleFonts.roboto(
                                  color: SColors.black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Text(isEmpty,style: GoogleFonts.roboto(
                          color: SColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      ),
                    ),
                    ScreenWidget.disBetween(30),
                    OutlinedButton(
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (ctx, a1, a2) {
                            return Container();
                          },
                          transitionBuilder: (ctx, a1, a2, child) {
                            var curve = Curves.easeInOut.transform(a1.value);
                            return Transform.scale(
                              scale: curve,
                              child: RegularizationDialog(upDateRegularization),
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Text('Make Request',
                          style: GoogleFonts.roboto(
                            color: SColors.rozgarRed,
                          )),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: SColors.rozgarRed),
                      ),
                    ),
                  ],
                ),
                // Visibility(
                //     visible: isEmpty,
                //     child:  Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //             width: 250,
                //             height: 250,
                //             alignment: Alignment.center,
                //             child: Image(
                //               image: AssetImage('assets/images/img_comp_off.png'),
                //             )),
                //         Container(
                //           alignment: Alignment.center,
                //           child: Text('Record Not Found',
                //               style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.black,
                //                   fontSize: 16)),
                //         ),
                //         ScreenWidget.disBetween(30),
                //       ],
                //     )),
                FutureBuilder<ArList>(
                  future: _myFuture,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as ArList;
                      var reportList = items.result!;

                      return Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items == null ? 0 : items.result!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Req. ID : " +
                                                      items.result![index].id
                                                          .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                              SizedBox(height: 10),
                                              Text("In Date & Time",
                                                  style: GoogleFonts.roboto(
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getArStatus(items
                                                  .result![index].statusName),
                                              SizedBox(height: 10),
                                              Text('Out Date & Time',
                                                  style: GoogleFonts.roboto(
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                TimeHandler
                                                    .convertUtcToIndianDateTime(
                                                        items.result![index]
                                                            .inTime
                                                            .toString()),
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    color: SColors.black,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(height: 10),
                                              Text('Type',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                TimeHandler
                                                    .convertUtcToIndianDateTime(
                                                        items.result![index]
                                                            .outTime
                                                            .toString()),
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    color: SColors.black,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(height: 10),
                                              Text('Assigned To',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  items.result![index]
                                                      .attendanceTypeName
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                              SizedBox(height: 10),
                                              Text('Reason',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  items.result![index]
                                                      .pendingWithName
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      color: SColors.black,
                                                      fontSize: 14)),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                items.result![index].comment
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                    color: SColors.black,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            children: [],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
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
