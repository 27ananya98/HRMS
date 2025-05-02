import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/attendance_report_m.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/widget/attendance_bottom_sheet.dart';
import 'package:intl/intl.dart';

import '../../utils/s_colors.dart';

Widget attendanceReportCard(
  BuildContext context,
  String sCheckIntime,
  String sCheckInDate,
  String sCheckOuttime,
  String sCheckOutDate,
  double progress,
  String sTotalTime,
  String sWeekDay,
  int sDays,
  DateTime currentDate,
  List<String> leaveList,
  List<String?> holidayList,
    List<Result> attendanceList,
bool? isMakeAbsent
) {
  bool isLeave = false;
  bool isWeekend = false;
  bool isHoliday = false;
  DateTime date = DateTime.now();
  bool isNextDays = date.isBefore(currentDate);
  String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  if (leaveList.contains(formattedDate)) {
    isLeave = true;
  } else {
    isLeave = false;
  }
  if (sWeekDay == "Sat" || sWeekDay == "Sun") {
    isWeekend = true;
  } else {
    isWeekend = false;
  }
  if (holidayList.contains(formattedDate)) {
    isHoliday = true;
  } else {
    isHoliday = false;
  }
  final leaveImg = 'assets/images/leave.jpg';
  final weekendImg = 'assets/images/weekend.jpg';
  final holidayImg = 'assets/images/holiday.jpg';
  Widget getSrcContainer(src, title) {
    return Container(
      margin: EdgeInsets.only(left: 48.0, right: 8.0, top: 8.0, bottom: 8.0),
      width: 350.0,
      height: 110.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          image: DecorationImage(
            image: AssetImage(src),
            fit: BoxFit
                .cover, // Use BoxFit to fit the image within the container
          )),
      child: Center(
        child: Text(title),
      ),
    );
  }

  isTimeZero() {
    if (sTotalTime != "00") {
      return false;
    } else {
      return true;
    }
  }

  Widget upComingDays() {
    return Container(
      margin: EdgeInsets.only(left: 48.0, right: 8.0, top: 8.0, bottom: 8.0),
      width: 350.0,
      height: 110.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30.0,
            child: const Text("-- Hours -- Mins"),
            // margin: EdgeInsets.only( left: 23.0, bottom: 5.0,top: 5.0),
          ),
          Container(
            margin: const EdgeInsets.only(left: 23.0, bottom: 5.0, top: 5.0),
            child: LinearProgressIndicator(
              value: progress, // Value between 0.0 and 1.0
              backgroundColor: Colors.grey[200], // Background color
              valueColor: const AlwaysStoppedAnimation<Color>(
                  SColors.rozgarRed), // Progress color
            ),
          ),
          // First column content goes here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Widget on left
              Container(
                margin: EdgeInsets.only(left: 48.0),
                width: 80.0,
                height: 30.0,
                child: const Text("--"),
              ),
              const SizedBox(
                width: 80.0,
                height: 30.0,
                child: Text("--"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getPresentTime(inTime, outTime, totalTime, dProgress) {
    return Container(
      margin: EdgeInsets.only(left: 48.0, right: 8.0, top: 8.0, bottom: 8.0),
      width: 350.0,
      height: 110.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 30.0,
            child: Text(totalTime),
            // margin: EdgeInsets.only( left: 23.0, bottom: 5.0,top: 5.0),
          ),
          Container(
            margin: const EdgeInsets.only(left: 23.0, bottom: 5.0, top: 5.0),
            child: LinearProgressIndicator(
              value: dProgress, // Value between 0.0 and 1.0
              backgroundColor: Colors.grey[200], // Background color
              valueColor: const AlwaysStoppedAnimation<Color>(
                  SColors.rozgarRed), // Progress color
            ),
          ),
          // First column content goes here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Widget on left
              Container(
                margin: EdgeInsets.only(left: 48.0),
                width: 80.0,
                height: 30.0,
                child: Text(inTime),
              ),
              // Spacer to fill remaining space
              Container(
                width: 80.0,
                height: 30.0,
                // color: SColors.rozgarRed,
                child: Text(outTime),
              ),
            ],
          )
        ]),
      ),
    );
  }


  Widget absentContainer(String value) {
    return Container(
      margin: EdgeInsets.only(left: 48.0, right: 8.0, top: 8.0, bottom: 8.0),
      width: 350.0,
      height: 110.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(value,
                style: GoogleFonts.roboto(
                    color: SColors.rozgarRed,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          )
        ],
      ),
    );
  }

  Widget getContainer() {
    if (isWeekend) {
      if(!isTimeZero()){
       return getPresentTime(sCheckIntime, sCheckOuttime, sTotalTime, progress);
      }else{
        return getSrcContainer(weekendImg, "Weekend");
      }
    } else if(isMakeAbsent == false && isMakeAbsent != null){
      return absentContainer("Absent(M)");
    }
    else if (isTimeZero() &&
        !isWeekend &&
        !isLeave &&
        !isHoliday &&
        Fun.getFormattedDate(currentDate) != Fun.getFormattedDate(date) &&
        !isNextDays) {
      return absentContainer("Absent");
    } else if (isTimeZero() &&
        !isWeekend &&
        Fun.getFormattedDate(currentDate) != Fun.getFormattedDate(date) &&
        !isNextDays &&
        isLeave) {
      return getSrcContainer(leaveImg, "Leave");
    } else if (isTimeZero() &&
        !isWeekend &&
        Fun.getFormattedDate(currentDate) != Fun.getFormattedDate(date) &&
        !isNextDays &&
        !isLeave &&
        isHoliday) {
      return getSrcContainer(holidayImg, "Holiday");
    } else if (!isTimeZero() && !isWeekend) {
      return getPresentTime(sCheckIntime, sCheckOuttime, sTotalTime, progress);
    } else if (Fun.getFormattedDate(currentDate) == Fun.getFormattedDate(date)) {
      return getPresentTime(sCheckIntime, sCheckOuttime, sTotalTime, progress);
    } else if (isNextDays && !isWeekend && !isLeave && !isHoliday) {
      return upComingDays();
    } else if (isNextDays && !isWeekend && isLeave && !isHoliday) {
      return getSrcContainer(leaveImg, "Leave");
    } else {
      if(!isTimeZero()){
        return getPresentTime(sCheckIntime, sCheckOuttime, sTotalTime, progress);
      }else{
        return getSrcContainer(holidayImg, "Holiday");
      }
    }
  }

  return GestureDetector(
      onTap: () {
        if(!isNextDays & !isWeekend && !isTimeZero()){
          attendanceRepBottomSheet(context, sCheckInDate, sTotalTime, "Check Your Location", sCheckOutDate,attendanceList,sDays);
          return;
        } else if (Fun.getFormattedDate(currentDate) == Fun.getFormattedDate(date) && sCheckIntime!="--") {
          attendanceRepBottomSheet(context, sCheckInDate, sTotalTime, "Check Your Location", sCheckOutDate,attendanceList,sDays);
        }
        return;
      },
      child: Card(
          elevation: 0.0,
          child: Stack(
            children: [
              getContainer(),
              Container(
                margin: EdgeInsets.only(top: 23.0, left: 8.0),
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.0,),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(sDays.toString(), textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(color: SColors.black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(sWeekDay, textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(color: SColors.black, fontSize: 13),

                    ),
                  ],
                ),
              ),
            ],
          )));
}
