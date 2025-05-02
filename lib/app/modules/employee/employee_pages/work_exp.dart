import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/widget/dialogs/add_work_exp.dart';
import 'package:hrms/widget/dialogs/edit_work_exp.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/profile_response.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../utils/shared_preferences.dart';

class WorkExp extends StatefulWidget {
  @override
  _WorkExpPageState createState() => _WorkExpPageState();
}

class _WorkExpPageState extends State<WorkExp>
    with AutomaticKeepAliveClientMixin<WorkExp> {
  late Future<List<ExperienceDetail>?> responseData;

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

  Future<List<ExperienceDetail>?> getEmployeeDetails() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    var response = await ApiHandler().getEmployeeDetailJ(id);
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    List<dynamic> educationDetails = jsonResponse['result']['experienceDetail'];
    List<ExperienceDetail> educationDetailList = [];
    for (var familyDetailJson in educationDetails) {
      ExperienceDetail familyDetail =
          ExperienceDetail.fromJson(familyDetailJson);
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
                    final List<ExperienceDetail> expDetails = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: expDetails.length,
                      itemBuilder: (context, index) {
                        final ExperienceDetail = expDetails[index];
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
                                            ExperienceDetail.companyName
                                                .toString(),
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
                                              return EditWorkExp(
                                                id: ExperienceDetail.id!,
                                                jobProfile: ExperienceDetail
                                                    .jobProfile!,
                                                companyName: ExperienceDetail
                                                    .companyName!,
                                                remarks: ExperienceDetail.remarks!,
                                                dobEnd: ExperienceDetail.to!,
                                                dobJoining: ExperienceDetail.from!,
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
                                            "Organization",
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
                                            ExperienceDetail.companyName
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
                                            'From',
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
                                            'To',
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
                                              Fun.formatDate(ExperienceDetail
                                                  .from
                                                  .toString()),
                                              textAlign: TextAlign.left),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                              Fun.formatDate(ExperienceDetail.to
                                                  .toString()),
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
                                            "Designation",
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
                                            ExperienceDetail.jobProfile
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
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Summary",
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
                                            ExperienceDetail.remarks.toString(),
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
                      return AddWorkExp(
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
                      Text('Add Working Experience',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: SColors.rozgarRed,
                              fontSize: 16)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
