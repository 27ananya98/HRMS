import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/profile_response.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/shared_preferences.dart';

class Bank extends StatefulWidget {
  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<Bank>
    with AutomaticKeepAliveClientMixin<Bank> {
  bool isProgressRunning = false;
  String sAccountNumber = "--";
  String sAccountType = "--";
  String sBankName = "--";
  String sBranchName = "--";
  String sISCCode = "--";

  @override
  void initState() {
    super.initState();
    getEmployeeDetails();
  }

  Future getEmployeeDetails() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      int id = jsonMap['result']['id'];
      var response = await ApiHandler().getEmployeeDetailJ(id);
      setState(() {
        Map<String, dynamic> jsonResponse = json.decode(response.toString());
        Map<String, dynamic>? bankDetailJson =
            jsonResponse['result']['bankDetail'];
        if (bankDetailJson != null) {
          BankDetail bankDetail = BankDetail.fromJson(bankDetailJson);
          sAccountNumber = bankDetail.accountNumber!;
          sAccountType = bankDetail.accountType!;
          sBankName = bankDetail.bankName!;
          sBranchName = bankDetail.branchName!;
          sISCCode = bankDetail.branchCode!;
        }
      });
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
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Bank Details',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold),
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
                              "Account Number",
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
                            child: Text(
                              sAccountNumber,
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
                              'Account Type',
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
                            child:
                                Text(sAccountType, textAlign: TextAlign.left),
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
                              'Bank Name',
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
                            child: Text(
                              sBankName,
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
                              'Branch Name',
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
                            child: Text(
                              sBranchName,
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
                              'IFSC Code',
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
                            child: Text(
                              sISCCode,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          )),
        ),
        Visibility(
            visible: isProgressRunning,
            child: Fun.getLoadingUICircular(context))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
