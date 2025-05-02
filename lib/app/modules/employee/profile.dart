import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/employee/employee_pages/document.dart';
import 'package:hrms/app/modules/employee/employee_pages/education.dart';
import 'package:hrms/app/modules/employee/employee_pages/family.dart';
import 'package:hrms/app/modules/employee/employee_pages/work_exp.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../api/api_handler.dart';
import '../../../../api/app_url.dart';
import '../../../../model/profile_name.dart';
import '../../../../model/profile_response.dart';
import '../../../../utils/prefsKeys.dart';
import '../../../../utils/s_colors.dart';
import '../../../../utils/shared_preferences.dart';
import '../../../../widget/dialogs/edit_profile_pic.dart';
import 'employee_pages/address.dart';
import 'employee_pages/bank.dart';
import 'employee_pages/basic.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  String sUserName = "--";
  String sDesignation = "--";
  String sEmail = "--";
  bool isProgressRunning = false;
  String? sProfileLink;

  @override
  void initState() {
    super.initState();
    setProfile();
  }

  setProfile() {
    try {
      getUserProfile();
      getProfileName();
      getEmployeeDetails();
    } catch (e) {
      Fun.showToast("Something went wrong");
    }
  }
  getEmployeeDetails() async {
    String value =
    await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    var response = await ApiHandler().getEmployeeDetailJ(id);
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    Map<String, dynamic>? workingDetail = jsonResponse['result']['workDetail'];
    if (workingDetail != null) {
      WorkDetail workDetail = WorkDetail.fromJson(workingDetail);
      setState(() {
        sDesignation = workDetail.designation.toString();
      });
    }
  }


  getProfileName() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    int id = jsonMap['result']['id'];
    ProfileName responce = await ApiHandler().getProfileName(id);
    String sName = responce.result!.profilePicture;
    String sBaseUrl = await AppUrl.url.getBaseUrl();
    setState(() {
      sProfileLink = "$sBaseUrl/profile-picture/mtc/$id/$sName";
    });
  }

  Widget setProfilePic() {
    if (sProfileLink == null) {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: ClipOval(
            child: Image.network(
              sProfileLink!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Handle the error by displaying a placeholder image or an error message
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }

  Future getUserProfile() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    setState(() {
      sUserName = jsonMap['result']['name'];
      // id = jsonMap['result']['id'];
      sEmail = jsonMap['result']['email_id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [];

    pages = [
      Basic(),
      Family(),
      Address(),
      Education(),
      WorkExp(),
      Bank(),
      Document(),
    ];

    final List<Tab> tabs = [
      const Tab(
        icon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        text: 'Basic',
      ),
      const Tab(icon: Icon(Icons.group, color: Colors.black), text: 'Family'),
      const Tab(icon: Icon(Icons.location_on, color: Colors.black), text: 'Address'),
      const Tab(icon: Icon(Icons.school, color: Colors.black), text: 'Education'),
      const Tab(icon: Icon(Icons.work, color: Colors.black), text: 'WorkExp'),
      const Tab(icon: Icon(Icons.account_balance, color: Colors.black), text: 'Bank'),
      const Tab(icon: Icon(Icons.description, color: Colors.black), text: 'Document'),
    ];

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text('My Profile',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: SColors.white,
                    fontSize: 18)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    setProfilePic(),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sUserName,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sDesignation,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sEmail,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditProfilePic(
                                callback: () {
                                  getProfileName();
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Icon(
                                Icons.edit_note_outlined,
                                color: SColors.rozgarRed,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  color: Colors.white,
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 0.1),
                    labelStyle: GoogleFonts.roboto(
                        color: SColors.black,
                        fontSize: 10),
                    tabs: tabs,
                    indicatorColor:
                        Colors.red, // Set the color of the tab indicator
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: pages,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: isProgressRunning,
            child: Fun.getLoadingUICircular(context))
      ],
    );
  }

  @override
  void onClickClick() {
    try {
      print("onClickClick");
    } catch (e) {
      print(e);
    }
  }
}
