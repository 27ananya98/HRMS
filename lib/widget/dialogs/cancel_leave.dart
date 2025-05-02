import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_handler.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class CancelLeave extends StatefulWidget {
  int? id;

  CancelLeave(this.id);

  @override
  _CancelLeaveState createState() => _CancelLeaveState();
}

class _CancelLeaveState extends State<CancelLeave> {
  bool isProgress = false;
  String inputText = '';
  int? id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  cancelLeaveRequest(id, comment) async {
    setState(() {
      isProgress = true;
    });
    try {
      final Map<String, dynamic> body = {"comment": comment, "leaveId": id};
      bool isSuccess = await ApiHandler().cancelLeaveRequest(body);
      if (isSuccess) {
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
                            Text(
                              'Request Cancellation',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              onChanged: (value) {
                                inputText = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Reason *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                      color: SColors.rozgarRed,
                                      width: 2,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    elevation: 0,
                                    primary: Colors.transparent,
                                    onPrimary: SColors.rozgarRed,
                                  ),
                                  child: Text('Cancel'),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    if (inputText.isNotEmpty) {
                                      cancelLeaveRequest(id, inputText);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Validation Error'),
                                            content:
                                            Text('Please enter some text.'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                  side: BorderSide(
                                                    color: SColors.rozgarRed,
                                                    width: 2,
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                                  elevation: 0,
                                                  primary: Colors.transparent,
                                                  onPrimary: SColors.rozgarRed,
                                                ),
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                      color: SColors.rozgarRed,
                                      width: 2,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    elevation: 0,
                                    primary: Colors.transparent,
                                    onPrimary: SColors.rozgarRed,
                                  ),
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                            SizedBox(height: 20)
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
