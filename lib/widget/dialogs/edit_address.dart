import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_handler.dart';
import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class EditAddressDetail extends StatefulWidget {
  String id;
  String country;
  String address;
  String state;
  String city;
  String pinCode;
  String idCro;
  String countryCro;
  String addressCro;
  String stateCro;
  String cityCro;
  String pinCodeCro;
  final Function() callback;

  EditAddressDetail({
    required this.id,
    required this.country,
    required this.address,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.idCro,
    required this.countryCro,
    required this.addressCro,
    required this.stateCro,
    required this.cityCro,
    required this.pinCodeCro,
    required this.callback});

  @override
  _EditAddressDetailState createState() => _EditAddressDetailState();
}

class _EditAddressDetailState extends State<EditAddressDetail> {
  String sId ="--";
  String sCountry ="--";
  String sAddress ="--";
  String sState ="--";
  String sCity ="--" ;
  String sPinCode ="--";
  String sIdCro ="--";
  String sCountryCro ="--";
  String sAddressCro ="--";
  String sStateCro ="--";
  String sCityCro ="--";
  String sPinCodeCro ="--";
  bool isProgress = false;
  bool isChecked = false;

  late final TextEditingController _countryController;
  late final TextEditingController _countryCroController;
  late final TextEditingController _addressController;
  late final TextEditingController _addressCroController;
  late final TextEditingController _stateController;
  late final TextEditingController _stateCroController;
  late final TextEditingController _cityController;
  late final TextEditingController _cityCroController;
  late final TextEditingController _pinCodeController;
  late final TextEditingController _pinCodeCroController;

  @override
  void initState() {
    super.initState();
    sId= widget.id;
    sIdCro = widget.idCro;
    sCountry = widget.country;
    sCountryCro = widget.countryCro;
    sAddress = widget.address;
    sState = widget.state;
    sCity = widget.city;
    sPinCode = widget.pinCode;
    sAddressCro = widget.addressCro;
    sStateCro = widget.stateCro;
    sCityCro = widget.cityCro;
    sPinCodeCro = widget.pinCodeCro;

    _countryController = TextEditingController(text: widget.country);
    _countryCroController = TextEditingController(text: widget.countryCro);
    _addressController = TextEditingController(text: widget.address);
    _addressCroController = TextEditingController(text: widget.addressCro);
    _stateController = TextEditingController(text: widget.state);
    _stateCroController = TextEditingController(text: widget.stateCro);
    _cityController = TextEditingController(text: widget.city);
    _cityCroController = TextEditingController(text: widget.cityCro);
    _pinCodeController = TextEditingController(text: widget.pinCode);
    _pinCodeCroController = TextEditingController(text: widget.pinCodeCro);
  }
  editAddressDetails() async {
    setState(() {
      isProgress = true;
    });
    try {

      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      var sUserId = jsonMap['result']['id'];
      List<Map<String, dynamic>> jsonArray = [
        {
          "userId": sUserId,
          "country": sCountry,
          "state": sState,
          "city": sCity,
          "address":sAddress,
          "pinCode": sPinCode,
          "isPermanent": true,
          "id": sId
        },
        {
          "userId": sUserId,
          "country": sCountryCro,
          "state": sStateCro,
          "city": sCityCro,
          "address": sAddressCro,
          "pinCode": sPinCodeCro,
          "isPermanent": false,
          "id": sIdCro
        }
      ];
      bool isSuccess = await ApiHandler().editAddress(jsonArray);
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      'Address Details',
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    ),
                                  ),
                                ],
                              )
                            ],),
                            SizedBox(height: 15),
                            Text(
                              "Country",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _countryController,
                              onChanged: (text) {
                                setState(() {
                                  sCountry = text;
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
                            Text(
                              "State",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _stateController,
                              onChanged: (text) {
                                setState(() {
                                  sState = text;
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
                            Text(
                              "City",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _cityController,
                              onChanged: (text) {
                                setState(() {
                                  sCity = text;
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
                            Text(
                              "Address",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _addressController,
                              onChanged: (text) {
                                setState(() {
                                  sAddress = text;
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
                            Text(
                              "Pincode",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _pinCodeController,
                              onChanged: (text) {
                                setState(() {
                                  sPinCode = text;
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
                            Text(
                              'Correspondence Address',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CheckboxListTile(
                              title: Text(
                                'Correspondence address is same as permanent',
                                style: GoogleFonts.roboto(fontSize: 14),
                              ),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  if(isChecked){
                                    _countryCroController.text = sCountry!;
                                    _stateCroController.text = sState!;
                                    _cityCroController.text = sCity!;
                                    _addressCroController.text = sAddress!;
                                    _pinCodeCroController.text = sPinCode!;
                                  }else{
                                    _countryCroController.clear();
                                    _stateCroController.clear();
                                    _cityCroController.clear();
                                    _addressCroController.clear();
                                    _pinCodeCroController.clear();
                                  }
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Country",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _countryCroController,
                              onChanged: (text) {
                                setState(() {
                                  sCountryCro = text;
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
                            Text(
                              "State",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _stateCroController,
                              onChanged: (text) {
                                setState(() {
                                  sStateCro = text;
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
                            Text(
                              "City",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _cityCroController,
                              onChanged: (text) {
                                setState(() {
                                  sCityCro = text;
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
                            Text(
                              "Address",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _addressCroController,
                              onChanged: (text) {
                                setState(() {
                                  sAddressCro = text;
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
                            Text(
                              "Pincode",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextField(
                              controller: _pinCodeCroController,
                              onChanged: (text) {
                                setState(() {
                                  sPinCodeCro = text;
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
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  editAddressDetails();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: SColors.rozgarRed,
                                  // Set the background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Set the border radius
                                  ),
                                ),
                                child:
                                Text('Submit',style: GoogleFonts.roboto(color:Colors.white)), // Add your button text here
                              ),
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
