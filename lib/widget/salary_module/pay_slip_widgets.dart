import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaySlipWidgets {
  Widget companyLogo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(1.0),
          color: Colors.white,
          // Set the background color to black
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Colors.red,
                ),
                child: Text(
                  'Value',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 5.0),
                ),
              ),
              Text(
                'Innovation',
                style: GoogleFonts.roboto(color: Colors.black, fontSize: 5.0),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Labs',
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
