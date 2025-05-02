import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/splash/controllers/splash_controller.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../utils/s_colors.dart';
import '../../../../widget/text_widget.dart';

class SplashView extends GetView<SplashController>{
  SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset('assets/images/splash_logo.png',
                        width: 80, height: 80)),
                const SizedBox(height: 15),
                const TextWidget(label: 'HR Management - Rozgar'),
              ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 9),
                color: SColors.cultured,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Made in india ",
                          style: GoogleFonts.nunito(
                              color: SColors.independence,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: Fun.getFlag('in'),
                                style: GoogleFonts.nunito(
                                    color: SColors.redPigment,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                            TextSpan(
                                text: ' with \u2764 ',
                                style: GoogleFonts.nunito(
                                    color: SColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                            TextSpan(
                                text: 'by Value Innovation Labs',
                                style: GoogleFonts.nunito(
                                    color: SColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                          ])),
                  const SizedBox(height: 5),
                ])),
          )
        ]));
  }

}