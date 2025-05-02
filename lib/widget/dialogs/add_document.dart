import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:path/path.dart' as path;
import '../../model/document_type.dart';
import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class AddDocument extends StatefulWidget {
  final Function() callback;

  AddDocument({required this.callback});

  @override
  _AddDocumentState createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  String sDocumentNumber = "";
  String sSelectedDocument = 'Bank Details';
  int? selectedDocumentId;
  String? selectedFilePath;
  String? errorMessage;
  String? sFileName;
  bool isProgress = false;
  String? sSelectedFileName;
  List<Result> documentList = [];
  bool isLoadingDocs = true;

  @override
  void initState() {
    super.initState();
    getListOfDoc();
  }
  getListOfDoc() async {
    try {
      var response = await ApiHandler().getDocumentType();
      setState(() {
        documentList = response.result;
        isLoadingDocs = false;
      });
    } catch (error) {
      setState(() {
        isLoadingDocs = false;
      });
      Fun.showToast("Failed to load document types.");
    }
  }
  uploadDocumentOn(sDocumentId, sDocumentNumber, userDoc, sFileName) async {
    setState(() {
      isProgress = true;
    });
    try {
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      var sUserId = jsonMap['result']['id'];

      FormData formData = FormData.fromMap({
        "userId": sUserId,
        "documentTypeId": sDocumentId,
        "documentNumber": sDocumentNumber,
        "file": await MultipartFile.fromFile(
          userDoc.path,
          filename: sFileName,
        ),
      });

      bool isSuccess = await ApiHandler().addDocument(formData);
      if (isSuccess) {
        setState(() {
          isProgress = false;
        });
        widget.callback();
        Navigator.of(context).pop();
      }else{
       setState(() {
         isProgress = false;
       });
      }
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      Fun.showToast("Something went wrong!");
    }
  }
  selectFile() {
    Fun.selectFile().then((value) => {
      setState(() {
        sSelectedFileName = Fun.truncateAndAddEllipsis(path.basename(value));
        sFileName = path.basename(value);
        selectedFilePath = value;
      })
    });
  }
  bool isValidDocumentNumber(String docName, String documentNumber) {
    if (docName.toLowerCase().contains("aadhar")) {
      return documentNumber.isValidAadharNumber();
    } else if (docName.toLowerCase().contains("pan")) {
      return documentNumber.isValidPanCardNo();
    } else if (docName.toLowerCase().contains("driving licence") || docName.toLowerCase().contains("driving license")) {
      return documentNumber.isValidLicenseNo();
    }
    return true; // If no validation required
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: SColors.rozgarRed,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Document Detail',
                                  style: GoogleFonts.roboto(
                                    color: SColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Document Type",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isLoadingDocs
                          ? CircularProgressIndicator()
                          : DropdownButton<int>(
                        value: selectedDocumentId,
                        items: documentList.map((doc) {
                          return DropdownMenuItem<int>(
                            value: doc.id,
                            child: Text(doc.name.toString()),
                          );
                        }).toList(),
                        onChanged: (int? selectedOption) {
                          setState(() {
                            selectedDocumentId = selectedOption;
                          });
                        },
                        hint: Text('Select Document Type'),
                        isExpanded: true,
                      ),
                      SizedBox(height: 5),
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
                        ],
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            sDocumentNumber = text;
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
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectFile();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Upload',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child:Text(sSelectedFileName ?? 'No file selected'),
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
                          if (sDocumentNumber.length <= 3) {
                            Fun.showToast("Please Enter a Valid Document Number");
                            return;
                          }

                          if (selectedFilePath == null) {
                            Fun.showToast("Please Upload a Document");
                            return;
                          }

                          if (selectedDocumentId == null) {
                            Fun.showToast("Please Select a Document Type");
                            return;
                          }

                          String? docName = documentList.firstWhere((doc) => doc.id == selectedDocumentId, orElse: () => Result(id: -1, name: "Unknown")).name;

                          if (!isValidDocumentNumber(docName!, sDocumentNumber)) {
                            Fun.showToast("Invalid $docName Number");
                            return;
                          }

                          File file = File(selectedFilePath!);
                          uploadDocumentOn(selectedDocumentId!, sDocumentNumber, file, sFileName);
                        },
                        child: Text('Submit', style: GoogleFonts.roboto(color: Colors.white)),
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
              child: Fun.getLoadingUICircular(context),
            ),
          ),
        ],
      ),
    );
  }
}


extension AadharNumberValidator on String {
  bool isValidAadharNumber() {
    return RegExp(r'^[2-9]{1}[0-9]{3}(\s)?[0-9]{4}(\s)?[0-9]{4}$').hasMatch(this);
  }
}

extension PanCardValidator on String {
  bool isValidPanCardNo() {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(this);
  }
}

extension DrivingLicenseValidator on String {
  bool isValidLicenseNo() {
    return RegExp(
        r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$'
    ).hasMatch(this);
  }
}
