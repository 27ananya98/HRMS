import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../api/api_handler.dart';
import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class EditWorkExp extends StatefulWidget {
  String jobProfile;
  String companyName;
  String remarks;
  int id;
  String? dobJoining;
  String? dobEnd;

  final Function() callback;

  EditWorkExp(
      {required this.id,
      required this.jobProfile,
      required this.companyName,
      required this.remarks, required this.dobJoining,
        required this.dobEnd,
      required this.callback});

  @override
  _EditWorkExpState createState() => _EditWorkExpState();
}

class _EditWorkExpState extends State<EditWorkExp> {
  DateTime selectedDob = DateTime.now();
  DateTime selectedOutDob = DateTime.now();
  String sJobProfile = "";
  String sCompanyName = "";
  String sSummary = "";
  int? iId;

  bool isProgress = false;
  late final TextEditingController _jobProfileController;
  late final TextEditingController _companyNameController;
  late final TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    sJobProfile = widget.jobProfile;
    sCompanyName = widget.companyName;
    sSummary = widget.remarks;
    iId = widget.id;
    _jobProfileController = TextEditingController(text: widget.jobProfile);
    _companyNameController = TextEditingController(text: widget.companyName);
    _remarksController = TextEditingController(text: widget.remarks);
    selectedDob = Fun.parseDateFromString(widget.dobJoining!);
    selectedOutDob = Fun.parseDateFromString(widget.dobEnd!);

  }

  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
      });
    }
  }

  Future<void> _selectOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedOutDob,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedOutDob) {
      setState(() {
        selectedOutDob = picked;
      });
    }
  }

  editWorkExperience(sId, sJobProfile, sSummary, sCompanyName, selectedDob,
      selectedOutDob) async {
    setState(() {
      isProgress = true;
    });
    try {
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      var sUserId = jsonMap['result']['id'];
      final Map<String, dynamic> body = {
        "id": sId,
        "userId": sUserId,
        "jobProfile": sJobProfile,
        "remarks": sSummary,
        "companyName": sCompanyName,
        "from": selectedDob.toString(),
        "to": selectedOutDob.toString()
      };
      bool isSuccess = await ApiHandler().addWorkExp(body);
      if (isSuccess) {
        setState(() {
          isProgress = false;
        });
        widget.callback();
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      Fun.showToast("Something went Wrong!");
    }
    setState(() {
      isProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.pop(context);
                                },
                                child: Align(
                                    alignment: Alignment.centerRight, // Aligns the child to the right side
                                    child:
                                    Container(
                                      width: 26, // Adjust the width as needed
                                      height: 26, // Adjust the height as needed
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5), // Half of the height or width for a circular shape
                                        border: Border.all(
                                          color: Colors.grey, // Border color
                                          width: 2.0, // Border width
                                        ),
                                        color: Colors.white, // Background color of the container
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: SColors.rozgarRed, // Icon color
                                          size: 20, // Adjust the icon size as needed
                                        ),
                                      ),
                                    )
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Experience Details',
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    ),
                                  ),
                                ],
                              )
                            ],),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Job Profile",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              // set controller
                              controller: _jobProfileController,
                              onChanged: (text) {
                                setState(() {
                                  sJobProfile =
                                      text; // Update the value of _inputText
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: SColors.rozgarRed),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Company Name",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              // set controller
                              controller: _companyNameController,
                              onChanged: (text) {
                                setState(() {
                                  sCompanyName =
                                      text; // Update the value of _inputText
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: SColors.rozgarRed),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Summary",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              controller: _remarksController,
                              onChanged: (text) {
                                setState(() {
                                  sSummary =
                                      text; // Update the value of _inputText
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: SColors.rozgarRed),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Date Of Join*'),
                                  ),
                                  Container(
                                    child: Text('Date Of Exit*'),
                                  ),
                                ],
                              ),
                            ),
                            Container( // Scroll horizontally
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child:  Row(
                                      children: <Widget>[
                                        InkWell(
                                          child: Text(
                                              '${DateFormat('MMM dd, yyyy').format(selectedDob)}',
                                              textAlign:
                                              TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  color: Color(
                                                      0xFF000000))),
                                          onTap: () {
                                            _selectInDate(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.calendar_today),
                                          iconSize: 20,
                                          tooltip:
                                          'Tap to open date picker',
                                          onPressed: () {
                                            _selectInDate(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    child:  Row(
                                      children: <Widget>[
                                        InkWell(
                                          child: Text(
                                              '${DateFormat('MMM dd, yyyy').format(selectedOutDob)}',
                                              textAlign:
                                              TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  color: Color(
                                                      0xFF000000))),
                                          onTap: () {
                                            _selectOutDate(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.calendar_today),
                                          iconSize: 20,
                                          tooltip:
                                          'Tap to open date picker',
                                          onPressed: () {
                                            _selectOutDate(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    SColors.rozgarRed),
                              ),
                              onPressed: () {
                                if (sJobProfile.length <= 3) {
                                  Fun.showToast(
                                      "Please Enter A valid Job Profile");
                                  return;
                                } else if (sCompanyName.length <= 4) {
                                  Fun.showToast(
                                      "Please Enter A valid Company Name");

                                  return;
                                } else if (sSummary.length < 5) {
                                  Fun.showToast("Please Enter A valid Summary");

                                  return;
                                } else {
                                  // print("-------------^----------------");
                                  // print(sJobProfile);
                                  // print(sCompanyName);
                                  // print(sSummary);
                                  // print(selectedDob);
                                  // print(selectedOutDob);
                                  // print("--------------V---------------");
                                  editWorkExperience(iId, sJobProfile, sSummary,
                                      sCompanyName, selectedDob, selectedOutDob);
                                }
                              },
                              child: Text('Submit',style: GoogleFonts.roboto(color:Colors.white)),
                            ),
                            SizedBox(height: 20),
                          ],
                        ) ,
                      ))),
            ),
            Center(
              child: Visibility(
                  visible: isProgress, child: Fun.getLoadingUICircular(context)),
            ),
          ],
        ),
      );

  }
}
