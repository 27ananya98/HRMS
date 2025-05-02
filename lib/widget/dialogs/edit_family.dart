import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../api/api_handler.dart';
import '../../utils/constants.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class EditFamilyDetail extends StatefulWidget {
  String sId;
  String sRelation;
  String fullName;
  String email;
  String number;
  String dob;
  final Function() callback;
  EditFamilyDetail(
      {required this.sId,required this.sRelation,required this.fullName,required this.email,required this.number,required this.dob,required this.callback});

  @override
  _EditFamilyDetailState createState() => _EditFamilyDetailState();
}

class _EditFamilyDetailState extends State<EditFamilyDetail> {
  DateTime selectedDob = DateTime.now();
  String sGender = "Male";
  int iGenderIndex = 0;
  int iEmergencyContactIndex = 0;
  int iIsDependentIndex = 0;
  String sContactNumber = "";
  int iBloodGroupIndex = 0;
  String sEmergencyContact = "Yes";
  String sIsDependant = "Yes";
  String sRelationship = "";
  String sFullName = "";
  String sNationality = "";
  String sEmail = "";
  bool isProgress = false;
  String? sId;
  late final TextEditingController _relationshipController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController numberController;

  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: DateTime(1947),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sId = widget.sId;
    sRelationship = widget.sRelation;
    sFullName = widget.fullName;
    sEmail = widget.email;
    sContactNumber = widget.number;
    _relationshipController = TextEditingController(text: widget.sRelation);
    _emailController = TextEditingController(text: widget.email);
    numberController = TextEditingController(text: widget.number);
    _fullNameController = TextEditingController(text: widget.fullName);
    selectedDob = Fun.convertDate(widget.dob);

  }

  deleteFamilyDetails(id) async {
    setState(() {
      isProgress = true;
    });
    try {
      bool isSuccess = await ApiHandler().deleteFamilyDetail(id.toString());
      if (isSuccess) {
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

  EditFamilyDetails(sFullName, id, sRelationship, sContactNumber,
      iEmergencyContactIndex, selectedDob, sEmail, iIsDependentIndex) async {
    setState(() {
      isProgress = true;
    });
    try {
      bool isSuccess = await ApiHandler().updateFamilyDetail(
          sFullName,
          id,
          sRelationship,
          sContactNumber,
          Fun.checkSelectedStatus(iEmergencyContactIndex),
          selectedDob.toString(),
          sEmail,
          Fun.checkSelectedStatus(iIsDependentIndex));
      if (isSuccess) {
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
                                      'Edit Family Detail',
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
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
                                      "Relationship",
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
                              controller: _relationshipController,
                              onChanged: (text) {
                                setState(() {
                                  sRelationship =
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
                                      "Full Name",
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
                              controller: _fullNameController,
                              onChanged: (text) {
                                setState(() {
                                  sFullName =
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
                                    child: Text('Date of Birth*'),
                                  ),
                                  Container(
                                    child: Text('Contact Number'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                          '${DateFormat('MMM dd, yyyy').format(selectedDob)}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        onTap: () {
                                          _selectInDate(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        tooltip: 'Tap to open date picker',
                                        onPressed: () {
                                          _selectInDate(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Expanded(
                                    child: TextFormField(
                                      controller: numberController,
                                      onChanged: (text) {
                                        setState(() {
                                          sContactNumber = text.replaceAll(RegExp(r'[^0-9]'), '');
                                          numberController.text = sContactNumber;
                                        });
                                      },
                                      maxLength: 10,
                                      keyboardType: TextInputType.phone, // Set keyboardType to phone
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SColors.rozgarRed),
                                        ),
                                      ),
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
                                    child: Text('Emergency Contact'),
                                  ),
                                  Container(
                                    child: Text('Dependent'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: DropdownButton(
                                      value: sEmergencyContact,
                                      items: Constants.lsIsEmergencyContact
                                          .map((option) {
                                        return DropdownMenuItem(
                                          value: option,
                                          child: Text(option),
                                        );
                                      }).toList(),
                                      onChanged: (selectedOption) {
                                        setState(() {
                                          sEmergencyContact = selectedOption!;
                                          iEmergencyContactIndex = Constants
                                              .lsDependant
                                              .indexOf(selectedOption);
                                        });
                                      },
                                      hint: Text('Select an option'),
                                    ),
                                  ),
                                  Container(
                                    child: DropdownButton(
                                      value: sIsDependant,
                                      items: Constants.lsDependant.map((option) {
                                        return DropdownMenuItem(
                                          value: option,
                                          child: Text(option),
                                        );
                                      }).toList(),
                                      onChanged: (selectedOption) {
                                        setState(() {
                                          sIsDependant = selectedOption!;
                                          iIsDependentIndex = Constants
                                              .lsDependant
                                              .indexOf(selectedOption);
                                        });
                                      },
                                      hint: Text('Select an option'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        SColors.rozgarRed),
                                  ),
                                  onPressed: () {
                                    deleteFamilyDetails(sId!);
                                  },
                                  child: Text('Delete',style: GoogleFonts.roboto(color:Colors.white)),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        SColors.rozgarRed),
                                  ),
                                  onPressed: () {
                                    if (sRelationship.length <= 2) {
                                      Fun.showToast(
                                          "Please Enter A valid Relationship");
                                      return;
                                    } else if (sFullName.length <= 2) {
                                      Fun.showToast(
                                          "Please Enter A valid Full Name");

                                      return;
                                    } else if (sEmail.length < 12) {
                                      Fun.showToast(
                                          "Please Enter A valid Email Address");

                                      return;
                                    } else if (sContactNumber.length != 10) {
                                      Fun.showToast(
                                          "Please Enter A valid Contact Number");
                                      return;
                                    } else {
                                      // print("-------------^----------------");
                                      // print(sRelationship);
                                      // print(sFullName);
                                      // print(sEmail);

                                      // print(selectedDob);
                                      // print(sContactNumber);
                                      // print(iIsDependentIndex);
                                      // print(iEmergencyContactIndex);
                                      // print("--------------V---------------");
                                      EditFamilyDetails(
                                          sFullName,
                                          sId,
                                          sRelationship,
                                          sContactNumber,
                                          iEmergencyContactIndex,
                                          selectedDob,
                                          sEmail,
                                          iIsDependentIndex);
                                    }
                                  },
                                  child: Text('Save Changes',style: GoogleFonts.roboto(color:Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
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
