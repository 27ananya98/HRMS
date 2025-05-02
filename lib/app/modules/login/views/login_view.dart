import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/login/controllers/login_controller.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../api/app_url.dart';
import '../../../../utils/prefsKeys.dart';
import '../../../../utils/s_colors.dart';
import '../../../../utils/shared_preferences.dart';
import '../../../../widget/dialogs/forgot_password.dart';
import '../../../../widget/progress_dialog.dart';

class LoginView extends GetView<LoginController> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
      ),
      home: WillPopScope(onWillPop: () async {
        Fun.showExitConfirmationDialog(context);
        return false;
      }, child: Scaffold(
        body: Obx(() {
          return ProgressDialog(
            loading: controller.loading.value,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        AppPreferences.shared.saveSharedPreferences(
                            PrefsKeys.sTestUrl, AppUrl.sTestURL);
                        Fun.showToast("Test Mode On...");
                      },
                      child: Image.asset(
                        'assets/images/splash_logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Welcome!',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: SColors.black,
                              fontSize: 25),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('Please login to your account',
                            style: GoogleFonts.roboto(
                                color: SColors.black, fontSize: 14))),

                    const SizedBox(
                      height: 5,
                    ),

                    Form(
                      key: controller.formKey.value,
                      child: Column(
                        children: <Widget>[
                          //styling
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              controller: controller.orgController,
                              decoration: InputDecoration(
                                labelText: 'Org Id*',
                                labelStyle: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: SColors.rozgarRed),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                //Validator
                              },
                              onChanged: (text) {
                                controller.sOrgId.value =
                                    text.replaceAll(RegExp(r'[^0-9]'), '');
                                controller.orgController.text =
                                    controller.sOrgId.value;
                              },
                              validator: (value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'Enter a valid organization id!';
                                }
                                controller.sOrgId.value = value;
                                return null;
                              },
                            ),
                          ),
                          //box styling
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              controller: controller.phController,
                              decoration: InputDecoration(
                                labelText: 'Phone No*',
                                labelStyle: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: SColors.rozgarRed),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                controller.sPhoneNumber.value =
                                    text.replaceAll(RegExp(r'[^0-9]'), '');
                                controller.phController.text =
                                    controller.sPhoneNumber.value;
                              },
                              onFieldSubmitted: (value) {
                              },
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return 'Enter a valid phone number';
                                }
                                controller.sPhoneNumber.value = value;
                                return null;
                              },
                            ),
                          ),
                          //box styling
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 20.0),
                            child: TextFormField(
                              obscureText: controller.obscureText.value,
                              onFieldSubmitted: (value) {},
                              validator: (value) {
                                if (value!.isEmpty || value.length < 2) {
                                  return 'Enter a valid password!';
                                }
                                controller.sPassword.value = value;
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SColors
                                          .rozgarRed), // Set the border color here
                                ),
                                labelStyle: GoogleFonts.roboto(
                                    color: SColors.black, fontSize: 14),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscureText.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    controller.obscureText.value =
                                        !controller.obscureText.value;
                                  },
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor: SColors.rozgarRed,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              3.3,
                                      vertical: 15)
                                  // padding: EdgeInsets.only(
                                  //     left: 120, right: 120, top: 20, bottom: 20),
                                  ),
                              onPressed: () => {controller.loginCheck()},
                              child: Text(
                                'LOGIN',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    color: SColors.white,
                                    fontSize: 16),
                              )),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ForgetPassword();
                              },
                            );
                          },
                          child: Text(
                            'Reset Password',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: SColors.rozgarRed,
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      )),
    );
  }
}
