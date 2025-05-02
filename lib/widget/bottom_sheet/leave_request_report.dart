import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';

import '../../model/leave_status.dart';
import '../../model/leaves_report.dart';
import '../../utils/s_colors.dart';
import '../../utils/time_handler.dart';
import '../dialogs/cancel_leave.dart';

Widget getStatusWidget(int? value) {
  if (value == null) {
    return Text(
      "Cancellation Approved",
      style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 16),
    );
  } else if (value == 2) {
    return Text(
      "Rejected",
      style: GoogleFonts.roboto(color: SColors.orangeYellow, fontSize: 16),
    );
  } else {
    return Text(
      "Approved",
      style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
    );
  }
}

bool setCancelButtonVisible(value) {
  if (value == null) {
    return false;
  } else if (value == 2) {
    return false;
  } else {
    return true;
  }
}


leaveRepBottomSheet(
    BuildContext context, LeaveStatus response, String leaveTypeName) {
  String startDate = TimeHandler.convertDate(TimeHandler.getDateFromUnix(
      response.result!.detail!.startDate.toString().substring(0, 10)));
  String endDate = TimeHandler.convertDate(TimeHandler.getDateFromUnix(
      response.result!.detail!.endDate.toString().substring(0, 10)));
  String createdOn =
      Fun.formatDateTimeString(response.result!.detail!.createdOn.toString());
  int length = response.result!.comments!.length;

  String approvedOn = Fun
      .formatDateTimeString(response.result!.comments![length-1].createdOn.toString());
  bool isCancelButtonVisible =
      setCancelButtonVisible(response.result!.detail!.leaveStatusId);
  int? id = response.result!.detail!.id;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 350,
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Visibility(
              visible: isCancelButtonVisible,
              child: Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CancelLeave(id);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                      color: SColors.rozgarRed,
                      width: 2,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 0,
                    primary: Colors.transparent,
                    onPrimary: SColors.rozgarRed,
                  ),
                  child: Text('REQUEST CANCELLATION'),
                ),
              ),
            ),
            SizedBox(height: 10), // Add some spacing between circle and line
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(startDate + " - " + endDate),
                      Text(response.result!.detail!.reason!),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 4),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Add some spacing between circle and line
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leaveTypeName,
                        style: GoogleFonts.roboto(
                            color: SColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(response.result!.detail!.createdByName!,
                          style: GoogleFonts.roboto(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(
                        response.result!.detail!.createdByDesignation!,
                        style: GoogleFonts.roboto(color: SColors.black),
                      ),
                      Text(
                        createdOn,
                        style: GoogleFonts.roboto(color: SColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        approvedOn,
                        style: GoogleFonts.roboto(color: SColors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 4),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Add some spacing between circle and line
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getStatusWidget(response.result!.detail!.leaveStatusId),
                      Text(
                        response.result!.comments![0].comment!,
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                      Text(
                        response.result!.comments![0].createdByName!,
                        style: GoogleFonts.roboto(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

leavePendingBottomSheet(
    BuildContext context, Pending response, String leaveTypeName) {
  String startDate = TimeHandler.convertDate(TimeHandler.getDateFromUnix(
      response.startDate.toString().substring(0, 10)));
  String endDate = TimeHandler.convertDate(TimeHandler.getDateFromUnix(
      response.endDate.toString().substring(0, 10)));
  String createdOn = Fun.formatDateTimeString(response.createdOn.toString());
  int? id = response.id;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 350,
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CancelLeave(id);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: SColors.rozgarRed,
                    width: 2,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  primary: Colors.transparent,
                  onPrimary: SColors.rozgarRed,
                ),
                child: Text('REQUEST CANCELLATION'),
              ),
            ),
            SizedBox(height: 10), // Add some spacing between circle and line
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(startDate + " - " + endDate),
                      Text(response.reason!),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 4),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Add some spacing between circle and line
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leaveTypeName,
                        style: GoogleFonts.roboto(
                            color: SColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(response.createdByName!,
                          style: GoogleFonts.roboto(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(
                        response.createdByDesignation!,
                        style: GoogleFonts.roboto(color: SColors.black),
                      ),
                      Text(
                        createdOn,
                        style: GoogleFonts.roboto(color: SColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
