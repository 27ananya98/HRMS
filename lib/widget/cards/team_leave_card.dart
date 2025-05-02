import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';

import '../../utils/s_colors.dart';
import '../dialogs/team_leave_approval.dart';
import '../dialogs/team_leave_approval_p.dart';

class TeamLeaveRequests {
  static Widget getWatchStatus(
      int? leaveStatusId, bool? isPending, cancellationRequestedBy,iCancellationStatusId,iCancellationRequestedBy) {
    if (cancellationRequestedBy != null && isPending == false && leaveStatusId==1 && iCancellationStatusId == null) {
      return Text(
        "Cancellation Requested1",
        style: GoogleFonts.roboto(color: SColors.redPigment, fontSize: 16),
      );
    } else if (cancellationRequestedBy != null && isPending == false && leaveStatusId==2) {
      return Text(
        "Cancellation Requested2",
        style: GoogleFonts.roboto(color: SColors.rozgarRed, fontSize: 16),
      );
    } else if (isPending == false && iCancellationStatusId == 1) {
      return Text(
        "Cancellation Approved",
        style: GoogleFonts.roboto(color: SColors.lightGreen, fontSize: 16),
      );
    }  else if (isPending == false && leaveStatusId==2 && cancellationRequestedBy == null) {
      return Text(
        "Rejected",
        style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
      );
    } else if (isPending == false && leaveStatusId==1 && cancellationRequestedBy == null) {
      return Text(
        "Approved",
        style: GoogleFonts.roboto(color: SColors.apple, fontSize: 16),
      );
    }else {
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.redPigment, fontSize: 16),
      );
    }
  }
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

  static Widget getLeaveStatus(int? leaveStatusId) {
    if (leaveStatusId == null) {
      return Text(
        "Pending",
        style: GoogleFonts.roboto(color: SColors.redPigment, fontSize: 14),
      );
    } else {
      return Text(
        "Partially Approved",
        style: GoogleFonts.roboto(color: SColors.orangeYellow, fontSize: 14),
      );
    }
  }

  static Widget teamLeavePendingRequestCard(
      BuildContext context,
      bool? isPending,
      String sCreatedBy,
      String sReqId,
      int? sStatus,
      String sNoOfDays,
      String sFromTo,
      String sCreateOn,
      String sType,
      String sAssignedTo,
      int? cancellationRequestedBy,
      String? modifiedByName,
      String? reason,
      String? reRequestId,
      final Function() refresh,
      final Function(bool) loading) {
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
                    loading(true);
                    ApiHandler().getTeamLeaveType(reRequestId).then((value) => {
                          loading(false),
                          if (value.result?.secondLevelApproval != null &&
                              value.result?.detail?.leaveStatusId != 4)
                            {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TeamLeaveApprovalP(
                                    arId: reRequestId!,
                                    callback: () {
                                      refresh();
                                    },
                                  );
                                },
                              )
                            }
                          else
                            {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TeamLeaveApproval(
                                    arId: reRequestId!,
                                    callback: () {
                                      refresh();
                                    },
                                  );
                                },
                              )
                            }
                        });
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
                    'Leave Type',
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
                  child: Text(sType,
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
                    "From - To",
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
                    'No. of Days',
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
                  child: Text(sFromTo,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sNoOfDays,
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
                    "Assign To",
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
                    'Requested On',
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
                  child: Text(sAssignedTo,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sCreateOn,
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
                    "Modified By",
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
                    'Status',
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
                  child: Text(modifiedByName!,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: getLeaveStatus(sStatus),
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
                  child: Text(reason!,
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

  static Widget teamLeaveHistoryRequestCard(
      BuildContext context,
      bool? isPending,
      String sCreatedBy,
      String sReqId,
      int? sStatus,
      String sNoOfDays,
      String sFromTo,
      String sCreateOn,
      String sType,
      String sAssignedTo,
      int? cancellationRequestedBy,
      String? modifiedByName,
      String? reason) {
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
                    'Leave Type',
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
                  child: Text(sType,
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
                    "From - To",
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
                    'No. of Days',
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
                  child: Text(sFromTo,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sNoOfDays,
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
                    "Assign To",
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
                    'Requested On',
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
                  child: Text(sAssignedTo,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sCreateOn,
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
                    "Modified By",
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
                    'Status',
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
                  child: Text(modifiedByName!,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: getStatusWidget(
                      sStatus, isPending, cancellationRequestedBy),
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
                  child: Text(reason!,
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

  static Widget teamLeaveWatchCard(
      BuildContext context,
      bool? isPending,
      String sCreatedBy,
      String sReqId,
      int? leaveStatusId,
      int? iCancellationStatusId,
      String sNoOfDays,
      String sFromTo,
      String sCreateOn,
      String sType,
      String sAssignedTo,
      int? cancellationRequestedBy,
      String? modifiedByName,
      String? reason) {
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
                    'Leave Type',
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
                  child: Text(sType,
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
                    "From - To",
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
                    'No. of Days',
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
                  child: Text(sFromTo,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sNoOfDays,
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
                    "Assign To",
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
                    'Requested On',
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
                  child: Text(sAssignedTo,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(sCreateOn,
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
                    "Modified By",
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
                    'Status',
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
                  child: Text(modifiedByName!,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: SColors.black, fontSize: 14)),
                ),
              ),
              Expanded(
                child: Container(
                  child: getWatchStatus(
                      leaveStatusId, isPending, cancellationRequestedBy,iCancellationStatusId,cancellationRequestedBy),
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
                  child: Text(reason!,
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
