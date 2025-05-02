import 'dart:ui';

import 'package:flutter/material.dart';

class SColors {
  static Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const spaceCadet = Color(0xFF202D4A);
  static const ripeMango = Color(0xFFFFC82A);
  static const independence = Color(0xFF454F63);
  static const redPigment = Color(0xFFE81C28);
  static const rozgarRed = Color(0xFFE81A24);
  static const cultured = Color(0xFFF8F8F8);
  static const oldSilver = Color(0xFF858585);
  static const lightGray = Color(0xFFD2D2D2);
  static const antiFlashWhite = Color(0xFFF2F2F2);
  static const tuftsBlue = Color(0xFF3780D7);
  static const smashedPumpkin = Color(0xFFFF6C37);
  static const apple = Color(0xFF53B55D);
  static const lightSilver = Color(0xFFD9D9D9);
  static const floralWhite = Color(0xFFFFFAED);
  static const gray = Color(0xFF7D7D7D);
  static const brightGray = Color(0xFFECEEF3);
  static const spanishGray = Color(0xFF979797);
  static const azureishWhite = Color(0xFFDEE3F3);
  static const blueWhite = Color(0xFFEFF3F6);
  static const darkCharcoal = Color(0xFF333333);
  static const philippineOrange = Color(0xFFF87203);
  static const cadetBlue = Color(0xFFA4AABA);
  static const gainsBoro = Color(0xFFDDD7EA);
  static const quickSilver = Color(0xFFA1A1A1);
  static const blue = Color(0xFF008AB2);
  static const designationColor = Color(0xFF5F5F5F);
  static const richLilac = Color(0xFFBB6BDA);
  static const cyanBlue = Color(0xFF4178BD);
  static const lavender = Color(0xFFE1EDFC);
  static const mognolia = Color(0xFFFCEDFF);
  static const messageDb = Color(0xFFFFF2EA);
  static const honeyDew = Color(0xFFE5FAF0);
  static const malachite = Color(0xFF0ED674);
  static const romanSilver = Color(0xFF858692);
  static const silverFoil = Color(0xFFAFAFB1);
  static const papayaWhip = Color(0xFFFFF3D0);
  static const platinum = Color(0xFFE2E2E2);
  static const purpleNavy = Color(0xFF46597D);
  static const lavenderBlush = Color(0xFFFBF0F0);
  static const palePink = Color(0xFFFFD4D6);
  static const lightGreen = Color(0xFFA0DFA7);
  static const lightOrange = Color(0xFFFFD180);
  static const lightBlue = Color(0xFFAEEFFF);
  static const green = Color(0xFF4CAF50);

  static const graniteGray = Color(0xFF656565);
  static const charcoal = Color(0xFF3B4457);
  static const crayola = Color(0xFF2F3747);
  static const outerSpace = Color(0xFF474747);
  static const cultured1 = Color(0xFFF5F5F5);
  static const black1 = Color(0xFF141414);
  static const sonicSilver = Color(0xFF757575);
  static const selectiveYellow = Color(0xFFFFB803);
  static const davyGray = Color(0xFF545454);
  static const brandiesBlue = Color(0xFF0074FF);
  static const lightSlateGray = Color(0xFF6E819E);
  static const philippineGray = Color(0xFF929292);
  static const azure = Color(0xFF0878FD);
  static const orangeYellow = Color(0xFFF0BC29);
  static const dimGray = Color(0xFF686868);
  static const silverChalice = Color(0xFFADADAD);
  static const grey = Color(0xFF868686);
  static const arsenic = Color(0xFF414449);
  static const philippineSilver = Color(0xFFB1B1B1);
  static const shadow = Color.fromRGBO(98, 98, 98, 0.25);

  Color getColor(String colorCode) {
    return Color(
        int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
