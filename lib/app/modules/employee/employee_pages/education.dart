import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/profile_response.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../utils/shared_preferences.dart';
import '../../../../../widget/dialogs/add_education.dart';
import '../../../../../widget/dialogs/edit_education.dart';

class Education extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<Education>
    with AutomaticKeepAliveClientMixin<Education> {
  late Future<List<EducationDetail>?> responseData;

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

  Future<List<EducationDetail>?> getEmployeeDetails() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    var response = await ApiHandler().getEmployeeDetailJ(id);
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    List<dynamic> educationDetails = jsonResponse['result']['educationDetail'];
    List<EducationDetail> educationDetailList = [];
    for (var familyDetailJson in educationDetails) {
      EducationDetail familyDetail = EducationDetail.fromJson(familyDetailJson);
      educationDetailList.add(familyDetail);
    }
    return educationDetailList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              FutureBuilder(
                future: responseData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(SColors.rozgarRed)));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final List<EducationDetail> eduDetails = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eduDetails.length,
                      itemBuilder: (context, index) {
                        final ExperienceDetail = eduDetails[index];
                        return Container(
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
                                          child: Text(
                                            ExperienceDetail.course.toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditEducation(
                                                id: ExperienceDetail.id!,
                                                course:
                                                    ExperienceDetail.course!,
                                                institute:
                                                    ExperienceDetail.institute!,
                                                marks: ExperienceDetail.marks!,
                                                startYear:
                                                    ExperienceDetail.startYear!,
                                                endYear:
                                                    ExperienceDetail.endYear!,
                                                callback: () {
                                                  refresh();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
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
                                            "Institute",
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
                                            ExperienceDetail.institute
                                                .toString(),
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
                                            "Start Year",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.roboto(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "End Year",
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
                                              ExperienceDetail.startYear
                                                  .toString(),
                                              textAlign: TextAlign.left),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                              ExperienceDetail.endYear
                                                  .toString(),
                                              textAlign: TextAlign.left),
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
                                            "Percentage/Grade",
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
                                            ExperienceDetail.marks.toString(),
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
                        ));
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
                      return AddEducation(
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
                      Text('Add Education Details',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: SColors.rozgarRed,
                              fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
