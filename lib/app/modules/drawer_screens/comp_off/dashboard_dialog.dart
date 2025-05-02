import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/s_colors.dart';

class DashboardDialog extends StatefulWidget {
  @override
  _DashboardDialogState createState() => _DashboardDialogState();
}

class _DashboardDialogState extends State<DashboardDialog> {
  DateTime sFrom = DateTime.now();
  DateTime sTo = DateTime.now();
  String sAttendanceDate = "Select Type Approval";
  String sAttendance = "April 1";
  String sReason = "";
  List<String> lsAttendanceDate = [
    'Select Type Approval',
    'Compensatory off Leave',
    'Leave Without Pay',
    "Restricted Holidays"
  ];
  List<String> lsAttendance = [
    'April 1',
    'April 2',
    'April 3',
    'April 4',
    "April 5"
  ];
  bool isChecked = false;
  String sNumberOfDays = "0";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        child: Scaffold(
          backgroundColor: SColors.rozgarRed,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 40.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Compensatory off Detail',
                      style: GoogleFonts.roboto(
                          color: SColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 23),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Comp-off request can be raised for current month only',
                          style: GoogleFonts.roboto(fontSize: 12),

                        ),
                        SizedBox(height: 40),
                        Container(
                          child: Text('Attendance Date',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: DropdownButton(
                            value: sAttendanceDate,
                            items: lsAttendanceDate.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (selectedOption) {
                              setState(() {
                                sAttendanceDate = selectedOption!;
                              });
                            },
                            hint: Text('Select an option'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Text('Attendance',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),

                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: DropdownButton(
                            value: sAttendance,
                            items: lsAttendance.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (selectedOption) {
                              setState(() {
                                sAttendance = selectedOption!;
                              });
                            },
                            hint: Text('Select an option'),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text('Reason', style: GoogleFonts.roboto(
                              fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              sReason = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Reason for comp-off',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                color: SColors.rozgarRed,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            print(sAttendanceDate);
                            print(sAttendance);
                            print(sReason);
                          },
                          child: Text('Submit',style: GoogleFonts.roboto(),
                        ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
