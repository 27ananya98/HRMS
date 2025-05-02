import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/s_colors.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../model/attendance_drop_down.dart';
import '../../../../utils/drawer_util/custom_drawer.dart';
import '../../../../widget/progress_dialog.dart';
import '../controllers/home_controller.dart';

class HomeView extends CustomDrawerContent {
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Progress Dialog Example',
          theme: ThemeData(primaryColor: SColors.rozgarRed,),
          home: WillPopScope(
            onWillPop: () async {
              Fun.showExitConfirmationDialog(context);
              return false;
            },
            child: UpgradeAlert(
              child: Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      backgroundColor: SColors.rozgarRed,
                      title: Row(
                        children: [
                          // Menu Button
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                            child: Material(
                              shadowColor: Colors.transparent,
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(Icons.menu, color: Colors.white),
                                onPressed: widget.onMenuPressed,
                              ),
                            ),
                          ),
                          // Title
                          const SizedBox(width: 8.0), // Space between menu and title
                          Text(
                            "HRMS",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: SColors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.location_on_outlined,color: Colors.white),
                          tooltip: 'Recenter Map',
                          onPressed: () {
                            controller.moveToGoogleMap(context);                   },
                        ),
                      ],
                    ),
                    body: Obx(() {
                      return ProgressDialog(
                        loading: controller.loading.value,
                        child: Scaffold(
                          body: Stack(
                            children: [
                              RefreshIndicator(
                                onRefresh: () => controller.updateWidgets(),
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Obx(() {
                                        return ScreenWidget.errmsg(
                                            "No Internet Connection Available",
                                            controller.isCheckInternet.value,
                                            controller.updateWidgets);
                                      }),
                                      Obx(() {return ScreenWidget.homeTitle(controller.sUserName.value);}),
                                      // Obx(() {
                                      //   return Container(
                                      //     child: controller.isUpdateWidget.value
                                      //         ? ScreenWidget.getUpdateDialog()
                                      //         : null,
                                      //   );
                                      // }),
                                      const SizedBox(height: 30, width: double.infinity,),
                                      Center(
                                        child: SizedBox(width: 500, height: 250,
                                            child: Image.asset('assets/images/typing-v4.png')),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                                        child: Visibility(visible: controller.isAttendanceListLoaded.value,
                                            child: Obx(() =>
                                                DropdownButton<AttendanceDropDown>(
                                                  value: controller.lsAttendanceType.isNotEmpty
                                                      ? controller.lsAttendanceType[controller.iDropDownMenuIndexNumber.value] : null,
                                                  items: controller.lsAttendanceType.map((AttendanceDropDown item) {
                                                    return DropdownMenuItem<AttendanceDropDown>(
                                                      value: item, child: Text(item.name!,style: GoogleFonts.roboto(
                                                        color: SColors.black, fontSize: 18)),
                                                    );
                                                  }).toList(), onChanged: (AttendanceDropDown? selectedValue) {
                                                  if (selectedValue != null) {
                                                    controller.iDropDownMenuIndexNumber.value = controller.lsAttendanceType.indexOf(selectedValue);
                                                    controller.setAttendanceTypeValue(selectedValue);
                                                  }
                                                },
                                                  hint: const Text('Select a value'),
                                                ))),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                                        child: Visibility(
                                          visible: controller.isStaticDownMenu.value,
                                          child: Text(controller.sStaticDownValue.value,style: GoogleFonts.roboto(color: SColors.black, fontSize: 20)),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
                                            child: Obx(() {
                                              return Text(
                                                controller.timeToDisplay.value,
                                                style: GoogleFonts.roboto(color: SColors.black, fontWeight: FontWeight.w500, fontSize: 24),
                                              );
                                            }),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Obx(() {
                                                  return Visibility(
                                                    visible: controller.isCheckInVisible.value,
                                                    child: SizedBox(
                                                      height: 38,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(SColors.rozgarRed),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), // Set the corner radius here
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          controller.markAttendance(context,true);
                                                        },
                                                        child: Text('Check In', style: GoogleFonts.roboto(color: SColors.white, fontWeight: FontWeight.w500, fontSize: 18)),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                                Obx(() {
                                                  return Visibility(
                                                    visible: controller.isCheckOutVisible.value,
                                                    child: SizedBox(height: 38,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(SColors.rozgarRed),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0), // Set the corner radius here
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          controller.markAttendance(context,false);
                                                        },
                                                        child: Text('Check Out',
                                                            style: GoogleFonts.roboto(color: SColors.white, fontWeight: FontWeight.w500, fontSize: 18)),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
                                        child: Row(
                                          children: [
                                            Container(margin: EdgeInsets.only(right: 10),
                                              child: SizedBox(width: 40,height: 40,
                                                  child: Image.asset('assets/images/ic_announcements.png')),
                                            ),
                                            Text(
                                              'ANNOUNCEMENT',
                                              style: GoogleFonts.roboto(color: SColors.black, fontWeight: FontWeight.w500, fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //     Get.toNamed(AppRoute.myLocationScreen);
                                      //   },
                                      //   child: Text("Check Your Location"),
                                      // ),
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: Colors.black, width: 1,),
                                          ),
                                          child: Obx(() {
                                            return RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(
                                                  text: controller.sAnnouncement.value,
                                                  style: GoogleFonts.nunito(color: SColors.black, fontWeight: FontWeight.w500, fontSize: 16),
                                                ));
                                          })),
                                      const SizedBox(height: 40)
                                    ],
                                  ),
                                ),
                              ),
                              ScreenWidget.mainHome(
                                  context, controller.permissions.value)
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Obx(() => Visibility(
                    visible: controller.isDataLoading.value,
                    child: Container(
                      color: Colors.black.withOpacity(0.95),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child:  Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 120,
                            width: 120,
                            child: Lottie.asset("assets/json/loader.json")),

                      ),
                    ),
                  ))
                ],
              )
            ),
          ),
        );
      },
    );
  }
}
