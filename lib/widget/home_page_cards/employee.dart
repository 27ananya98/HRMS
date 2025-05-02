import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/routes/get_routes.dart';

import '../../app/modules/employee/profile.dart';

class Employee {
  static Widget employeeWidget(BuildContext context) {
    List<Widget> lsTeamOptions = [GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
      },
      child:
      Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/ic_services_profile.png',height: 80,width: 60,),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "My Profile",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.attendance);
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
              Image.asset('assets/images/ic_attendance.png',height: 80,width: 60,),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "Attendance",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.compOff);
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
              Image.asset('assets/images/ic_comp_off.png',height: 80,width: 60,),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "Comp Off",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.leave);
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
              Image.asset('assets/images/ic_leaves.png',height: 80,width: 60,),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "Leave",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ), GestureDetector(
        onTap: () {
          Get.toNamed(AppRoute.expense);
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
                Image.asset('assets/images/ic_expense.png',height: 80,width: 60,),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                        child: Text(
                          "Expense & Reimbursement",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),GestureDetector(
        onTap: () {
          Get.toNamed(AppRoute.myTask);
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
                Image.asset('assets/images/ic_create_task.png',height: 80,width: 60,),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                        child: Text(
                          "My Task",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ))];
    return  Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
