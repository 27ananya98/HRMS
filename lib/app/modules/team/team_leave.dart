import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/team/team_leave/team_leave_history.dart';
import 'package:hrms/app/modules/team/team_leave/team_leave_pending.dart';
import 'package:hrms/app/modules/team/team_leave/watcher_request.dart';

import '../../../../utils/s_colors.dart';


class TeamLeave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      TeamLeavePending(),
      TeamLeaveHistory(),
      WatcherRequest(),
    ];

    final List<Tab> tabs = [
      Tab(text: 'Pending'),
      Tab(text: 'History'),
      Tab(text: 'Watcher'),
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
              icon: Icon(Icons.arrow_back,color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('LEAVE APPROVAL', style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 18)),
            bottom: TabBar(
              labelStyle: GoogleFonts.roboto(
                  color: SColors.white,
                  fontSize: 14),
              unselectedLabelColor: Colors.white,
              tabs: tabs,
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
