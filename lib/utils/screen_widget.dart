import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/s_colors.dart';

import '../../app/modules/drawer_screens/attendance.dart';
import '../../app/modules/drawer_screens/comp_off.dart';
import '../../app/modules/drawer_screens/leave.dart';
import '../routes/get_routes.dart';

class ScreenWidget {
  static Widget homeTitle(String title) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        //    bottom: 30
      ), // set the margin for each side
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: title,
            style: GoogleFonts.nunito(
                color: SColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
    );
  }

  static Widget errmsg(String text, bool show, final Function() refresh) {
    if (show == true) {
      //if error is true then show error message box
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: SColors.rozgarRed,
        child: Row(children: [
          GestureDetector(
            onTap: (() {
              refresh();
            }),
            child: Container(
              margin: EdgeInsets.only(right: 6.00),
              child: Icon(Icons.refresh, color: Colors.white),
            ),
          ), // icon for error message

          Text(text, style: GoogleFonts.roboto(color: Colors.white)),
          //show error message text
        ]),
      );
    } else {
      return Container();
      //if error is false, return empty container.
    }
  }

  static Widget mainHome(BuildContext context, List<dynamic> list) {
    bool isManagerPermissions = false;
    list.forEach((element) {
      if (element.toString().substring(0, 1) == '1') {
        isManagerPermissions = true;
        return;
      }
    });
    if (isManagerPermissions) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.mangHomeView);
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset('assets/images/ic_floating.png')),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.empHomeView);
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset('assets/images/ic_floating.png')),
              ),
            ),
          ],
        ),
      );
    }
  }

  static Widget homeDrawerScreens(
      BuildContext context, String sName, String sMobile) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: SColors.rozgarRed),
                    child: Center(
                      child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset(
                              'assets/images/ic_services_profile.png')),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Column(
                      children: [
                        Text(
                          sName,
                          style: GoogleFonts.roboto(color: Colors.white),
                        ),
                        Text(
                          sMobile,
                          style: GoogleFonts.roboto(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.only(left: 20),
                  //     child: Container(
                  //       decoration: const BoxDecoration(color: SColors.rozgarRed),
                  //       child: Center(
                  //         child: SizedBox(
                  //             width: 30,
                  //             height: 30,
                  //             child: new IconButton(
                  //               padding: new EdgeInsets.all(0.0),
                  //               color: Colors.white,
                  //               icon: new Icon(Icons.edit, size: 18.0),
                  //               onPressed: () => {print("edit button press")},
                  //             )),
                  //       ),
                  //     ))
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: SColors.rozgarRed,
            ),
          ),
          ListTile(
            title: Text('Attendance'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Attendance()));
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text("Attendance")));
            },
          ),
          ListTile(
            title: Text('Comp off'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CompOff()));
            },
          ),
          ListTile(
            title: Text('Leave'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Leave()));
            },
          ),
          ListTile(
            title: Text('Expense & Reimbursement'),
            onTap: () {
              Fun.showToast("Coming Soon...");
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Expense()));
            },
          ),
          ListTile(
            title: Text('My Task'),
            onTap: () {
              Fun.showToast("Coming Soon...");
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MyTask()));
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              Fun.logOut(context);
              // Navigator.pop(context);
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text("Log Out")));
            },
          ),
        ],
      ),
    );
  }

  static Widget disBetween(double i) {
    return Container(
      height: i, // set the height of the space
      width: double
          .infinity, // set the width of the space to be as wide as its parent
    );
  }

  static Widget getLoadingUICircular(BuildContext context) {
    return Container(
        color: SColors.white.withOpacity(0.8),
        width: 35,
        height: 25,
        child: const Center(
            heightFactor: 5.0,
            widthFactor: 5.0,
            child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: SColors.smashedPumpkin,
                    valueColor:
                        AlwaysStoppedAnimation(SColors.smashedPumpkin)))));
  }

  static Widget getUpdateDialog() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.0),
          Text(
            "Update Available!",
            style: GoogleFonts.roboto(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Please update to the latest version to access new features and improvements.",
            style: GoogleFonts.roboto(fontSize: 14.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(SColors.rozgarRed),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // Set the corner radius here
                      ),
                    ),
                  ),
                  child: Text("Update",style: GoogleFonts.roboto(color: Colors.white),),
                  onPressed: () {
                    Fun.updateApp();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static invalidUserNamePass(BuildContext context) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning,
                    color: SColors.rozgarRed,
                    size: 50.0,
                  ),
                  SizedBox(height: 20.0),
                  const Text(
                    'Warning',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  const Text(
                   "Invalid username and password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: SColors.rozgarRed,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  }
}
