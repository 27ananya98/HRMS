import 'dart:async';

import 'package:get/get.dart';
import 'package:hrms/routes/get_routes.dart';

import '../../../../utils/prefsKeys.dart';
import '../../../../utils/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    initState();
    super.onInit();
  }
  Future<void> initState() async {
    await 3.delay();
    bool loggedIn = await AppPreferences.shared
        .getBoolSharedPreferences(PrefsKeys.isLogingStatus);
    if (loggedIn) {
      Get.offNamed(AppRoute.drawerHandler);
    } else {
      Get.offNamed(AppRoute.loginView);
    }
  }
}
