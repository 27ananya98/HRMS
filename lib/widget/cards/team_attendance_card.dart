import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/s_colors.dart';

Widget getTeamAttendanceCard(String sEmpName, String sEmpId, String sEmpHours,
    String sDesignation, String sCheckInTime, String isPresent) {
  Widget getLeaveStatus(value) {
    if (value == "Active") {
      return Text(
        "Present",
        style: GoogleFonts.roboto(color: Colors.green, fontSize: 14),
      );
    }else if(value == "Leave"){
      return Text(
        "Leave",
        style: GoogleFonts.roboto(color: Colors.orange, fontSize: 14),
      );
    } else {
      return Text(
        "Absent",
        style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 14),
      );
    }
  }

  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sEmpName),
            getLeaveStatus(isPresent),
          ],
        ),
        Container(
          height: 1,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Employee ID",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Total Hours',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  sEmpId,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  sEmpHours,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Designation',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Check In Time',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                child: Text(sDesignation, textAlign: TextAlign.left),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(sCheckInTime, textAlign: TextAlign.left),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
