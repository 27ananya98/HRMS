import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/mng_home_pages/controllers/mang_home_controller.dart';

import '../../../../utils/s_colors.dart';
import '../../../../widget/home_page_cards/company.dart';
import '../../../../widget/home_page_cards/employee.dart';
import '../../../../widget/home_page_cards/team.dart';

class MangHomeView extends GetView<MangHomeController> {
  MangHomeController controller = Get.put(MangHomeController());
  final PageController _controller = PageController(initialPage: 0);
  List<String> pageTitles = ["Employee", "Teams", "Company"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SColors.rozgarRed,
        iconTheme: IconThemeData(color: Colors.white),
        title: Obx(() {
          return Text(
            pageTitles[controller.iCurrentPage.value],
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: SColors.white,
              fontSize: 18,
            ),
          );
        }),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                controller.iCurrentPage.value = index;
              },
              children: [
                Employee.employeeWidget(context),
                Obx(() {
                  return Team.teamWidget(context, controller.permissionsList);
                }),
                Company.companyWidget(context),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              3,
              (index) => Obx(() {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.iCurrentPage.value == index
                        ? SColors.rozgarRed
                        : Colors.grey,
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
