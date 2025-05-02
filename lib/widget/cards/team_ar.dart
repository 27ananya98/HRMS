import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/s_colors.dart';
import '../dialogs/team_approval.dart';

class TeamArRequests {
  static Widget getStatusWidget(
      int? value, bool? isPending, cancellationRequestedBy) {
    if (cancellationRequestedBy != null && isPending == true) {
      return Text(
        "Cancellation Requested",
        style: GoogleFonts.roboto(color: SColors.redPigment, fontSize: 16),
      );
    } else if (isPending != null && isPending == true) {
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 16),
      );
    } else if (value == null) {
      return Text(
        "Cancellation Approved",
        style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 16),
      );
    } else if (value == 1) {
      return Text(
        "Approved",
        style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
      );
    } else if (value == 2) {
      return Text(
        "Rejected",
        style: GoogleFonts.roboto(color: SColors.orangeYellow, fontSize: 16),
      );
    } else {
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
      );
    }
  }

  static Widget teamArPendingRequestCard(
      BuildContext context,
      String sCreatedBy,
      String sReqId,
      String attendanceTypeName,
      String outTime,
      String sInOutTime,
      String comment,final Function() refresh) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
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
              // The first item will be at the start
              Text(sCreatedBy),

              // Wrap the two items you want at the end inside Expanded
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TeamApproval(arId:sReqId,
                          callback: () {
                            refresh();
                          },
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Icon(
                          Icons.edit_note_outlined,
                          color: SColors.rozgarRed,
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                    "Request ID",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Attendance Type',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(sReqId,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(attendanceTypeName,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Date",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'In - Out Time',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(outTime,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sInOutTime,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Status",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text("Pending",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.rozgarRed, fontSize: 14)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Comment",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(comment,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget teamArHistoryRequestCard(
      BuildContext context,
      String sCreatedBy,
      String sReqId,
      String attendanceTypeName,
      String outTime,
      String sInOutTime,
      String comment,String statusName) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
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
              Text(sCreatedBy),
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
                    "Request ID",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Attendance Type',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(sReqId,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(attendanceTypeName,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Date",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'In - Out Time',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(outTime,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sInOutTime,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Status",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(statusName,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.apple, fontSize: 14)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Comment",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.grey,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(comment,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
