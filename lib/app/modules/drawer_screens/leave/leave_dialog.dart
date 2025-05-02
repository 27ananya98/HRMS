import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/leave_balance.dart';
import 'package:hrms/utils/fun.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_handler.dart';
import '../../../../utils/prefsKeys.dart';
import '../../../../utils/s_colors.dart';
import '../../../../utils/shared_preferences.dart';

class LeaveDiaolg extends StatefulWidget {
  final Future<LeaveBalance> response;

  LeaveDiaolg(this.response);

  @override
  _LeaveDiaolgState createState() => _LeaveDiaolgState();
}

class _LeaveDiaolgState extends State<LeaveDiaolg> {
  DateTime sFrom = DateTime.now();
  DateTime sTo = DateTime.now();
  String sReason = "";
  bool isRadioButtonVisible = true;
  bool isLeaveTypeLoaded = false;
  late LeaveBalance responseData;
  int? selectedValue;
  List<String> leaveType = <String>["Select Leave Type"];
  LeaveBalance? leaveBalanceResponseData;
  int leaveTypeIndex = 0;



  List<String> sLeaveTypeList = [
    'Casual Leave',
    'Compensatory Off Leave',
    'Sick Leave',
    'Restricted Holiday',
    'Leave Without Pay'
  ];
  bool isProgress = false;
  bool isChecked = false;
  num nNumberOfDays = 0;

  @override
  void initState() {
    super.initState();
    getData(widget.response);
    listLeaveBalance().then((value) => {
      setState(() {
        leaveType.clear();
        leaveType = value.toSet().toList();
        isLeaveTypeLoaded = true;
        isProgress = false;
      })
    });

    initialDate = DateTime.now();
    sFrom = DateTime(initialDate.year, initialDate.month, initialDate.day);
    sTo = DateTime(initialDate.year, initialDate.month, initialDate.day);
    nNumberOfDays = 0;
    isRadioButtonVisible = true;
    selectedValue = null;
  }

  Future<List<String>> listLeaveBalance() async {
    setState(() {
      isLeaveTypeLoaded = false;
      isProgress = true;
    });
    List<String> leaveType = <String>[];
    String value =
    await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    var id = jsonMap['result']['id'];
    String idString = id.toString();
    LeaveBalance response =
    await ApiHandler().getLeaveBalance(idString, "1", "50");
    leaveType.clear();
    response.result!.leaveTypeList!.forEach((element) {
      leaveType.add(element.name!);
    });
    setState(() {
      leaveBalanceResponseData = response;
    });
    setState(() {
      isProgress = false;
    });
    return leaveType;
  }
  getData(Future<LeaveBalance> response) async {
    responseData = await response;
  }

  late DateTime initialDate;

  Future<void> leaveTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != sTo) {
      setState(() {
        sTo = picked;
        nNumberOfDays = Fun.calculateDaysDifference(sFrom, sTo);
        if(sFrom == sTo){
          nNumberOfDays = 0;
          isRadioButtonVisible = true;
          selectedValue = null;
        }else{
          isRadioButtonVisible = false;
        }
      });
    }
  }

  Future<void> leaveFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sFrom,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != sFrom) {
      setState(() {
        sFrom = picked;
        nNumberOfDays = Fun.calculateDaysDifference(sFrom, sTo);
        if(sFrom == sTo){
          nNumberOfDays = 0;
          isRadioButtonVisible = true;
          selectedValue = null;
        }else{
          isRadioButtonVisible = false;
        }
      });
    }
  }

  addLeaveRequest(sFrom, sTo, sReason, iLaveTypeId, nNumberOfDays) async {
    setState(() {
      isProgress = true;
    });
    try {
      bool isSucces = await ApiHandler()
          .addLeaveRequest(sFrom, sTo, sReason, iLaveTypeId, nNumberOfDays);
      if (isSucces) {
        setState(() {
          isProgress = false;
        });
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
    return Container(
        margin: EdgeInsets.all(16),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text(
                                    'Leave Application Form',
                                    style: GoogleFonts.roboto(
                                        color: SColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],),
                          SizedBox(height: 30),
                          Container(
                            child: Text('Leave Type',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 10),
                          Visibility(
                              visible: isLeaveTypeLoaded,
                              child: DropdownButton(
                                value: leaveType[leaveTypeIndex],
                                items: leaveType.map((option) {
                                  return DropdownMenuItem(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (selectedOption) {
                                  setState(() {
                                    leaveTypeIndex =
                                        leaveType.indexOf(selectedOption!);
                                  });
                                },
                                hint: const Text('Select a value'),
                                isExpanded: true,
                                // Allow the dropdown to expand and show the full content
                                selectedItemBuilder: (BuildContext context) {
                                  return leaveType
                                      .map<Widget>((String item) {
                                    return Text(
                                      item.length > 20
                                          ? '${item.substring(0, 20)}...'
                                          : item,
                                      style: GoogleFonts.roboto(
                                          fontSize:
                                          16), // Adjust the font size as needed
                                    );
                                  }).toList();
                                },
                              )),

                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'From',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  color: SColors.black,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                          '${DateFormat('MMMM dd, yyyy').format(sFrom)}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Color(0xFF000000))),
                                      onTap: () {
                                        leaveFrom(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        leaveFrom(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'To',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  color: SColors.black,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                          '${DateFormat('MMMM dd, yyyy').format(sTo)}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Color(0xFF000000))),
                                      onTap: () {
                                        leaveTo(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        leaveTo(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Number of Day',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: SColors.black,
                                fontSize: 14),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: isRadioButtonVisible,
                                // Show the container if nNumberOfDays is 0
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Radio<int>(
                                                  value: 1,
                                                  groupValue: selectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nNumberOfDays = 1;
                                                      selectedValue = value;
                                                    });
                                                  },
                                                ),
                                                Text('1 day',style: GoogleFonts.roboto(),),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Radio<int>(
                                                  value: 2,
                                                  groupValue: selectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nNumberOfDays = 0.5;
                                                      selectedValue = value;
                                                    });
                                                  },
                                                ),
                                                Text('0.5 day',style: GoogleFonts.roboto(),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: sFrom != sTo,
                                // Show the container if nNumberOfDays is not 0
                                child: Container(
                                  child: Text(
                                    nNumberOfDays.toString(),
                                    style: GoogleFonts.roboto(
                                      decoration: TextDecoration
                                          .underline, // Add the underline decoration
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Text(
                              'Reason',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  color: SColors.black,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextField(
                                onChanged: (text) {
                                  setState(() {
                                    sReason = text;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Reason for leave',
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
                            ),
                          ),
                          SizedBox(height: 10),
                          CheckboxListTile(
                            title: Text(
                              'I certify that information given in this form is true and correct to best of my knowledge.',
                              style: GoogleFonts.roboto(fontSize: 11),
                            ),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        SColors.rozgarRed)),
                            onPressed: () async {
                              int lengthOfString = sReason.length;
                              num? totalLeaves = responseData.result
                                  ?.leaveTypeList![leaveTypeIndex].total;
                              num? usedLeaves = responseData.result
                                  ?.leaveTypeList![leaveTypeIndex].used;
                              num? result = totalLeaves! - usedLeaves!;
                              if (nNumberOfDays > result) {
                                Fun.showToast(
                                    "Sorry you don't have enough leaves");
                                return;
                              } else if (nNumberOfDays == 0) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Alert!', style: GoogleFonts.roboto(),),
                                      content: Text(
                                          'Please select an option.', style: GoogleFonts.roboto(),),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK',style: GoogleFonts.roboto(),),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              } else if (!isChecked) {
                                Fun.showToast("Please select checkbox button");
                                return;
                              } else if (lengthOfString < 1) {
                                Fun.showToast("Please give proper reason");
                                return;
                              } else if (!await Fun.checkInterNet()) {
                                Fun.showToast("No internet connection");
                                return;
                              }
                              addLeaveRequest(
                                  sFrom.toString(),
                                  sTo.toString(),
                                  sReason,
                                  leaveBalanceResponseData!.result!.leaveTypeList![leaveTypeIndex].id,
                                  nNumberOfDays);
                            },
                            child: Text('Submit',style: GoogleFonts.roboto(
                                color: SColors.white,
                                ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Visibility(
                        visible: isProgress,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 200,
                            color: SColors.white.withOpacity(0.8),
                            child: const Center(
                                heightFactor: 5.0,
                                widthFactor: 5.0,
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        color: SColors.smashedPumpkin,
                                        valueColor: AlwaysStoppedAnimation(
                                            SColors.smashedPumpkin)))))),
                  ],
                )),
          ),
        ));
  }
}
