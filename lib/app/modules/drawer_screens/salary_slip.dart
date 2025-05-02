import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:intl/intl.dart';

import '../../../api/api_handler.dart';
import '../../../model/salary_slip_model.dart';
import '../../../utils/s_colors.dart';
import '../../../utils/screen_widget.dart';
import '../../../utils/time_handler.dart';
import '../../../widget/progress_dialog.dart';

class SalarySlip extends StatefulWidget {
  @override
  _SalarySlipState createState() => _SalarySlipState();
}

class _SalarySlipState extends State<SalarySlip> {
  String sMonthName = "00";
  String sTotal = "00";
  int sApproved = 0;
  int sRejected = 0;
  int daysInMonth = 0;
  late DateTime currentDate;
  final List<List<String>> earning = [
    ['Particulars', 'Monthly Gross', 'Earning Gross'],
  ];
  final List<List<String>> deduction = [
    ['Particulars', 'Monthly Gross', 'Earning Gross'],
  ];

  bool loading = false;
  int sPending = 0;
  bool isEmpty = false;
  bool isRecordNotFound = false;
  String sEmployeeId = "--";
  String sEmployeeName = "--";
  String sDateOfJoining = "--";
  String sMonth = "--";
  String sTotalPaidDays = "--";
  String sDesignation = "--";
  String sGrossEarningPotential = "--";
  String sNetTakeHome = "--";
  String sOrgName = "--";
  String sAddress = "--";

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
    Fun.customLogEvent("salary_slip");
    currentDate = DateTime.now();
    currentDate = DateTime.now();
    String sMonth = DateFormat('MM').format(currentDate);
    String sYear = DateFormat('yyyy').format(currentDate);
    setState(() {
      sMonthName = TimeHandler.getYearName(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });
    getSalaryResponce(sYear, sMonth);
  }

  Future<SalarySlipModel> getSalaryResponce(year, month) async {
    earning.clear();
    deduction.clear();
    List<String> lsList = ['Particulars', 'Monthly Gross', 'Earning Gross'];
    earning.add(lsList);
    deduction.add(lsList);
    startProgress();
    setState(() {
      isEmpty = false;
      isRecordNotFound = false;
    });
    SalarySlipModel response = await ApiHandler().getSalarySlip(year, month);
    if (response.result != null) {
      setState(() {
        isEmpty = true;
        isRecordNotFound = false;
        sEmployeeId = response.result!.profileDetail!.id!.toString();
        sEmployeeName = response.result!.profileDetail!.name!;
        sDateOfJoining = TimeHandler.convertDate(
            response.result!.profileDetail!.dateOfJoining!);
        sMonth = TimeHandler.getMonthName(year + "-" + month);
        sTotalPaidDays = response.result!.profileDetail!.totalWorkingDays!;
        sDesignation = response.result!.profileDetail!.designationName!;
        sGrossEarningPotential =
            response.result!.profileDetail!.monthlyGross!.toString();
        sNetTakeHome = response.result!.profileDetail!.earnedGross!.toString();
        sOrgName = response.result!.profileDetail!.orgName!.toString();
        sAddress = response.result!.profileDetail!.addressLine1!.toString();
        response.result!.salaryList!.forEach((element) {
          if (element.componentType == 1) {
            List<String> earingList = [];
            earingList.add(element.name!);
            earingList.add(element.value!.toString());
            earingList.add(element.earned!.toString());
            earning.add(earingList);
          } else {
            List<String> deductionList = [];
            deductionList.add(element.name!);
            deductionList.add(element.value!.toString());
            deductionList.add(element.earned!.toString());
            deduction.add(deductionList);
          }
        });
      });
    } else {
      setState(() {
        isEmpty = false;
        isRecordNotFound = true;
      });
    }
    stopProgress();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress Dialog Example',
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
      ),
      home: WillPopScope(
        onWillPop: () async {
          Fun.showExitConfirmationDialog(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red, // Change to your desired color
            title: Text('Download Salary Slip',style:GoogleFonts.roboto(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color:Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.download,color:Colors.white),
                onPressed: () {
                  if (!isEmpty) {
                    Pdf.downloadPdf(
                        sEmployeeName,
                        sEmployeeId,
                        sDateOfJoining,
                        sMonth,
                        sTotalPaidDays,
                        sDesignation,
                        sGrossEarningPotential,
                        sNetTakeHome,
                        sOrgName,
                        sAddress,
                        earning,
                        deduction);
                  } else {
                    Fun.showToast(" Salary Slip Not Available");
                  }
                },
              ),
            ],
          ),
          body: ProgressDialog(
              loading: loading,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                                  setState(() {
                                    sMonthName = TimeHandler.getYearName(
                                        TimeHandler.getLastMonth(currentDate));
                                    daysInMonth = DateTime(
                                            TimeHandler.getLastMonth(
                                                    currentDate)
                                                .year,
                                            TimeHandler.getLastMonth(
                                                        currentDate)
                                                    .month +
                                                1,
                                            0)
                                        .day;
                                    String sLastMonth = DateFormat('MM').format(
                                        TimeHandler.getLastMonth(currentDate));
                                    String sLastYear = DateFormat('yyyy')
                                        .format(TimeHandler.getLastMonth(
                                            currentDate));
                                    getSalaryResponce(sLastYear, sLastMonth);
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
                                    'assets/images/ic_attendance.png',
                                    // Replace with your icon's file path
                                    width: 20, // Set the width as needed
                                    height: 20, // Set the height as needed
                                    color: Colors
                                        .blue, // Customize the icon's color
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
                                  setState(() {
                                    sMonthName = TimeHandler.getYearName(
                                        TimeHandler.getNextMonth(currentDate));
                                    daysInMonth = DateTime(
                                            TimeHandler.getNextMonth(
                                                    currentDate)
                                                .year,
                                            TimeHandler.getNextMonth(
                                                        currentDate)
                                                    .month +
                                                1,
                                            0)
                                        .day;
                                    String sLastMonth = DateFormat('MM').format(
                                        TimeHandler.getNextMonth(currentDate));
                                    String sLastYear = DateFormat('yyyy')
                                        .format(TimeHandler.getNextMonth(
                                            currentDate));
                                    getSalaryResponce(sLastYear, sLastMonth);
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
                        visible:isRecordNotFound,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 250,
                                height: 250,
                                alignment: Alignment.center,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/img_comp_off.png'),
                                )),
                            Container(
                              alignment: Alignment.center,
                              child: Text('Record Not Found',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16)),
                            ),
                            ScreenWidget.disBetween(30),
                          ],
                        )),
                    Visibility(
                        visible: isEmpty,
                        child: Expanded(
                          child: InteractiveViewer(
                              boundaryMargin: EdgeInsets.all(20.0),
                              minScale: 0.1,
                              maxScale: 4.0,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(1.0),
                                            color: Colors.black,
                                            // Set the background color to black
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  color: Colors.red,
                                                  padding: EdgeInsets.all(0.5),
                                                  child: Text(
                                                    'Value',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 5.0),
                                                  ),
                                                ),
                                                Text(
                                                  'Innovation',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.white,
                                                      fontSize: 5.0),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 4),
                                                  child: Text(
                                                    'Labs',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 3.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 200),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            sOrgName,
                                            style: GoogleFonts.roboto(fontSize: 5),
                                          ),
                                          SizedBox(height: 15),
                                          Text(sAddress,
                                              style: GoogleFonts.roboto(fontSize: 5))
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    // Change the color if needed
                                    thickness:
                                        1, // Change the thickness of the line
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Employee ID",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                              Text(
                                                "Employee Name",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                              Text(
                                                "Date Of Joining",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 50),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(sEmployeeId,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                              Text(sEmployeeName,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                              Text(sDateOfJoining,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // SizedBox(width: 60),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Month",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                              Text(
                                                "Total Paid Day's",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                              Text(
                                                "Designation",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 30),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(sMonth,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                              Text(sTotalPaidDays,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                              Text(sDesignation,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: TableBorder.all(),
                                          children: List.generate(
                                            earning.length,
                                            (index) {
                                              return TableRow(
                                                decoration: BoxDecoration(
                                                  color: index == 0
                                                      ? Colors.black
                                                      : null, // Set black background for the first row
                                                ),
                                                children: List.generate(
                                                  earning[index].length,
                                                  (index2) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Center(
                                                        child: Text(
                                                          earning[index]
                                                              [index2],
                                                          style: GoogleFonts.roboto(
                                                            fontSize: 5.0,
                                                            color: index == 0
                                                                ? Colors.white
                                                                : Colors.black,
                                                            // Set white text for the first row
                                                            fontWeight: index ==
                                                                    0
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal, // Make text bold for the first row
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: 60),
                                      Expanded(
                                         child: Container(
                                           margin: EdgeInsets.only(left: 30),
                                           child: Table(
                                            border: TableBorder.all(),
                                            children: List.generate(
                                              deduction.length,
                                              (index) {
                                                return TableRow(
                                                  decoration: BoxDecoration(
                                                    color: index == 0
                                                        ? Colors.black
                                                        : null, // Set black background for the first row
                                                  ),
                                                  children: List.generate(
                                                    deduction[index].length,
                                                    (index2) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            deduction[index]
                                                                [index2],
                                                            style: GoogleFonts.roboto(
                                                              fontSize: 5.0,
                                                              color: index == 0
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                              // Set white text for the first row
                                                              fontWeight: index ==
                                                                      0
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .normal, // Make text bold for the first row
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                        ),
                                         ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  const Divider(
                                    color: Colors.black,
                                    // Change the color if needed
                                    thickness:
                                        1, // Change the thickness of the line
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 200),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Gross Earning Potential",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Net Take Home",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 5),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 50),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(sGrossEarningPotential,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                              SizedBox(height: 5),
                                              Text(sNetTakeHome,
                                                  style:
                                                      GoogleFonts.roboto(fontSize: 5)),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
