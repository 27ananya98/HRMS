import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/s_colors.dart';
import 'attendance/dashboard.dart';
import 'attendance/regularization.dart';
import 'attendance/report.dart';


class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Dashboard(),
      Report(),
      Regularization(),
    ];

    final List<Tab> tabs = [
      Tab(text: 'Dashboard',),
      Tab(text: 'Report'),
      Tab(text: 'Regularization'),
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
            iconTheme: IconThemeData(color: Colors.white),
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('My Attendance', style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 16)),
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
