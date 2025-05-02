import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/company_directory_modal.dart';

import '../../utils/s_colors.dart';

Widget getCompanyDirCard(List<AllEmpList>? list, int index) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0), // Adjust the radius for rounded corners
      border: Border.all(
        color: Colors.black, // Border color
        width: 1.0, // Border width
      ),
    ),
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(""),
            Container(
              decoration: BoxDecoration(
                gradient: list != null && index < list.length && list[index].loginStatusName == "Blocked"
                    ? const LinearGradient(
                  colors: [Colors.red, Colors.white], // Red to white gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : const LinearGradient(
                  colors: [Colors.green, Colors.white], // Green to white gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8), // Optional: for rounded corners
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Optional padding
              child: Text(
                list != null && index < list.length ? list[index].loginStatusName ?? "" : "",
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            )

          ],
        ),
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: SColors.rozgarRed,

              child: Icon(
                Icons.person,
                color: Colors.white, // Set the color of the Icon
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      list![index].name.toString(),
                      textAlign: TextAlign.right,
                      style: GoogleFonts.roboto(
                          color: SColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    SelectableText(
                      list![index].designation.toString(),
                      textAlign: TextAlign.left,
                    )
                  ],
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                      "Department",
                      style: GoogleFonts.roboto(
                          color: SColors.black,
                          fontSize: 12),
                    )),
                Expanded(
                    child: Text(
                      "Email Id",
                      style: GoogleFonts.roboto(
                          color: SColors.black,
                          fontSize: 12),
                    ))
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SelectableText(
                  list[index].department.toString(),
                  style: GoogleFonts.roboto(color: SColors.black,fontWeight: FontWeight.w500,
                      fontSize: 14),
                )),
            Expanded(
                 child: SelectableText(
                  list[index].email.toString(),
                  style:
                  GoogleFonts.roboto(color: SColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                      textAlign: TextAlign.left,
                      "Reporting Manager",
                      style: GoogleFonts.roboto(
                           color: SColors.black,
                          fontSize: 12),
                    )),
                Expanded(
                    child: Text(
                      textAlign: TextAlign.left,
                      "Work Location",
                      style: GoogleFonts.roboto(
                           color: SColors.black,
                          fontSize: 12),
                    ))
              ],
            )),
        Row(
          children: [
            Expanded(
                child: SelectableText(
                    textAlign: TextAlign.left,
                    list![index].reportingManager.toString(),
                    style: GoogleFonts.roboto(
                        color: SColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14))),
            Expanded(
                child: SelectableText(
                  textAlign: TextAlign.left,
                  list![index].workLocation.toString(),
                  style: GoogleFonts.roboto(color: SColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ))
          ],
        ),
        // Container(
        //     margin: EdgeInsets.only(top: 20),
        //     child: Row(
        //       children: [
        //         Container(
        //             child: Text(
        //               "Department",
        //               style: GoogleFonts.roboto(
        //                    color: SColors.black,
        //                   fontSize: 12),
        //             ))
        //       ],
        //     )),
        // Row(
        //   children: [
        //     Container(
        //         margin: EdgeInsets.only(bottom: 20),
        //         child: SelectableText(
        //           list[index].department.toString(),
        //           style:
        //           GoogleFonts.roboto(color: SColors.black,
        //               fontWeight: FontWeight.w500,
        //               fontSize: 14),
        //         ))
        //   ],
        // ),
        SizedBox(height: 20)
      ],
    ),
  );
}
