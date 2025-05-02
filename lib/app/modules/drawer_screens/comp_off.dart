import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/s_colors.dart';
import 'comp_off/dashboard.dart';
import 'comp_off/report.dart';

class CompOff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Dashboard(),
      Report(),
    ];

    final List<Tab> tabs = [
      const Tab(text: 'Dashboard'),
      const Tab(text: 'Report'),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: SColors.rozgarRed, // Set the color of the progress indicator
        ),
      ),
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: SColors.rozgarRed,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Comp Off',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: SColors.white,
                    fontSize: 16)),
            bottom: TabBar(
              labelStyle:
                  GoogleFonts.roboto(color: SColors.white, fontSize: 14),
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
