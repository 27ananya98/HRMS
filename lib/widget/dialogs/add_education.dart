import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_handler.dart';
import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class AddEducation extends StatefulWidget {
  final Function() callback;
  AddEducation({required this.callback});
  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  String sInstitueName = "";
  String sPercentage = "";
  String sStartYear = "";
  String sEndYear = "";
  String sDegree = "";
  bool isProgress = false;


  @override
  void initState() {
    super.initState();
  }

  addEducationDetails(sDegree, sInstitueName, sPercentage, sStartYear,
      sEndYear) async {
    setState(() {
      isProgress = true;
    });
    try {
      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      var sUserId = jsonMap['result']['id'];
      final Map<String, dynamic> body = {
        "userId": sUserId,
        "course": sDegree,
        "institute": sInstitueName,
        "marks": sPercentage,
        "startYear": sStartYear,
        "endYear": sEndYear
      };
      bool isSuccess = await ApiHandler().addEducationDetail(body);
      if (isSuccess) {
        setState(() {
          isProgress = false;
        });
        widget.callback();
        Navigator.of(context).pop();
      }
    }catch (e) {
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
                  decoration: const BoxDecoration(
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
                                      child: const Center(
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
                                      'Education Detail',
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
                                      "Degree/Diploma",
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
                              onChanged: (text) {
                                setState(() {
                                  sDegree =
                                      text; // Update the value of _inputText
                                });
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SColors.rozgarRed),
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
                                      "Institute Name",
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
                              onChanged: (text) {
                                setState(() {
                                  sInstitueName =
                                      text; // Update the value of _inputText
                                });
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SColors.rozgarRed),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        sPercentage = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Percentage/Grade'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        sStartYear = value;
                                      });
                                    },
                                    decoration:
                                    InputDecoration(labelText: 'Start year'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        sEndYear = value;
                                      });
                                    },
                                    decoration:
                                    InputDecoration(labelText: 'End Year'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    SColors.rozgarRed),
                              ),
                              onPressed: () {
                                if (sDegree.length <= 4) {
                                  Fun.showToast(
                                      "Please Enter A valid Degree Name");
                                  return;
                                } else if (sInstitueName.length <= 4) {
                                  Fun.showToast(
                                      "Please Enter A valid Institute Name");

                                  return;
                                } else if (sPercentage.length < 2) {
                                  Fun.showToast(
                                      "Please Enter A valid Percentage");

                                  return;
                                } else if (sStartYear.length < 2) {
                                  Fun.showToast(
                                      "Please Enter A valid Start Year");
                                  return;
                                } else if (sEndYear.length < 2) {
                                  Fun.showToast("Please Enter A valid End Year");
                                } else {
                                  // print("-------------^----------------");
                                  // print(sDegree);
                                  // print(sInstitueName);
                                  // print(sPercentage);
                                  // print(sStartYear);
                                  // print(sEndYear);
                                  // print("--------------V---------------");
                                  addEducationDetails(
                                      sDegree, sInstitueName, sPercentage,
                                      sStartYear, sEndYear);
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
    ;
  }
}
