import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/download_pay_slip/controllers/pay_slip_controller.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import '../../../../utils/fun.dart';
import '../../../../utils/s_colors.dart';
import '../../../../utils/screen_widget.dart';
import '../../../../utils/time_handler.dart';
import '../../../../widget/progress_dialog.dart';
import '../../../../widget/salary_module/pay_slip_templates.dart';
import '../../../../widget/salary_module/pdf_converter/pdf_converter.dart';

class PaySlipView extends GetView<PaySlipController> {
  PaySlipController controller = Get.put(PaySlipController());
  ScreenshotController screenshotController = ScreenshotController();
  TransformationController _transformationController =
      TransformationController();

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
            title: Obx(() {
                return Text(controller.sTitle.value,
                    style: GoogleFonts.roboto(color: SColors.white, fontSize: 18));
              }
            ),
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
                  if (controller.response.value.status == false) {
                    Fun.showToast("Salary Slip Not Available");
                  } else {
                    controller.sTitle.value = 'Downloading Please Wait...';
                    _transformationController.value = Matrix4.identity();
                    screenshotController
                        .capture(
                            delay: Duration(milliseconds: 10), pixelRatio: 5.0)
                        .then((capturedImage) async {
                      pw.Document pdf =
                          PdfConverter().createPdf(capturedImage!);
                      await PdfConverter().savePdfToDevice(pdf);
                      controller.sTitle.value = 'Download Pay Slip';
                    }).catchError((onError) {
                      controller.sTitle.value = 'Download Pay Slip';
                      Fun.showToast("Salary Slip Not Available");
                    });
                  }
                },
              ),
            ],
          ),
          body: Obx(() {
            return ProgressDialog(
                loading: controller.loading.value,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ScreenWidget.disBetween(15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    controller.sMonthName.value =
                                        TimeHandler.getYearName(
                                            TimeHandler.getLastMonth(
                                                controller.currentDate));
                                    controller.daysInMonth.value = DateTime(
                                            TimeHandler.getLastMonth(
                                                    controller.currentDate)
                                                .year,
                                            TimeHandler.getLastMonth(
                                                        controller.currentDate)
                                                    .month +
                                                1,
                                            0)
                                        .day;
                                    String sLastMonth = DateFormat('MM').format(
                                        TimeHandler.getLastMonth(
                                            controller.currentDate));
                                    String sLastYear = DateFormat('yyyy')
                                        .format(TimeHandler.getLastMonth(
                                            controller.currentDate));
                                    controller.getPaySlipData(
                                        sLastYear, sLastMonth);
                                    controller.currentDate =
                                        TimeHandler.getLastMonth(
                                            controller.currentDate);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(left: 90.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.angleLeft,
                                        // Define the icon you want to use
                                        color: Colors.black,
                                        size: 30, // Customize the color
                                      ))),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return Text(controller.sMonthName.value,
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16));
                                }),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/ic_attendance.png',
                                      // Replace with your icon's file path
                                      width: 20, // Set the width as needed
                                      height: 20, // Set the height as needed
                                      color: Colors
                                          .blue, // Customize the icon's color
                                    ),
                                    SizedBox(width: 5),
                                    Obx(() {
                                      return Text(
                                          "${controller.daysInMonth.value} Days",
                                          style: GoogleFonts.roboto(
                                              color: SColors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14));
                                    }),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    controller.sMonthName.value =
                                        TimeHandler.getYearName(
                                            TimeHandler.getNextMonth(
                                                controller.currentDate));
                                    controller.daysInMonth.value = DateTime(
                                            TimeHandler.getNextMonth(
                                                    controller.currentDate)
                                                .year,
                                            TimeHandler.getNextMonth(
                                                        controller.currentDate)
                                                    .month +
                                                1,
                                            0)
                                        .day;
                                    String sLastMonth = DateFormat('MM').format(
                                        TimeHandler.getNextMonth(
                                            controller.currentDate));
                                    String sLastYear = DateFormat('yyyy')
                                        .format(TimeHandler.getNextMonth(
                                            controller.currentDate));
                                    controller.getPaySlipData(
                                        sLastYear, sLastMonth);
                                    controller.currentDate =
                                        TimeHandler.getNextMonth(
                                            controller.currentDate);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(left: 30.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.angleRight,
                                        // Define the icon you want to use
                                        color: Colors.black,
                                        size: 30, // Customize the color
                                      ))),
                            ),
                          ]),
                      ScreenWidget.disBetween(15),
                      Visibility(
                          visible: controller.isEmpty.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 250,
                                  height: 250,
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/img_comp_off.png'),
                                  )),
                              Container(
                                alignment: Alignment.center,
                                child: Text('Record Not Found',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16)),
                              ),
                              ScreenWidget.disBetween(30),
                            ],
                          )),
                      Visibility(
                          visible: !controller.isEmpty.value &&
                              !controller.loading.value,
                          child: Expanded(
                            child: InteractiveViewer(
                              transformationController:
                                  _transformationController,
                              boundaryMargin: EdgeInsets.all(5.0),
                              minScale: 0.1,
                              maxScale: 4.0,
                              child: Screenshot(
                                  controller: screenshotController,
                                  child: PaySlipTemplates().getPaySlipTemplate(
                                      controller.response.value)),
                            ),
                          ))
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }
}
