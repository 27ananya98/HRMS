import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_handler.dart';
import '../../../../model/comp_off.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/dialogs/add_comp_off.dart';
import '../../../../widget/progress_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin<Dashboard> {
  String sMonthName = "00";
  String sTotal = "00";
  int sApproved = 0;
  int sRejected = 0;
  int sPending = 0;
  int daysInMonth = 0;
  late DateTime currentDate;
  bool loading = false;
  String? sMonth; 
  String? sYear;


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
    sMonth = DateFormat('MM').format(currentDate);
    sYear = DateFormat('yyyy').format(currentDate);
    getCompOffList(sYear, sMonth);
    setState(() {
      sMonthName = TimeHandler.getYearName(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });
  }

  getCompOffList(year, month) async {
    startProgress();
    CompOff response = await ApiHandler().getCompOffReportMonthly(year, month);
    setState(() {
      sTotal = response.result!.length.toString();
    });
    int pending = 0;
    int approved = 0;
    int reject = 0;
    response.result?.forEach((element) {
      if (element.statusName == null) {
        pending++;
      }else if(element.statusName == "Rejected") {
        reject++;
      }else if(element.statusName == "Approved") {
        approved++;
      }
    });
    setState(() {
      sPending = pending;
      sRejected = reject;
      sApproved = approved;
    });
    stopProgress();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loading: loading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenWidget.disBetween(15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          sMonthName = TimeHandler.getYearName(
                              TimeHandler.getLastMonth(currentDate));
                          daysInMonth = DateTime(
                              TimeHandler.getLastMonth(currentDate).year,
                              TimeHandler.getLastMonth(currentDate).month + 1,
                              0)
                              .day;
                          String sLastMonth = DateFormat('MM')
                              .format(TimeHandler.getLastMonth(currentDate));
                          String sLastYear = DateFormat('yyyy')
                              .format(TimeHandler.getLastMonth(currentDate));
                          getCompOffList(sLastYear, sLastMonth);
                          currentDate = TimeHandler.getLastMonth(currentDate);
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 90.0),
                          child: const FaIcon(
                            FontAwesomeIcons
                                .angleLeft, // Define the icon you want to use
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
                        const SizedBox(width: 5),
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
                        setState(() {
                          sMonthName = TimeHandler.getYearName(
                              TimeHandler.getNextMonth(currentDate));
                          daysInMonth = DateTime(
                              TimeHandler.getNextMonth(currentDate).year,
                              TimeHandler.getNextMonth(currentDate).month + 1,
                              0)
                              .day;
                          String sLastMonth = DateFormat('MM')
                              .format(TimeHandler.getNextMonth(currentDate));
                          String sLastYear = DateFormat('yyyy')
                              .format(TimeHandler.getNextMonth(currentDate));
                          getCompOffList(sLastYear, sLastMonth);
                          currentDate = TimeHandler.getNextMonth(currentDate);
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 30.0),
                          child: const FaIcon(
                            FontAwesomeIcons
                                .angleRight, // Define the icon you want to use
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
                        margin: const EdgeInsets.all(8.0),
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
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
                      margin: const EdgeInsets.all(8.0),
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
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
                      margin: const EdgeInsets.all(8.0),
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
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
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
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
                            sPending.toString(),
                            style: GoogleFonts.roboto(
                                color: SColors.philippineOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Pending',
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
                    child: Text('Attendance Dashboard',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                            color: SColors.black,
                            fontSize: 16)),
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
                            child: AddCompOff(callback:()async {
                              await getCompOffList(sYear, sMonth);
                            },),
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: Text('Make Request',
                      style: GoogleFonts.roboto(
                        color: SColors.rozgarRed,),
                    ),
                  ),
                 ],
              ),
            ],
          ),
        ) );
  }

  @override
  bool get wantKeepAlive => true;
}
