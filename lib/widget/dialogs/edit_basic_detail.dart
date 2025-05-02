import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../api/api_handler.dart';
import '../../model/edit_basic_details.dart';
import '../../utils/constants.dart';
import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class EditBasicDetail extends StatefulWidget {
  String fatherName;
  String motherName;
  String nationality;
  String gmail;
  String gender;
  String martialStatus;
  String bloodGroup;
  String dob;
  final Function() callback;

  // final RefreshData? listener;

  EditBasicDetail(
      {required this.fatherName,
      required this.motherName,
      required this.nationality,
      required this.gmail,
      required this.gender,
      required this.martialStatus,
      required this.bloodGroup,
      required this.dob,
      required this.callback});

  @override
  _EditBasicDetailState createState() => _EditBasicDetailState();
}

class _EditBasicDetailState extends State<EditBasicDetail> {
  DateTime selectedDob = DateTime.now();
  String sGender = "Male";
  int iGenderIndex = 0;
  int iMartialStatusIndex = 0;
  int iBloodGroupIndex = 0;
  String sMartialStatus = "Married";
  String sBloodGroup = "A+";
  String sFatherName = "";
  String sMotherName = "";
  String sNationality = "";
  String sEmail = "";
  bool isProgress = false;

  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: DateTime(1900),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
      });
    }
  }



  late final TextEditingController _emailController;
  late final TextEditingController _fatherNameController;
  late final TextEditingController _motherNameController;
  late final TextEditingController _nationalityController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _emailController = TextEditingController(text: widget.gmail);
      _fatherNameController = TextEditingController(text: widget.fatherName);
      _motherNameController = TextEditingController(text: widget.motherName);
      _nationalityController = TextEditingController(text: widget.nationality);
      sFatherName = widget.fatherName;
      sMotherName = widget.motherName;
      sNationality = widget.nationality;
      sEmail = widget.gmail;
      sGender = widget.gender;
      sMartialStatus = widget.martialStatus;
      sBloodGroup = widget.bloodGroup;
      selectedDob = Fun.convertDate(widget.dob);
    });
  }

  Future<EditBasicDetailModel> setBasicDetails(
    String sFatherName,
    String sMotherName,
    String sNationality,
    String sDob,
    int sGenderId,
    int sMaritalStatusId,
    String sBloodGroupId,
    String sEmail,
  ) async {
    setState(() {
      isProgress = true;
    });
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    EditBasicDetailModel response = await ApiHandler().editBasicDetails({
      "fatherName": sFatherName,
      "motherName": sMotherName,
      "nationality": sNationality,
      "dateOfBirth": sDob,
      "genderId": sGenderId,
      "maritalStatusId": sMaritalStatusId,
      "bloodGroup": sBloodGroupId,
      "personalEmail": sEmail,
      "userId": id
    });
    bool isSuccess = response.status;
    if (isSuccess) {
      setState(() {
        isProgress = false;
      });
      Fun.showToast("Update Successfully");
      widget.callback();
      Navigator.of(context).pop();
    } else {
      setState(() {
        isProgress = false;
      });
      Fun.showToast("Something went Wrong!");
    }

    return response;
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
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Edit Basic Detail',
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
                                "Father Name",
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
                        controller: _fatherNameController,
                        // set controller
                        onChanged: (text) {
                          setState(() {
                            sFatherName =
                                text; // Update the value of _inputText
                          });
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: SColors.rozgarRed),
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
                                "Mother Name",
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
                        controller: _motherNameController,
                        // set controller
                        onChanged: (text) {
                          setState(() {
                            sMotherName =
                                text; // Update the value of _inputText
                          });
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: SColors.rozgarRed),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Nationality",
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
                        controller: _nationalityController,
                        // set controller
                        onChanged: (text) {
                          setState(() {
                            sNationality =
                                text; // Update the value of _inputText
                          });
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: SColors.rozgarRed),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Email",
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
                        controller: _emailController,
                        onChanged: (text) {
                          setState(() {
                            sEmail = text; // Update the value of _inputText
                          });
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: SColors.rozgarRed),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date of Birth*'),
                          Text('Gender*'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                    '${DateFormat('MMMM dd, yyyy').format(selectedDob)}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: Color(0xFF000000))),
                                onTap: () {
                                  _selectInDate(context);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                iconSize: 20,
                                tooltip: 'Tap to open date picker',
                                onPressed: () {
                                  _selectInDate(context);
                                },
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            initialValue: sGender,
                            itemBuilder: (BuildContext context) {
                              return Constants.lsGenderList
                                  .map((String option) {
                                return PopupMenuItem<String>(
                                  value: option,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    // Align items to the right
                                    child: Text(option),
                                  ),
                                );
                              }).toList();
                            },
                            onSelected: (String selectedOption) {
                              setState(() {
                                sGender = selectedOption;
                                iGenderIndex = Constants.lsGenderList
                                    .indexOf(selectedOption);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // Align the button to the right
                              children: [
                                Text(sGender),
                                // Display the selected value
                                Icon(Icons.arrow_drop_down),
                                // Add dropdown icon
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Martial Status'),
                          Text('Blood Group'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton(
                            value: sMartialStatus,
                            items: Constants.lsMartialStatusList.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (selectedOption) {
                              setState(() {
                                sMartialStatus = selectedOption!;
                                iMartialStatusIndex = Constants
                                    .lsMartialStatusList
                                    .indexOf(selectedOption);
                              });
                            },
                            hint: Text('Select an option'),
                          ),
                          PopupMenuButton<String>(
                            initialValue: sBloodGroup,
                            itemBuilder: (BuildContext context) {
                              return Constants.lsBloodGroupList
                                  .map((String option) {
                                return PopupMenuItem<String>(
                                  value: option,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    // Align items to the right
                                    child: Text(option),
                                  ),
                                );
                              }).toList();
                            },
                            onSelected: (String selectedOption) {
                              setState(() {
                                sBloodGroup = selectedOption;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // Align the button to the right
                              children: [
                                Text(sBloodGroup),
                                // Display the selected value
                                Icon(Icons.arrow_drop_down),
                                // Add dropdown icon
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              SColors.rozgarRed),
                        ),
                        onPressed: () {
                          if (sFatherName!.length == 0 ||
                              sMotherName!.length == 0 ||
                              sEmail!.length == 0 ||
                              sNationality!.length == 0) {
                            Fun.showToast("All fields are compulsory");
                          } else {
                            setBasicDetails(
                                sFatherName,
                                sMotherName,
                                sNationality,
                                selectedDob.toString(),
                                iGenderIndex + 1,
                                iMartialStatusIndex + 1,
                                sBloodGroup,
                                sEmail);
                          }
                        },
                        child: Text('Submit',
                            style: GoogleFonts.roboto(color: Colors.white)),
                      ),
                      SizedBox(height: 10),
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
