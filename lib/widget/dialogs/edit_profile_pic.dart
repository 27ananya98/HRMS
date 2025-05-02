import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:path/path.dart' as path;

import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class EditProfilePic extends StatefulWidget {
  final Function() callback;
  EditProfilePic({required this.callback});

  @override
  _EditProfilePicState createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  String? selectedFilePath;
  String? sFileName;
  bool isProgress = false;

  @override
  void initState() {
    super.initState();
  }

  updateProfilePic(userDoc, sFileName) async {
    setState(() {
      isProgress = true;
    });
    try {
      String value = await AppPreferences.shared
          .getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      var sUserId = jsonMap['result']['id'];
      FormData formData = FormData.fromMap({
        "userId": sUserId,
        "file": await MultipartFile.fromFile(
          userDoc.path,
          filename: sFileName,
        ),
      });
      bool isSucces = await ApiHandler().editProfilePic(formData);
      if (isSucces) {
        setState(() {
          isProgress = false;
        });
        widget.callback();
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

  selectImage() {
    Fun.selectImage().then((value) => {
      setState(() {
        if (value == "null") {
          Fun.showToast("No file selected");
        } else if (value == "exceeds") {
          Fun.showToast("File size exceeds 2 MB");
        } else {
          sFileName = path.basename(value);
          selectedFilePath = value;
        }
      })
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
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: SColors.rozgarRed,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Select Profile Image',
                              style: GoogleFonts.roboto(
                                color: SColors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      selectedFilePath != null
                          ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(selectedFilePath!)),
                      )
                          : Icon(Icons.person, size: 80, color: Colors.grey),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectImage();
                                // Handle the click action here
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Select Profile',
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
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            backgroundColor: SColors.rozgarRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (selectedFilePath == null) {
                              Fun.showToast(
                                  "Please select a valid profile picture");
                            } else {
                              File file = File(selectedFilePath!);
                              updateProfilePic(file, sFileName);
                            }
                          },
                          child: Text(
                            'Upload',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: isProgress,
              child: CircularProgressIndicator(
                color: SColors.rozgarRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
