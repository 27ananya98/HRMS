import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:intl/intl.dart';

import '../../api/api_handler.dart';
import '../../model/attendance_drop_down.dart';
import '../../model/comp_off_approval_type.dart';
import '../../model/comp_off_ddm.dart';
import '../../utils/s_colors.dart';
import '../../utils/time_handler.dart';

class AddCompOff extends StatefulWidget {
  final Function() callback;

  AddCompOff({
    required this.callback,
  });
  @override
  _AddCompOffState createState() => _AddCompOffState();
}

class _AddCompOffState extends State<AddCompOff> {
  String sLeaveType = "Compensatory Off Leave";
  int selectedOptionIndex = 0;
  int selectAttendanceType = 0;
  int compOffApproveTypeIndex = 0;

  String sReason = "";
  bool isAttendanceListLoaded = false;
  bool isCompOffApproveTypeLoaded = false;
  int iDropDownMenuIndexNumber = 0;
  List<AttendanceDropDown> lsAttendanceType = <AttendanceDropDown>[];
  String sSelectedDate = "Select Date";
  List<String> attendanceList = <String>["Select Date"];
  List<String> compOffApproveType = <String>["Select Approval Type"];
  List<String> sLeaveTypeList = [
    'Compensatory Off Leave',
    'Leave Without Pay',
    'Restricted Holiday',
  ];
  bool isProgress = false;
  late DateTime currentDate;
  AddCompOffDdm? responseData;
  CompOffApprovalType? compOffResponseData;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    String sMonth = DateFormat('MM').format(currentDate);
    String sYear = DateFormat('yyyy').format(currentDate);
    getDropDownMenu(sMonth, sYear).then((value) => setState(() {
          attendanceList.clear();
          attendanceList = value.toSet().toList();
          isAttendanceListLoaded = true;
          isProgress = false;
        }));
    getCompOffApprovalType().then((value) => {
          setState(() {
            compOffApproveType.clear();
            compOffApproveType = value.toSet().toList();
            isCompOffApproveTypeLoaded = true;
            isProgress = false;
          })
        });
  }

  Widget getDropDownList() {
    try {
      return DropdownButton(
        value: attendanceList[selectedOptionIndex],
        items: attendanceList.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (selectedOption) {
          setState(() {
            selectedOptionIndex = attendanceList.indexOf(selectedOption!);
          });
        },
        hint: const Text('Select a value'),
        isExpanded: true,
        // Allow the dropdown to expand and show the full content
        selectedItemBuilder: (BuildContext context) {
          return attendanceList.map<Widget>((String item) {
            return Text(
              item.length > 20 ? '${item.substring(0, 20)}...' : item,
              style: GoogleFonts.roboto(fontSize: 16), // Adjust the font size as needed
            );
          }).toList();
        },
      );
    } catch (e) {
      // If an error occurs during the build, return an error widget
      return Container(
        child: const Text('No Data Available'),
      );
    }
  }

  Future<List<String>> getCompOffApprovalType() async {
    setState(() {
      isCompOffApproveTypeLoaded = false;
      isProgress = true;
    });
    List<String> compOffApproveType = <String>[];
    CompOffApprovalType response = await ApiHandler().getCompOffApprovalType();
    compOffApproveType.clear();
    response.result!.forEach((element) {
      compOffApproveType.add(element.name!);
    });
    setState(() {
      compOffResponseData = response;
    });
    setState(() {
      isProgress = false;
    });
    return compOffApproveType;
  }

  Future<List<String>> getDropDownMenu(sMonth, sYear) async {
    setState(() {
      isAttendanceListLoaded = false;
      isProgress = true;
    });
    List<String> attendanceList = <String>[];
    try {
      AddCompOffDdm response = await ApiHandler().getCompOffDdm(sMonth, sYear);
      attendanceList.clear();
      response.result!.forEach((ele) {
        if (ele.outTime != null) {
          String value =
              "${TimeHandler.getCompOffTime(ele.inTime.toString())}-${TimeHandler.getCompOffTime(ele.outTime.toString())}";
          attendanceList.add(value);
        }
      });
      setState(() {
        responseData = response;
      });
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      Navigator.of(context).pop();
    }
    return attendanceList;
  }

  addCompOff(attendanceId, comment, leaveTypeId) async {
    setState(() {
      isProgress = true;
    });
    try {
      final Map<String, dynamic> body = {
        "attendanceId": attendanceId,
        "comment": comment,
        "leaveTypeId": leaveTypeId,
      };
      bool isSuccess = await ApiHandler().addCompOff(body);
      if (isSuccess) {
        widget.callback();
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
    return Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                // Aligns the child to the right side
                                child: Container(
                                  width: 26, // Adjust the width as needed
                                  height: 26, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // Half of the height or width for a circular shape
                                    border: Border.all(
                                      color: Colors.grey, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    color: Colors
                                        .white, // Background color of the container
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.close,
                                      color: SColors.rozgarRed,
                                      // Icon color
                                      size:
                                          20, // Adjust the icon size as needed
                                    ),
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  'Compensatory Off Detail',
                                  style: GoogleFonts.roboto(
                                      color: SColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Comp-off request can be raised for current month only',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        child: Text('Approval Type *',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                          visible: isCompOffApproveTypeLoaded,
                          child: DropdownButton(
                            value: compOffApproveType[compOffApproveTypeIndex],
                            items: compOffApproveType.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (selectedOption) {
                              setState(() {
                                compOffApproveTypeIndex =
                                    compOffApproveType.indexOf(selectedOption!);
                              });
                            },
                            hint: const Text('Select a value'),
                            isExpanded: true,
                            // Allow the dropdown to expand and show the full content
                            selectedItemBuilder: (BuildContext context) {
                              return compOffApproveType
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
                        child: Text('Attendance *',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                       Visibility(
                          visible: isAttendanceListLoaded,
                          child: getDropDownList()),
                      SizedBox(height: 5),
                      Container(
                        child: Text('Reason',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.bold)
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
                              hintText: 'Reason for Comp-Off',
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
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  SColors.rozgarRed)),
                          onPressed: () async {
                            int lengthOfString = sReason.length;
                            if (lengthOfString < 1) {
                              Fun.showToast("Please give proper reason");
                              return;
                            } else if (!await Fun.checkInterNet()) {
                              Fun.showToast("No internet connection");
                              return;
                            }
                            addCompOff(
                                responseData!.result![selectedOptionIndex].id,
                                sReason,
                                compOffResponseData!
                                    .result![compOffApproveTypeIndex].id);
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ))),
          ),
          Center(
            child: Visibility(
                visible: isProgress, child: Fun.getLoader(context)),
          ),
        ],
      ),
    );
  }
}
