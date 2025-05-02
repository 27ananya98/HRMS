import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../api/api_handler.dart';
import '../../utils/constants.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class AddFamilyDetail extends StatefulWidget {
  final Function() callback;
  AddFamilyDetail({required this.callback});
  @override
  _AddFamilyDetailState createState() => _AddFamilyDetailState();
}

class _AddFamilyDetailState extends State<AddFamilyDetail> {
  DateTime? selectedDob;
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
  late final TextEditingController numberController=TextEditingController();
  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
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
  }

  addFamilyDetails(sFullName, sRelationship, sContactNumber,iEmergencyContactIndex, selectedDob, sEmail,iIsDependentIndex)async{
    setState(() {
      isProgress = true;
    });
   try {
     bool isSuccess = await ApiHandler().addFamilyDetail(sFullName, sRelationship, sContactNumber, Fun.checkSelectedStatus(iEmergencyContactIndex), selectedDob.toString(), sEmail, Fun.checkSelectedStatus(iIsDependentIndex));
     if(isSuccess){
       setState(() {
         isProgress = false;
       });
       widget.callback();
       Navigator.of(context).pop();
     }
   }catch (e) {
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
                  margin: const EdgeInsets.all(16),
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
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Add Family Detail',
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    ),
                                  ),
                                ],
                              )
                            ],),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
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
                              // set controller
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
                              // set controller
                              onChanged: (text) {
                                setState(() {
                                  sFullName =
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
                                        onTap: () {
                                          _selectInDate(context);
                                        },
                                        child: Text(
                                          selectedDob == null
                                              ? 'MMM-dd-yyyy'
                                              : '${DateFormat('MMM dd, yyyy').format(selectedDob!)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
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
                                  SizedBox(width:30),
                                  Expanded(
                                    child: TextFormField(
                                      controller: numberController,
                                      keyboardType: TextInputType.phone, // Set keyboardType to phone
                                      onChanged: (text) {
                                        setState(() {
                                          sContactNumber = text.replaceAll(RegExp(r'[^0-9]'), '');
                                          numberController.text = sContactNumber;
                                        });
                                      },
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: SColors.rozgarRed),
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
                                      items:
                                      Constants.lsIsEmergencyContact.map((option) {
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
                                      hint: const Text('Select an option'),
                                    ),
                                  ),
                                  DropdownButton(
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
                                    hint: const Text('Select an option'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(SColors.rozgarRed),
                              ),
                              onPressed: () {



                                if(sRelationship.length<=2){
                                  Fun.showToast("Please Enter A valid Relationship");
                                  return;

                                }else if(sFullName.length<=2){
                                  Fun.showToast("Please Enter A valid Full Name");

                                  return;

                                }else if(sEmail.length<12){
                                  Fun.showToast("Please Enter A valid Email Address");

                                  return;

                                }else if(sContactNumber.length!=10){
                                  Fun.showToast("Please Enter A valid Contact Number");
                                  return;
                                }else{
                                  // print("-------------^----------------");
                                  // print(sRelationship);
                                  // print(sFullName);
                                  // print(sEmail);

                                  // print(selectedDob);
                                  // print(sContactNumber);
                                  // print(iIsDependentIndex);
                                  // print(iEmergencyContactIndex);
                                  // print("--------------V---------------");
                                  addFamilyDetails(sFullName, sRelationship, sContactNumber,iEmergencyContactIndex, selectedDob, sEmail,iIsDependentIndex);
                                }
                              },
                              child: Text('Submit',style: GoogleFonts.roboto(color:Colors.white)),
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
