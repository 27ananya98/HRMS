import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/upcoming_birthdays/controllers/UpcomingBirthdayController.dart';
import 'package:hrms/utils/time_handler.dart';

import '../../../../utils/s_colors.dart';

class UpcomingBirthdayView extends GetView<UpcomingBirthdayController> {
  @override
  final UpcomingBirthdayController controller = Get.put(UpcomingBirthdayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SColors.rozgarRed,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Birthdays List',
          style: GoogleFonts.roboto(
            color: SColors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(SColors.rozgarRed),
            ),
          );
        } else if (controller.filteredBirthdays.value == null ||
            controller.filteredBirthdays.value!.isEmpty) {
          return const Center(child: Text('No upcoming birthdays found'));
        } else {
          return ListView.builder(
            itemCount: controller.filteredBirthdays.value.length,
            itemBuilder: (BuildContext context, int index) {
              var user = controller.filteredBirthdays.value[index];
              return Container(


                margin: const EdgeInsets.all(10),


                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [

                    ListTile(
                      leading:  CircleAvatar(
                        radius: 25,
                        backgroundColor: SColors.rozgarRed,
                        child: Text(getInitials(user.name??""),style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        ),),
                      ),
                      title: Text(
                        user.name ?? '',
                        style: GoogleFonts.roboto(
                          color: SColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Text(
                          '${user.department} - ${user.designation}',
                          style: GoogleFonts.roboto(
                            color: SColors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      trailing: Text(
                        TimeHandler.getWeekAndMonth(user.dateOfBirth.toString()),
                        textAlign: TextAlign.right,
                        style: GoogleFonts.roboto(
                          color: SColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }

  String getInitials(String name) {
    List<String> words = name.trim().split(RegExp(r'\s+')); // Split by spaces
    String initials = words.map((word) => word[0]).join().toUpperCase();
    return initials;
  }
}
