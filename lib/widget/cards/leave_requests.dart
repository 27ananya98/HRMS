import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/s_colors.dart';

class LeaveRequests {
  static Widget getStatusWidget(int? value,bool? isPending,cancellationRequestedBy) {
    if(cancellationRequestedBy != null && isPending == true){
      return Text(
        "Cancellation Requested",
        style: GoogleFonts.roboto(color: SColors.redPigment, fontSize: 16),
      );

    }else if(isPending != null && isPending == true && value != 4){
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 16),
      );

    }else if(value == null) {
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
    }else if (value == 4) {
      return Text(
        "Partially Approved",
        style: GoogleFonts.roboto(color: SColors.smashedPumpkin, fontSize: 16),
      );
    } else {
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
      );
    }
  }


  static Widget leaveRequestCard(
      BuildContext context,
      bool? isPending,
      String sReqOn,
      int? sStatus,
      String sNoOfDays,
      String sFromTo,
      String sType,
      String sAssignedTo,int? cancellationRequestedBy) {
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
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                //height: 100,
                child: Text(
                  sReqOn,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: SColors.black,
                      fontSize: 16),
                ),
              ),
              SizedBox(width: 5),
              getStatusWidget(sStatus,isPending,cancellationRequestedBy),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  // height: 100,
                  child: Text("No. of days",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: SColors.black,
                          fontSize: 16))),
              SizedBox(width: 5),
              Container(
                  // width: MediaQuery.of(context).size.width * 0.35,
                  // height: 100,
                  child: Text("From-To",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: SColors.black,
                          fontSize: 16))),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  //   height: 100,
                  child: Text(sNoOfDays,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 16))),
              SizedBox(width: 5),
              Container(
                  //  width: MediaQuery.of(context).size.width * 0.35,
                  // height: 100,
                  child: Text(
                sFromTo,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: SColors.black,
                          fontSize: 12)
              )),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  // height: 100,
                  child: Text("Type",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: SColors.black,
                          fontSize: 16))),
              SizedBox(width: 5),
              Container(
                // width: MediaQuery.of(context).size.width * 0.35,
                //  height: 100,
                child: Text("Assigned to",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: SColors.black,
                        fontSize: 16)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                // height: 100,
                child: Text(sType,
                    style:
                        GoogleFonts.roboto(color: SColors.black, fontSize: 16)),
              ),
              SizedBox(width: 5),
              Container(
                  //  width: MediaQuery.of(context).size.width * 0.35,
                  //  height: 100,
                  child: Text(
                sAssignedTo,
                maxLines: 2,
                // set the maximum number of lines to display
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
