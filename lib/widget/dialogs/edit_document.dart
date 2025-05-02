import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import '../../api/api_handler.dart';
import '../../utils/fun.dart';
import '../../utils/prefsKeys.dart';
import '../../utils/s_colors.dart';
import '../../utils/shared_preferences.dart';

class EditDocument extends StatefulWidget {
  final String documentName;
  final String documentNumber;
  final String documentTypeId;
  final String documentId;
  final Function() callback;

  EditDocument({
    required this.documentTypeId,
    required this.documentName,
    required this.documentNumber,
    required this.documentId,
    required this.callback,
  });

  @override
  _EditDocumentState createState() => _EditDocumentState();
}

class _EditDocumentState extends State<EditDocument> {
  String? sDocumentName;
  String sDocumentNumber = "";
  String? sSelectedDocument;
  String? selectedFilePath;
  String? sFileName;
  String? sSelectedFileName;
  bool isProgress = false;
  String? sDocumentTypeId;
  String? sDocumentId;
  late final TextEditingController _editController;
  @override
  void initState() {
    super.initState();
    sSelectedDocument = widget.documentName;
    sDocumentNumber = widget.documentNumber;
    sDocumentName = widget.documentName;
    sDocumentTypeId = widget.documentTypeId;
    sDocumentId = widget.documentId;
    _editController = TextEditingController(text: widget.documentNumber);
  }

  Future<void> editDocument() async {
    setState(() => isProgress = true);
    try {
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      var sUserId = jsonMap['result']['id'];
      FormData formData = FormData.fromMap({
        "userId": sUserId,
        "id": sDocumentId,
        "documentTypeId": sDocumentTypeId,
        "documentNumber": sDocumentNumber,
        "file": await MultipartFile.fromFile(
          selectedFilePath!,
          filename: sFileName,
        ),
      });
      bool isSuccess = await ApiHandler().addDocument(formData);
      if (isSuccess) {
        widget.callback();
        Navigator.of(context).pop();
      }
    } catch (e) {
      Fun.showToast("Something went wrong!");
    } finally {
      setState(() => isProgress = false);
    }
  }

  Future<void> deleteDocument() async {
    setState(() => isProgress = true);
    try {
      bool isSuccess = await ApiHandler().deleteDocumentDetail(sDocumentId.toString());
      if (isSuccess) {
        widget.callback();
        Navigator.of(context).pop();
      }
    } catch (e) {
      Fun.showToast("Something went wrong!");
    } finally {
      setState(() => isProgress = false);
    }
  }

  void selectFile() async {
    String? filePath = await Fun.selectFile();
    if (filePath != null) {
      setState(() {
        sSelectedFileName = Fun.truncateAndAddEllipsis(path.basename(filePath));
        sFileName =path.basename(filePath);
        selectedFilePath = filePath;
      });
    }
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
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      SizedBox(height: 15),
                      _buildDocumentType(),
                      SizedBox(height: 5),
                      _buildDocumentNumber(),
                      SizedBox(height: 20),
                      _buildFileUploadSection(),
                      SizedBox(height: 20),
                      _buildActionButtons(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isProgress) Center(child: Fun.getLoadingUICircular(context)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 2.0),
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  color: SColors.rozgarRed,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Center(
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
    );
  }

  Widget _buildDocumentType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Document Type",
              style: GoogleFonts.roboto(color: Colors.grey[700]),
            ),
            Text("")
          ],
        ),
        SizedBox(height: 5),
        Text(
          sSelectedDocument ?? '',
          style: GoogleFonts.roboto(
            color: SColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Document Number",
          style: GoogleFonts.roboto(color: Colors.grey[700]),
        ),
        TextField(
          controller: _editController,
          onChanged: (text) => setState(() => sDocumentNumber = text),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: SColors.rozgarRed),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadSection() {
    return Row(
      children: [
        GestureDetector(
          onTap: selectFile,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Upload',
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(sSelectedFileName ?? 'No file selected'),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(SColors.rozgarRed),
          ),
          onPressed: deleteDocument,
          child: Text('Delete', style: GoogleFonts.roboto(color: Colors.white)),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(SColors.rozgarRed),
          ),
          onPressed: () {
            if (sDocumentNumber.length <= 3) {
              Fun.showToast("Please Enter A valid Document Number");
            } else if (selectedFilePath == null) {
              Fun.showToast("Please Enter A valid Document");
            } else {
              editDocument();
            }
          },
          child: Text(
            'Save Changes',
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
