import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../model/pay_slip.dart';
import '../../../utils/fun.dart';

class PdfConverter {
  widgetToPdf(PaySlip? response) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Text("hello world");
          },
        ),
      );
      final folder = await getTemporaryDirectory();
      final filePath = '${folder.path}/SalarySlip.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      Fun.savePdfToDownload(filePath);
      Fun.showToast("Salary Slip Downloaded Successfully");
      return true;
    } catch (e) {
      print(e);
      Fun.showToast("Failed to Download Salary Slip");
      return false;
    }
  }

  pw.Document createPdf(Uint8List imageBytes) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Image(
            pw.MemoryImage(imageBytes),
          );
        },
      ),
    );

    return pdf;
  }

  Future<void> savePdfToDevice(pw.Document pdf) async {
    final folder = await getTemporaryDirectory();
    final filePath = '${folder.path}/SalarySlip.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    Fun.savePdfToDownload(filePath);
    Fun.showToast("Salary Slip Downloaded Successfully");
  }

  static Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}
