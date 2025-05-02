import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/profile_response.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../utils/shared_preferences.dart';
import '../../../../../widget/dialogs/edit_address.dart';

class Address extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<Address>
    with AutomaticKeepAliveClientMixin<Address> {
  bool isProgressRunning = false;
  List<AddressDetail> responseData = [];
  String sCountry = "--";
  String sAddress = "--";
  String sState = "---";
  String sCity = "--";
  String sPinCode = "--";
  String sCountryP = "--";
  String sAddressP = "--";
  String sStateP = "---";
  String sCityP = "--";
  String sPinCodeP = "--";

  @override
  void initState() {
    super.initState();
    getEmployeeDetails();
  }

  getEmployeeDetails() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      int id = jsonMap['result']['id'];
      var response = await ApiHandler().getEmployeeDetailJ(id);
      Map<String, dynamic> jsonResponse = json.decode(response.toString());
      List<dynamic> familyDetails = jsonResponse['result']['addressDetail'];
      responseData.clear();
      for (var familyDetailJson in familyDetails) {
        AddressDetail familyDetail = AddressDetail.fromJson(familyDetailJson);
        responseData.add(familyDetail);
      }
      setState(() {
        sCountry = responseData[0].country!;
        sAddress = responseData[0].address!;
        sState = responseData[0].state!;
        sCity = responseData[0].city!;
        sPinCode = responseData[0].pinCode!;
        sCountryP = responseData[1].country!;
        sAddressP = responseData[1].address!;
        sStateP = responseData[1].state!;
        sCityP = responseData[1].city!;
        sPinCodeP = responseData[1].pinCode!;
      });
    } catch (e) {
      setState(() {
        isProgressRunning = false;
      });
    }
    setState(() {
      isProgressRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text('Present Address',
                                textAlign: TextAlign.left),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditAddressDetail(
                                  id: responseData[0].id.toString(),
                                  country: sCountry,
                                  address: sAddress,
                                  state: sState,
                                  city: sCity,
                                  pinCode: sPinCode,
                                  idCro: responseData[1].id.toString(),
                                  countryCro: sCountryP,
                                  addressCro: sAddressP,
                                  stateCro: sStateP,
                                  cityCro: sCityP,
                                  pinCodeCro: sPinCodeP,
                                  callback: () {
                                    getEmployeeDetails();
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Icon(
                                  Icons.edit_note_outlined,
                                  color: SColors.rozgarRed,
                                ),
                              )
                            ],
                          ),
                        )),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Country",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sCountry,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Address",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sAddress,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'State',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sState, textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'City',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sCity, textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Pin Code',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sPinCode,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text('Permanent Address',
                                textAlign: TextAlign.left),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditAddressDetail(
                                  id: responseData[0].id.toString(),
                                  country: sCountry,
                                  address: sAddress,
                                  state: sState,
                                  city: sCity,
                                  pinCode: sPinCode,
                                  idCro: responseData[1].id.toString(),
                                  countryCro: sCountryP,
                                  addressCro: sAddressP,
                                  stateCro: sStateP,
                                  cityCro: sCityP,
                                  pinCodeCro: sPinCodeP,
                                  callback: () {
                                    getEmployeeDetails();
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text(
                              //   "Edit",
                              //   style: GoogleFonts.roboto(
                              //       fontWeight: FontWeight.w500,
                              //       color: SColors.rozgarRed,
                              //       fontSize: 14),
                              // ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Icon(
                                  Icons.edit_note_outlined,
                                  color: SColors.rozgarRed,
                                ),
                              )
                            ],
                          ),
                        )),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Country",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sCountryP.toString(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Address",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sAddressP,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'State',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sStateP, textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'City',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(sCityP, textAlign: TextAlign.left),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Pin Code',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              sPinCodeP,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: isProgressRunning,
            child: Fun.getLoadingUICircular(context)),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
