import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/team/team_attendance_ar/team_ar_history.dart';
import 'package:hrms/app/modules/team/team_attendance_ar/team_ar_pending.dart';

import '../../../../utils/s_colors.dart';


class TeamAttendanceAr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      TeamArPending(),
      TeamArHistory(),
    ];

    final List<Tab> tabs = [
      Tab(text: 'Pending'),
      Tab(text: 'History'),
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
              icon: Icon(Icons.arrow_back,color:Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('AR APPROVAL', style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 18)),
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
