
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/widget/dialogs/edit_family.dart';

import '../../utils/s_colors.dart';

class FamilyDetailCard {
  static Widget getFamilyListCard(BuildContext context,
      String sId,
      String sName,
      String sRelation,
      String sEdit,
      String sDOB,
      String sNumber,
      String? sEmail,
      String sEmgCnt,
      String sDepartment,Function  refresh)
  {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(sName, style: GoogleFonts.roboto(
                     color: SColors.black,
                    fontSize: 14)),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditFamilyDetail(sId:sId,sRelation:sRelation,fullName:sName,email:sEmail!,number:sNumber,dob:sDOB,callback: (){
                          refresh();
                        },);
                      },
                    );
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Text(
                      //   "Edit",
                      //   style: GoogleFonts.roboto(
                      //       fontWeight: FontWeight.w500,
                      //       color: SColors.rozgarRed,
                      //       fontSize: 14),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration:
                        const BoxDecoration(color: Colors.white),
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
          Row(
            children: [
              Expanded(
                child: Text(sRelation),
              ),
              Expanded(
                child: Text(""),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: Text("DOB",style: GoogleFonts.roboto(
                     color: SColors.black,
                    fontSize: 14)),
              ),
              Expanded(
                child: Text("Mobile",style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(sDOB,style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
              Expanded(
                child: Text(sNumber,style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: Text("Email ID",style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
              Expanded(
                child: Text(sEmail!,style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: Text("Emergency Contact",style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
              Expanded(
                child: Text("Dependant",style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(sEmgCnt,style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
              Expanded(
                child: Text(sDepartment,style: GoogleFonts.roboto(
                    color: SColors.black,
                    fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
