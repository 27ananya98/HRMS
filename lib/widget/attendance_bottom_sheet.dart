import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/attendance_report_m.dart';
import 'package:hrms/utils/fun.dart';

import '../../utils/s_colors.dart';

attendanceRepBottomSheet(
    BuildContext context,
    String sInDate,
    String sTotalHour,
    String sAddress,
    String sOutDate,
    List<Result> attendanceList,
    int date) {
  List<Result> filterResultsByInTimeDay(
      List<Result> results, int targetInTimeDay) {
    return results
        .where((result) => result.inTimeDay == targetInTimeDay)
        .toList();
  }
  if (attendanceList != null) {
    attendanceList = filterResultsByInTimeDay(attendanceList, date);
  }
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 350,
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            // First row with two text views
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Check In',
                    style:
                        GoogleFonts.roboto(color: SColors.black, fontSize: 14)),
                Text('Total Hours | Check-Ins',
                    style:
                        GoogleFonts.roboto(color: SColors.black, fontSize: 14)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    sInDate,
                    style: GoogleFonts.roboto(
                        color: SColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child:Text('$sTotalHour | ${attendanceList.length}',
                      style:
                      GoogleFonts.roboto(color: SColors.black, fontSize: 14)),
                ),
              ],
            ),
            SizedBox(height:10),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceList.length,
                itemBuilder: (BuildContext context, int index) {
                  // Build custom card for each item
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(Fun.getIndianTime(attendanceList[index].inTime),
                              style: GoogleFonts.roboto(
                                  color: SColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ],
                      ),
                      // Second row with three containers
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: SColors.rozgarRed,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 2,
                                  color: SColors.rozgarRed,
                                ),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: SColors.rozgarRed,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(attendanceList[index].attendanceTypeName!,
                                      style: GoogleFonts.roboto(
                                          color: SColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                  GestureDetector(
                                    onTap: () {
                                      Fun.openGoogleMaps(double.parse(attendanceList[index].lat!), double.parse(attendanceList[index].lng!));
                                    },
                                    child: Text(sAddress),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //
                      //Third row with three containers
                      Row(
                        children: [
                          Text(Fun.getIndianTime(attendanceList[index].outTime),
                              style: GoogleFonts.roboto(
                                  color: SColors.black, fontSize: 14)),
                        ],
                      ),
                      SizedBox(height:10)
                    ],
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Check Out',
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sOutDate,
                    style: GoogleFonts.roboto(
                        color: SColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
