import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';

import '../../utils/constants.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class TeamLeaveApprovalP extends StatefulWidget {
  String arId;
  final Function() callback;

  TeamLeaveApprovalP({required this.arId, required this.callback});

  @override
  _TeamLeaveApprovalPState createState() => _TeamLeaveApprovalPState();
}

class _TeamLeaveApprovalPState extends State<TeamLeaveApprovalP> {
  String sComment = "";
  String sStatus = 'Approved';
  bool isProgress = false;
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.arId;
  }

  takeAction(approvalType, comment) async {
    setState(() {
      isProgress = true;
    });
    final Map<String, dynamic> body = {
      "leaveId": id,
      "statusId": approvalType,
      "comment": comment
    };
    bool isSuccess = await ApiHandler().teamLeaveApproval(body);
    if (isSuccess) {
      setState(() {
        isProgress = false;
      });
      widget.callback();
      Navigator.of(context).pop();
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
                        child:  Column(
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
                                    child:  Text(
                                      'Choose Type',
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
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
                                      "Status*",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButton(
                                value: sStatus,
                                items: Constants.lsApproveTypeP.map((option) {
                                  return DropdownMenuItem(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (selectedOption) {
                                  setState(() {
                                    sStatus = selectedOption!;
                                  });
                                },
                                hint: Text('Select an option'),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  // Use the icon property to customize the icon
                                  color: Colors
                                      .black, // Customize the icon color as needed
                                ),
                                iconSize: 24,
                                // Customize the icon size as needed
                                isExpanded:
                                true, // Allow the dropdown to take the full width
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Comment",
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
                                  sComment =
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
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    SColors.rozgarRed),
                              ),
                              onPressed: () {
                                if (sStatus == "Approved") {
                                  takeAction(1, sComment);
                                }else if (sStatus == 'Partially Approved') {
                                  takeAction(4, sComment);
                                } else {
                                  takeAction(2, sComment);
                                }
                              },
                              child: Text('Submit',style: GoogleFonts.roboto(color:Colors.white)),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
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
