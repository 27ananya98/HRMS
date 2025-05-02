import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/modules/company/company_directory.dart';
import '../../app/modules/company/holiday_list.dart';
import '../../routes/get_routes.dart';

class Company{
  static Widget companyWidget(BuildContext context) {
    List<Widget> lsTeamOptions =[GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanyDirectory()),
        );
      },
      child:
      Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset( 'assets/images/ic_company_directory.png',height: 80,width: 60,),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "Company Directory",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
      GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HolidayList()),
        );
      },
      child:
      Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/ic_holiday_list.png',height: 80,width: 60,),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "Holiday List",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
      GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.upcomingBirthdayList);
      },
      child:
      Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset( 'assets/images/ic_birthdays.png',height: 80,width: 60,),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "Upcoming Birthday",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
      GestureDetector(
        onTap: () {
          Get.toNamed(AppRoute.event);
        },
        child:
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset( 'assets/images/ic_announcements.png',height: 80,width: 60,),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                        child: Text(
                          "Upcoming Events",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ];
    return   Container(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.5, // Adjust vertical spacing as needed
          crossAxisSpacing: 5.0, // Adjust horizontal spacing as needed
        ),
        itemCount: lsTeamOptions.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
                margin: EdgeInsets.all(5),
                child: Center(child: lsTeamOptions[index])),
          );
        },
      ),
    );
  }

}
//*******************************Code for square containers****************************
// class MyTask extends StatelessWidget {
//   final List<Widget> dynamicList = [
//     Container(
//       padding: EdgeInsets.all(10),
//       child: Container(
//         height: 150,
//         width: 150,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             Image.asset(
//               'assets/images/ic_attendance_regularization.png',
//               height: 80,
//               width: 60,
//             ),
//             Text(
//               "Team Attendance Regularization",
//               textAlign:TextAlign.center,
//               style: GoogleFonts.roboto(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     ),
//
//     // Add more items as needed
//   ];
//
//   final int columns = 2; // Number of columns
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Evenly Distribute List Items in Two Columns with Separators'),
//         ),
//         body: Table(
//           border: TableBorder.all(), // Add borders to the table
//           children: List.generate(
//             (dynamicList.length / columns).ceil(),
//                 (rowIndex) {
//               final startIndex = rowIndex * columns;
//               final endIndex = (rowIndex + 1) * columns;
//               return TableRow(
//                 children: [
//                   for (var i = startIndex; i < endIndex; i++)
//                     TableCell(
//                       child: Column(
//                         children: [
//                           if (i < dynamicList.length)
//                             dynamicList[i],
//                           if (i < endIndex - 1 || (i == endIndex - 1 && dynamicList.length % columns == 1))
//                             Divider(), // Horizontal line except for the last item in the row or when the list size is odd
//                         ],
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
