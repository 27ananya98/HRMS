import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import '../../utils/fun.dart';
import '../../utils/s_colors.dart';
class AddTaskMang extends StatefulWidget {
  final Function() callback;
  AddTaskMang(
      {
        required this.callback
      });

  @override
  _AddTaskMangState createState() => _AddTaskMangState();
}

class _AddTaskMangState extends State<AddTaskMang> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String sGender = "Male";
  int iGenderIndex = 0;
  int iMartialStatusIndex = 0;
  int iBloodGroupIndex = 0;
  String sMartialStatus = "Married";
  String sBloodGroup = "A+";
  String sProjectName = "";
  String sTaskName = "";
  String sNationality = "";
  String sPriority = "";
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
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Project",
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
                            onChanged: (text) {
                              setState(() {
                                sProjectName =
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
                                    "Task *",
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
                            onChanged: (text) {
                              setState(() {
                                sTaskName =
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
                                    "Description",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                      color: Colors.grey[700],
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
                              decoration: InputDecoration(
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
                                      color: Colors.grey[700],
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
                                  child: Text('Status *'),
                                ),
                                Container(
                                  child: Text('Estimated Hours'),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       TextField(
                          //         onChanged: (text) {
                          //           setState(() {
                          //             sPriority = text; // Update the value of _inputText
                          //           });
                          //         },
                          //       ),
                          //       TextField(
                          //         onChanged: (text) {
                          //           setState(() {
                          //             sPriority = text; // Update the value of _inputText
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 20),
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
                                            '${DateFormat('MMM dd, yyyy').format(startDate)}',
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
                                            '${DateFormat('MMM dd, yyyy').format(endDate)}',
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
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: BorderSide(
                                  color: SColors.rozgarRed,
                                  width: 2,
                                ),
                                padding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                elevation: 0,
                                primary: Colors.transparent,
                                onPrimary: SColors.rozgarRed,
                              ),
                              onPressed: () {
                                Fun.showToast("Submit");
                              },
                              child: Text('Submit',style: GoogleFonts.roboto(color:Colors.white)),
                            ),
                          ),
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
