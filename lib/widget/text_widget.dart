import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/s_colors.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool isOpenSans;
  final bool isRoboto;
  final bool isUnderLine;
  final int maxlines;

  const TextWidget(
      {Key? key,
      this.label = '',
      this.textColor = SColors.black,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500,
      this.textAlign = TextAlign.start,
      this.isOpenSans = false,
      this.isUnderLine = false,
      this.isRoboto = false,
      this.maxlines = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        overflow: TextOverflow.ellipsis,
        maxLines: maxlines,
        textAlign: textAlign,
        style: isOpenSans
            ? GoogleFonts.nunito(
                decoration: isUnderLine
                    ? TextDecoration.underline
                    : TextDecoration.none,
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight)
            : isRoboto
                ? GoogleFonts.nunito(
                    decoration: isUnderLine
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight)
                : GoogleFonts.nunito(
                    decoration: isUnderLine
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight));
  }
}
