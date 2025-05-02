import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/profile_response.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/widget/dialogs/add_family_detail.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../utils/shared_preferences.dart';
import '../../../../../widget/cards/family_detail_card.dart';

class Family extends StatefulWidget {
  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<Family>
    with AutomaticKeepAliveClientMixin<Family> {
  late Future<List<FamilyDetail>?> responseData;
  bool isProgressRunning = false;
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() {
    setState(() {
      responseData = getEmployeeDetails();
    });
  }

  Future<List<FamilyDetail>?> getEmployeeDetails() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    var response = await ApiHandler().getEmployeeDetailJ(id);
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    List<dynamic> familyDetails = jsonResponse['result']['familyDetail'];
    List<FamilyDetail> familyDetailList = [];
    for (var familyDetailJson in familyDetails) {
      FamilyDetail familyDetail = FamilyDetail.fromJson(familyDetailJson);
      familyDetailList.add(familyDetail);
    }
    if (familyDetailList.isNotEmpty) {
      setState(() {
       isEmpty = false;
      });
    } else {
      setState(() {
      isEmpty = true;
      });
    }
    return familyDetailList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 10),
            Visibility(
              visible: isEmpty,
              child: Column(
                children: [
                  Container(
                      width: 250,
                      height: 250,
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/images/img_comp_off.png'),
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: Text("No Record Found",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16)),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: responseData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(SColors.rozgarRed)));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final List<FamilyDetail> familyDetails = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: familyDetails.length,
                    itemBuilder: (context, index) {
                      final familyDetail = familyDetails[index];
                      return FamilyDetailCard.getFamilyListCard(
                          context,
                          familyDetail.id.toString(),
                          familyDetail.name.toString(),
                          familyDetail.relationship.toString(),
                          "Edit",
                          Fun.formatDate(familyDetail.dateOfBirth.toString()),
                          familyDetail.contactNumber.toString(),
                          familyDetail.email.toString(),
                          familyDetail.isEmergencyContact.toString(),
                          familyDetail.isDependant.toString(),
                          refresh);
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddFamilyDetail(
                      callback: () {
                        refresh();
                      },
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: SColors.rozgarRed,
                    ),
                    // Replace this with your desired icon
                    SizedBox(width: 5.0),
                    // Adjust the spacing between the icon and text
                    Text('Add Family Member',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: SColors.rozgarRed,
                            fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
