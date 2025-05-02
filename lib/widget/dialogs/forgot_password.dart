import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';

import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController phController = TextEditingController();
  String sDocumentNumber = "";
  bool isProgress = false;

  @override
  void initState() {
    super.initState();
  }

  forgetPassword(number) async {
    setState(() {
      isProgress = true;
    });
    try {
      await ApiHandler().forgetPassword(number).then((value) {
        if (value == true) {
          Navigator.of(context).pop();
          Fun.showDefaultDialog("Password Reset Email Sent",
              "Mail has been sent with instructions to reset password. Please do the needful.");
        }
      });
    } catch (e) {
      setState(() {
        isProgress = false;
      });
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
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                                alignment: Alignment.centerRight,
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
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      color: SColors.rozgarRed, // Icon color
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
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Forgot password',
                                  style: GoogleFonts.roboto(
                                      color: SColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Phone No*",
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
                        keyboardType: TextInputType.number,
                        controller: phController,
                        maxLength: 10,
                        onChanged: (text) {
                          setState(() {
                            sDocumentNumber =
                                text.replaceAll(RegExp(r'[^0-9]'), '');
                            phController.text = sDocumentNumber;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              SColors.rozgarRed),
                        ),
                        onPressed: () {
                          if (sDocumentNumber.length <= 3) {
                            Fun.showToast("Please Enter A valid Number");
                            return;
                          }
                          {
                            forgetPassword(sDocumentNumber.toString());
                          }
                        },
                        child: Text('Submit',
                            style: GoogleFonts.roboto(color: Colors.white)),
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
