import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/approval_types.dart';
import 'package:hrms/model/attendance_report_m.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_handler.dart';
import '../../../../model/shift_type.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/dialogs/custom_time_picker_dialog.dart';

class RegularizationDialog extends StatefulWidget {
  final Function() callback;
  RegularizationDialog(this.callback);
  @override
  _RegularizationDialogState createState() => _RegularizationDialogState();
}

class _RegularizationDialogState extends State<RegularizationDialog> {
  DateTime inDate = DateTime.now();
  DateTime outDate = DateTime.now();
  TimeOfDay? inTime;
  TimeOfDay? outTime;
  String sReason = "";
  bool isProgress = false;
  String _selectedShift = "General shift";
  final List<String> _shiftList = ['General shift', 'US Shift'];

  String _selectedAttendanceType = "Office";
  final List<String> _attendanceTypeList = ['Office', "Work From Home"];
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }


  getShiftList() async {
    ShiftType response = await ApiHandler().getShiftType();
    ApprovalTypes approvalResponce = await ApiHandler().getApprovalTypes();
    AttendanceReportM attendanceReportResponse = await ApiHandler().getMonthlyHistory("04", "2023");
  }

  Future<void> _selectOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: outDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != outDate) {
      setState(() {
        outDate = picked;
      });
    }
  }

  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: inDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != inDate) {
      setState(() {
        inDate = picked;
      });
    }
  }

  Future<void> _selectInTime(BuildContext context, {bool useCustomPicker = true}) async {
    TimeOfDay? picked;

    if (useCustomPicker) {
      picked = await showDialog<TimeOfDay>(
        context: context,
        builder: (BuildContext context) {
          return CustomTimePickerDialog(
            initialHour: inTime?.hourOfPeriod ?? 1, // Hour in 12-hour format
            initialMinute: inTime?.minute ?? 0,
            initialPeriod: inTime?.period == DayPeriod.pm ? 'PM' : 'AM',
          );
        },
      );
    } else {
      picked = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
      );
    }

    if (picked != null && picked != inTime) {
      setState(() {
        inTime = picked;
      });
      print("Selected time: ${picked.format(context)}");
    }
  }



  Future<void> _selectOutTime(BuildContext context, {bool useCustomPicker = true}) async {
    TimeOfDay? picked;
    if (useCustomPicker) {
      picked = await showDialog<TimeOfDay>(
        context: context,
        builder: (BuildContext context) {
          return CustomTimePickerDialog(
            initialHour: outTime?.hourOfPeriod ?? 1, // Hour in 12-hour format
            initialMinute: outTime?.minute ?? 0,
            initialPeriod: outTime?.period == DayPeriod.pm ? 'PM' : 'AM',
          );
        },
      );
    } else {
      picked = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
      );
    }
    if (picked != null && picked != outTime) {
      setState(() {
        outTime = picked;
      });
      print("Selected time: ${picked.format(context)}");
    }
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
                        padding: EdgeInsets.only(bottom: 20,left: 20,right: 20),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
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
                                    margin: EdgeInsets.only(),
                                    child: Text(
                                      'Attendance Regularization',
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              )
                            ],),
                            SizedBox(height: 16),
                            Text(
                              'A regularization Request can be raised only for current month',
                              style: GoogleFonts.roboto(
                                fontSize: 12),textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Shift',style: GoogleFonts.roboto(),
                                    ),
                                  ),
                                  Container(
                                    child: Text('Attendance Type',
                                        style: GoogleFonts.roboto(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: DropdownButton(
                                      value: _selectedShift,
                                      items: _shiftList.map((option) {
                                        return DropdownMenuItem(
                                          value: option,
                                          child: Text(
                                            option,
                                            style: GoogleFonts.roboto(
                                                color: SColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12), // Adjust the fontSize as needed
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (selectedOption) {
                                        setState(() {
                                          _selectedShift = selectedOption!;
                                        });
                                      },
                                      hint: Text('Select an option'),
                                    ),
                                  ),
                                  DropdownButton(
                                    value: _selectedAttendanceType,
                                    items: _attendanceTypeList.map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(
                                          option,
                                          style: GoogleFonts.roboto(
                                              color: SColors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12), // Adjust the fontSize as needed
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (selectedOption) {
                                      setState(() {
                                        _selectedAttendanceType = selectedOption!;
                                      });
                                    },
                                    hint: Text('Select an option'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('In Date',style: GoogleFonts.roboto(),),
                                Text('In Time',style: GoogleFonts.roboto(),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(DateFormat('MMM dd, yyyy').format(inDate),
                                          textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            color: Color(0xFF000000),
                                        ),
                                      ),
                                      onTap: () {
                                        _selectInDate(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        _selectInDate(context);
                                      },
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () => _selectInTime(context),
                                  child: Text(
                                    inTime != null ? TimeHandler.getTimeFormat(inTime!) : 'Select Time',
                                    style: GoogleFonts.roboto(
                                        color: SColors.rozgarRed, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Out Date'),
                                Text('Out Time'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                          DateFormat('MMM dd, yyyy').format(outDate),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: const Color(0xFF000000))),
                                      onTap: () {
                                        _selectOutDate(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        _selectOutDate(context);
                                      },
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () => _selectOutTime(context),
                                  child: Text(
                                    outTime != null ? TimeHandler.getTimeFormat(outTime!)  : 'Select Time',
                                    style: GoogleFonts.roboto(
                                        color: SColors.rozgarRed, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reason',
                                ),
                                Text(''),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      sReason = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Reason for AR',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: SColors.rozgarRed,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      SColors.rozgarRed)),
                              onPressed: () async {
                                if (Fun.calculateDaysDifference(inDate, outDate) < 0) {
                                  Fun.showToast("Please select proper date and time");
                                  return;
                                }
                                bool isTimeValid = inTime != null && outTime != null && TimeHandler.isTimeDifferenceValid(inTime!, outTime!);
                                if (!isTimeValid) {
                                  Fun.showToast("Please select a valid time, ensuring the duration is at least 4 hours.");
                                  return;
                                }
                                if (_selectedShift != "General shift") {
                                  Fun.showToast("Please select general shift");
                                  return;
                                }
                                if (sReason.length < 2) {
                                  Fun.showToast("Please enter a valid reason for the AR.");
                                  return;
                                }
                                setState(() {
                                  isProgress = true;
                                });
                                try {
                                  String formattedInTime = Fun.formatDateAndTime(context, inDate, inTime!).toString();
                                  String formattedOutTime = Fun.formatDateAndTime(context, outDate, outTime!).toString();
                                  bool isSuccess = await ApiHandler().addAR("", "1", sReason, formattedInTime, formattedOutTime, "1");
                                  if (isSuccess) {
                                    widget.callback();
                                    Navigator.of(context).pop();
                                  } else {
                                    Fun.showToast("Something went wrong!");
                                  }
                                } catch (e) {
                                  Fun.showToast("Something went wrong!");
                                } finally {
                                  setState(() {
                                    isProgress = false;
                                  });
                                }
                              },
                              child: Text('Submit',style: GoogleFonts.roboto(
                                  color: SColors.white,),
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
