import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/profile_response.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/s_colors.dart';
import '../../../../../utils/shared_preferences.dart';
import '../../../../../widget/dialogs/add_document.dart';
import '../../../../../widget/dialogs/edit_document.dart';

class Document extends StatefulWidget {
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<Document>
    with AutomaticKeepAliveClientMixin<Document> {
  late Future<List<DocumentDetail>?> responseData;
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

  Future<List<DocumentDetail>?> getEmployeeDetails() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    var response = await ApiHandler().getEmployeeDetailJ(id);
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    List<dynamic> educationDetails = jsonResponse['result']['documentDetail'];
    List<DocumentDetail> educationDetailList = [];
    for (var familyDetailJson in educationDetails) {
      DocumentDetail familyDetail = DocumentDetail.fromJson(familyDetailJson);
      educationDetailList.add(familyDetail);
    }
    if (educationDetailList.isNotEmpty) {
      setState(() {
        isEmpty = false;
      });
    } else {
      setState(() {
        isEmpty = true;
      });
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
                    final List<DocumentDetail> docDetails = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: docDetails.length,
                      itemBuilder: (context, index) {
                        final DocumentDetail = docDetails[index];
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
                                              DocumentDetail!.documentTypeName
                                                  .toString(),
                                              textAlign: TextAlign.left),
                                        ),
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditDocument(
                                                  documentId: DocumentDetail.id
                                                      .toString(),
                                                  documentTypeId: DocumentDetail.documentTypeId
                                                      .toString(),
                                                  documentName: DocumentDetail
                                                      .documentTypeName
                                                      .toString(),
                                                  documentNumber: DocumentDetail
                                                      .documentNumber
                                                      .toString(),
                                                  callback: () {
                                                    refresh();
                                                  });
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
                                            "Document Number",
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
                                            'Document Link',
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
                                            DocumentDetail.documentNumber
                                                .toString(),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                            onTap: () {
                                              Fun.downloadDocuments(
                                                  DocumentDetail.fileName
                                                      .toString());
                                            },
                                            child: Text(
                                              "Download",
                                              style: GoogleFonts.roboto(
                                                color: Colors.blue,
                                                // Customize the link color
                                                decoration: TextDecoration
                                                    .underline, // Add an underline to mimic a link
                                              ),
                                            )),
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
                      return AddDocument(
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
                      Text('Add Document',
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
