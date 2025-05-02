import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/utils/s_colors.dart';
import 'package:hrms/widget/text_widget.dart';

const kPadding = 8.0; // up to you

class Snack {
  /// show the snack bar
  /// [content] is responsible for the text of the snack bar
  static show({
    required String content,
    SnackType snackType = SnackType.info,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  }) {
    ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: TextWidget(
            label: content,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: _getSnackBarTextColor(snackType)),
        behavior: behavior,
        backgroundColor: _getSnackBarColor(snackType),
        padding: const EdgeInsets.symmetric(
            horizontal: kPadding * 3, vertical: kPadding * 2)));
  }

  static Color _getSnackBarColor(SnackType type) {
    if (type == SnackType.error) return SColors.redPigment;
    if (type == SnackType.warning) return SColors.smashedPumpkin;
    if (type == SnackType.info) return SColors.apple;
    return SColors.white;
  }

  static Color _getSnackBarTextColor(SnackType type) {
    if (type == SnackType.error || type == SnackType.info) return Colors.white;

    return const Color(0xff1C1C1C);
  }
}

enum SnackType { info, warning, error }
