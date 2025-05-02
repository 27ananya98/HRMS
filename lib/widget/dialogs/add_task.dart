import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class AddTask extends StatefulWidget {
  final Function() callback;
  AddTask(
      {
        required this.callback
      });

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime? startDate ;
  DateTime? endDate;
  String sGender = "Male";
  int iGenderIndex = 0;
  int iMartialStatusIndex = 0;
  int iBloodGroupIndex = 0;
  String sMartialStatus = "Married";
  String sBloodGroup = "A+";
  String sProjectName = "";
  String sTaskName = "";
  String sDescription = "";
  String sNationality = "";
  String sPriority = "";
  String sStatus = "";
  String sEstimateHours = "";
  bool isProgress = false;
  String? selectedFilePath;
  String? sFileName;

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }


  selectFile() {
    Fun.selectFile().then((value) => {
      setState(() {
        sFileName = Fun.truncateAndAddEllipsis(path.basename(value));
        selectedFilePath = value;
      })
    });
  }
  Future<void> _EndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  alignment: Alignment.topRight, // Aligns the child to the right side
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
                                  child: Text(
                                    'Add Task Details',
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
                                  child: Text(
                                    "Project",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                      color: SColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                sProjectName =
                                    text; // Update the value of _inputText
                              });
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SColors.black),
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
                                    "Task *",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                      color: SColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                sTaskName =
                                    text; // Update the value of _inputText
                              });
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SColors.black),
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
                                    "Description",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                      color: SColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  sDescription = text; // Update the value of _inputText
                                });
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter text',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Priority *",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                      color: SColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                sPriority = text; // Update the value of _inputText
                              });
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SColors.black),
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
                                  child: Text('Status *'),
                                ),
                                Container(
                                  child: Text('Estimated Hours'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (text) {
                                    setState(() {
                                      sStatus = text;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (text) {
                                    setState(() {
                                      sEstimateHours = text;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text('Start Date'),
                                ),
                                Container(
                                  child: Text('End Date'),
                                ),
                              ],
                            ),
                          ),
                          Container(// Scroll horizontally
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                            startDate == null
                                                ? 'MMM-dd-yyyy'
                                                : '${DateFormat('MMM dd, yyyy').format(startDate!)}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                color: Color(0xFF000000))),
                                        onTap: () {
                                          _startDate(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        iconSize: 20,
                                        tooltip: 'Tap to open date picker',
                                        onPressed: () {
                                          _startDate(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                            endDate == null
                                                ? 'MMM-dd-yyyy'
                                                : '${DateFormat('MMM dd, yyyy').format(endDate!)}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                color: Color(0xFF000000))),
                                        onTap: () {
                                          _EndDate(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        iconSize: 20,
                                        tooltip: 'Tap to open date picker',
                                        onPressed: () {
                                          _EndDate(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text('Upload File'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectFile();
                                    // Handle the click action here
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Choose File',
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        // Set text color to white
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(sFileName != null
                                      ? sFileName!
                                      : 'No file selected'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      SColors.rozgarRed)),
                              onPressed: () {
                                if (sProjectName.length <2) {
                                  Fun.showToast("Please give proper project name");
                                  return;
                                }else if (sTaskName.length<2){
                                  Fun.showToast("Please give proper task name");
                                  return;
                                }else if (sPriority.length<2){
                                  Fun.showToast("Please give proper priority");
                                  return;
                                }else if (sStatus.length<2){
                                  Fun.showToast("Please give proper status");
                                  return;
                                }else if (sEstimateHours.length<2){
                                  Fun.showToast("Please give proper Estimate Hours");
                                  return;
                                }else if (sDescription.length<2){
                                  Fun.showToast("Please give proper description");
                                  return;
                                } if (selectedFilePath == null) {
                                  Fun.showToast("Please Enter A valid Profile");
                                }else{
                                  Fun.showToast("Submit Successfully");
                                  print(sProjectName);
                                  print(sTaskName);
                                  print(sPriority);
                                  print(sStatus);
                                  print(sEstimateHours);
                                }
                              },
                              child: Text('Submit', style: GoogleFonts.roboto(color: Colors.white)),
                            ),
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
