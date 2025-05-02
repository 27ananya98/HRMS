import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/s_colors.dart';
import 'leave/holiday_page.dart';
import 'leave/leave_dash.dart';
import 'leave/leave_request.dart';

class Leave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      LeaveDash(),
      LeaveRequest(),
      HolidayPage(),
    ];

    final List<Tab> tabs = [
      Tab(text: 'Dashboard'),
      Tab(text: 'Request'),
      Tab(text: 'Holiday List'),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: SColors.rozgarRed, // Set the color of the progress indicator
        ),
      ),
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: SColors.rozgarRed,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Leave', style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 16)),
            bottom: TabBar(
              labelStyle: GoogleFonts.roboto(
                  color: SColors.white,
                  fontSize: 14),
              tabs: tabs,
              unselectedLabelColor: Colors.white,
              indicatorColor:
                  Colors.white, // Set the color of the tab indicator
            ),
          ),
          body: TabBarView(
            children: pages,
          ),
        ),
      ),
    );
  }
}
