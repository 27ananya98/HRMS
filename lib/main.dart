import 'dart:io' show Platform;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hrms/routes/app_routes.dart';
import 'package:hrms/routes/get_routes.dart';
import 'package:hrms/utils/shared_preferences_helper.dart';

import 'fcm/firebase_config.dart';
import 'utils/drawer_util/class_builder.dart';


void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAo_8ppx1F8el5e8w7glHUmux6aj2RwERE",
          appId: "1:1057857029844:ios:f590bf86175d23a23a1d41",
          messagingSenderId: "1057857029844",
          projectId: "value-innovation-labs"),
    );
  } else {
    await Firebase.initializeApp();
  }
  FirebaseConfig().config();
  ClassBuilder.registerClasses();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    final sharedPreferencesHelper = SharedPreferencesHelper();
    sharedPreferencesHelper.printAllSharedPreferences();
    return GetMaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      getPages: GetAppRoute().getRoutes(),
      initialRoute: AppRoute.initial,
      debugShowCheckedModeBanner: false,
    );
  }
}