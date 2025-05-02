import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/download_salary_slip/controllers/salary_slip_controller.dart';

import '../../../../utils/fun.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/progress_dialog.dart';

class SalarySlipView extends GetView<SalarySlipController> {
  SalarySlipController controller = Get.put(SalarySlipController());
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress Dialog Example',
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
      ),
      home: WillPopScope(
        onWillPop: () async {
          Fun.showExitConfirmationDialog(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red, // Change to your desired color
            title: Text('Download Salary Slip',
                style: GoogleFonts.roboto(color: SColors.white, fontSize: 18)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.download, color: Colors.white),
                onPressed: () async {
                  File file = File(controller.path.value);
                  if (await file.exists()) {
                    Fun.savePdfToDownload(controller.path.value);
                    Fun.showToast("Salary Slip Downloaded Successfully");
                  } else {
                    Fun.showToast("Salary Slip Not Available");
                  }
                },
              ),
            ],
          ),
          body: Obx(() {
            return ProgressDialog(
                loading: controller.loading.value,
                child: Stack(
                  children: <Widget>[buildContent(controller.path.value)],
                ));
          }),
        ),
      ),
    );
  }

  Widget buildContent(String path) {
    if (path != '') {
      return PDFView(
        filePath: controller.path.value,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: true,
        pageSnap: true,
        defaultPage: controller.currentPage!.value,
        fitPolicy: FitPolicy.BOTH,
        preventLinkNavigation: false,
        // if set to true the link is handled in flutter
        onRender: (_pages) {
          controller.pages!.value = _pages!;
          controller.isReady.value = true;
        },
        onError: (error) {
          controller.errorMessage.value = error.toString();
          print(error.toString());
        },
        onPageError: (page, error) {
          controller.errorMessage.value = '$page: ${error.toString()}';
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          _controller.complete(pdfViewController);
        },
        onLinkHandler: (String? uri) {
          print('goto uri: $uri');
        },
        onPageChanged: (int? page, int? total) {
          print('page change: $page/$total');
          controller.currentPage!.value = page!;
        },
      );
    } else {
      if (controller.loading.value == false && controller.path.value == '') {
        return Center(
          child: Text(
            'Salary Slip Not Available',
            style: GoogleFonts.roboto(color: SColors.black, fontSize: 14),
          ),
        );
      } else {
        return const Center(
          child: Text(
            '',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
