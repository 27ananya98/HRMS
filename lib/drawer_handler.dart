import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/routes/get_routes.dart';
import 'package:hrms/utils/fun.dart';

import '../../app/modules/drawer_screens/attendance.dart';
import '../../app/modules/drawer_screens/comp_off.dart';
import '../../app/modules/drawer_screens/expense.dart';
import '../../app/modules/drawer_screens/leave.dart';
import '../../app/modules/drawer_screens/my_task.dart';
import '../../utils/s_colors.dart';
import 'app/modules/home/views/home_view.dart';
import 'utils/drawer_util/class_builder.dart';
import 'utils/drawer_util/custom_drawer.dart';

class DrawerHandler extends StatefulWidget {
  DrawerHandler({Key? key}) : super(key: key);

  @override
  _DrawerHandlerState createState() => _DrawerHandlerState();
}

class _DrawerHandlerState extends State<DrawerHandler>
    with TickerProviderStateMixin {
  late CustomDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = CustomDrawerController(
      initialPage: ClassBuilder.fromString('HomeView'),
      items: [
        CustomDrawerItem.initWithPage(
          text: Text('Home', style: GoogleFonts.roboto(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: HomeView(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
      ),
      home: WillPopScope(
          onWillPop: () async {
            Fun.showExitConfirmationDialog(context);
            return false;
          },
          child: Scaffold(
            body: KFDrawer(
              controller: _drawerController,
              header: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 30, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: SColors.rozgarRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'R',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 12),
                        child: Text(
                          'HRMS',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              footer: Container(
                  child: Column(
                children: [
                  CustomDrawerItem(
                    text: Text(
                      'Attendance',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.accessibility, color: Colors.white),
                    onPressed: () {
                      // fun.logOut(context);

                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return Attendance();
                        },
                      ));
                    },
                  ),
                  CustomDrawerItem(
                    text: Text(
                      'Compensatory Off',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.offline_bolt, color: Colors.white),
                    onPressed: () {
                      // fun.logOut(context);

                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return CompOff();
                        },
                      ));
                    },
                  ),
                  CustomDrawerItem(
                    text: Text(
                      'Leave Management',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.account_tree, color: Colors.white),
                    onPressed: () {
                      // fun.logOut(context);

                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return Leave();
                        },
                      ));
                    },
                  ),
                  // CustomDrawerItem(
                  //   text: Text(
                  //     'Salary Slip',
                  //     style: GoogleFonts.roboto(color: Colors.white),
                  //   ),
                  //   icon: Icon(Icons.density_medium_sharp, color: Colors.white),
                  //   onPressed: () {
                  //     // fun.logOut(context);
                  //     Get.toNamed(AppRoute.downloadSalarySlip);
                  //   },
                  // ),
                  CustomDrawerItem(
                    text: Text(
                      'Pay Slip',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.add_chart_rounded, color: Colors.white),
                    onPressed: () {
                      // Navigator.of(context).push(CupertinoPageRoute(
                      //   fullscreenDialog: true,
                      //   builder: (BuildContext context) {
                      //     return SalarySlip();
                      //   },
                      // ));
                     Get.toNamed(AppRoute.downloadPaySlip);
                    },
                  ),
                  CustomDrawerItem(
                    text: Text(
                      'Expense & Reimbursement',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.add_card, color: Colors.white),
                    onPressed: () {
                      // fun.logOut(context);

                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return Expense();
                        },
                      ));
                    },
                  ),
                  CustomDrawerItem(
                    text: Text(
                      'My Task',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.add_circle, color: Colors.white),
                    onPressed: () {
                      // fun.logOut(context);

                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return MyTask();
                        },
                      ));
                    },
                  ),
                  CustomDrawerItem(
                    text: Text(
                      'Feedback Form',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    icon: Icon(Icons.feedback, color: Colors.white),
                    onPressed: () {
                      // Navigator.of(context).push(CupertinoPageRoute(
                      //   fullscreenDialog: true,
                      //   builder: (BuildContext context) {
                      //     return SalarySlip();
                      //   },
                      // ));
                      Get.toNamed(AppRoute.feedback);
                    },
                  ),
                  CustomDrawerItem(
                    text: Text(
                      'Log Out',
                      style: GoogleFonts.roboto(color: SColors.rozgarRed),
                    ),
                    icon: Icon(
                      Icons.input,
                      color: SColors.rozgarRed,
                    ),
                    onPressed: () {
                      Fun.logOut(context);
                    },
                  ),
                ],
              )),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(28, 34, 66, 1.0),
                    Color.fromRGBO(28, 34, 66, 1.0),
                  ],
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
          )),
    );
  }
}
