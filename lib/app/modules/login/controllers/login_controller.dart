import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:http/http.dart' as http;

import '../../../../api/app_url.dart';
import '../../../../drawer_handler.dart';
import '../../../../utils/prefsKeys.dart';
import '../../../../utils/shared_preferences.dart';

class LoginController extends GetxController {
  final context = Get.context;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController orgController = TextEditingController();
  final TextEditingController phController = TextEditingController();

  RxBool loading = false.obs;
  void _startLoading() {
    loading.value = true;
    Future.delayed(Duration(seconds: 10), () {
      _stopLoading();
    });
  }

  void _stopLoading() {
    loading.value = false;
  }

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  RxBool isEmailCorrect = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  RxBool isLoading = false.obs;
  RxString sOrgId = "".obs;
  RxString sPhoneNumber = "".obs;
  RxString sPassword = "".obs;

  loginCheck() async {
    var isConnect = await Fun.checkInterNet();
    if (!isConnect) {
      Fun.showToast("No internet connection");
    } else {
      _submit();
    }
  }

  void _submit() {
    final isValid = formKey.value.currentState!.validate();
    if (!isValid) {
      return;
    }
    makePostRequest(sPhoneNumber.value, sPassword.value, sOrgId.value);
    formKey.value.currentState!.save();
  }

  makePostRequest(
      String sPhoneNumber,
      String sPassword,
      String sOrgId,
      ) async {
    AppUrl obj = AppUrl();
    _startLoading();
    //ps.show();
    var response = await http
        .post(Uri.parse(await obj.getBaseUrl() + AppUrl.sLogin), body: {
      "input": sPhoneNumber,
      "password": sPassword,
      "company_code": sOrgId
    });
    if (response.statusCode == 200) {
      print(response.body);
      var data = json.decode(response.body);
      var status = data["status"];
      if (status.toString() == "true") {
        String jsonString = json.encode(data);
        AppPreferences.shared
            .saveSharedPreferences(PrefsKeys.sLoging, jsonString);
        AppPreferences.shared
            .saveBoolSharedPreferences(PrefsKeys.isLogingStatus, true);
        _stopLoading();
        Navigator.pushReplacement(
            context!, MaterialPageRoute(builder: (context) => DrawerHandler()));
      } else {
        _stopLoading();
        ScreenWidget.invalidUserNamePass(context!);
       // Fun.showDefaultDialog("Alert", "Incorrect username or password");
      }
    } else {
      _stopLoading();
      Fun.showToast("Something went wrong...");
    }
  }
  RxBool obscureText = true.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
