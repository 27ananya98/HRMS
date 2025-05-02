import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../model/salary_slip_name.dart';

class SalarySlipController extends GetxController {
  RxBool loading = false.obs;
  RxString pathPDF = "".obs;
  RxString landscapePathPdf = "".obs;
  RxString remotePDFpath = "".obs;
  RxString corruptedPathPDF = "".obs;
  RxInt? pages = 0.obs;
  RxInt? currentPage = 0.obs;
  RxBool isReady = false.obs;
  RxString errorMessage = ''.obs;
  RxString path = ''.obs;

  @override
  void onInit() {
    getSalarySlipUrl();
  }

  getSalarySlipUrl() async {
    loading.value = true;
    try {
      SalarySlipName response = await ApiHandler().getSalarySlipName();
      await createFileOfPdfUrl(response.result![0].fileName).then((f) {
        path.value = f.path;
      });
    } catch (e) {
      loading.value = false;
    }
    loading.value = false;
  }

  Future<File> createFileOfPdfUrl(String pdfName) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      var url = "https://hrms-orgapi.rozgar.com/salary-slip-pdf/$pdfName";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }
}
