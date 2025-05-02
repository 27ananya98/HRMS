import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/time_handler.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/profile_response.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../utils/shared_preferences.dart';
import '../../../../../widget/dialogs/edit_basic_detail.dart';

class Basic extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<Basic>
    with AutomaticKeepAliveClientMixin<Basic> {
  String sFatherName = "--";
  String sMotherName = "--";
  String sMaritalStatus = "--";
  String sDOB = "--";
  String sNationality = "--";
  String sEmail = "--";
  String sBOG = "--";
  String sGender = "--";
  String sEmpId = "--";
  String sDOJ = "--";
  String sDOC = "--";
  String sDepartment = "--";
  String sDesignation = "--";
  String sEmpType = "--";
  String sRepManager = "--";
  String sWorkingLocation = "--";
  bool isProgressRunning = false;

  @override
  void initState() {
    super.initState();

    getEmployeeDetails();
  }

  getEmployeeDetails() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      int id = jsonMap['result']['id'];
      var response = await ApiHandler().getEmployeeDetailJ(id);
      Map<String, dynamic> jsonResponse = json.decode(response.toString());
      Map<String, dynamic>? basicDetails =
          jsonResponse['result']['basicDetail'];
      Map<String, dynamic>? workingDetail =
          jsonResponse['result']['workDetail'];
      if (basicDetails != null && workingDetail != null) {
        BasicDetail basicDetail = BasicDetail.fromJson(basicDetails);
        WorkDetail workDetail = WorkDetail.fromJson(workingDetail);
        setState(() {
          sFatherName = basicDetail.fatherName.toString();
          sMotherName = basicDetail.motherName.toString();
          sMaritalStatus = basicDetail.maritalStatus.toString();
          sDOB = TimeHandler.convertDate(basicDetail.dateOfBirth.toString());
          sNationality = basicDetail.nationality.toString();
          sEmail = basicDetail.personalEmail.toString();
          sBOG = basicDetail.bloodGroup.toString();
          sGender = basicDetail.gender.toString();
          sEmpId = workDetail.employeeId.toString();
          sDOJ = TimeHandler.convertDate(workDetail.dateOfJoining.toString());
          sDOC = workDetail.dateOfConfirmation.toString();
          sDepartment = workDetail.department.toString();
          sDesignation = workDetail.designation.toString();
          sEmpType = workDetail.employmentTypeName.toString();
          sRepManager = workDetail.reportingManagerName.toString();
          sWorkingLocation = workDetail.workLocation.toString();
        });
      }
    } catch (e) {
      setState(() {
        isProgressRunning = false;
      });
    }
    setState(() {
      isProgressRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // The first item will be at the start
                        Text('Personal Information',
                            style: GoogleFonts.roboto(
                                color: SColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),

                        // Wrap the two items you want at the end inside Expanded
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditBasicDetail(
                                    fatherName: sFatherName,
                                    motherName: sMotherName,
                                    nationality: sNationality,
                                    gmail: sEmail,
                                    gender: sGender,
                                    martialStatus:sMaritalStatus,
                                    bloodGroup: sBOG,
                                    dob: sDOB,
                                    callback: () {
                                      getEmployeeDetails();
                                    },
                                    // listener: widget.refresh,
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Icon(
                                    Icons.edit_note_outlined,
                                    color: SColors.rozgarRed,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Father Name",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Marital Status',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sFatherName,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(sMaritalStatus,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Mother Name',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Nationality',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sMotherName,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(sNationality,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Date Of Birth',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Email',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sDOB,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(sEmail,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Blood Group',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Gender',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.grey, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sBOG!,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(sGender!, textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text('Work Details',
                                  style: GoogleFonts.roboto(
                                      color: SColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Employee Id',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sEmpId,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              '',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Date of Joining',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Date of confirmation',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sDOJ,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                                sDOC != null && sDOC != "null" ? sDOC! : "--",
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Department',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Designation',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sDepartment,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(sDesignation,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Employment Type',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Reporting Manager',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sEmpType,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(sRepManager,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Working Location',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  color: SColors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sWorkingLocation!,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(''),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              )
            ],
          )),
        ),
        Visibility(
            visible: isProgressRunning,
            child: Fun.getLoadingUICircular(context)),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
