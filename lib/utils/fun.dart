import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // Import the dart:io package

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cr_file_saver/file_saver.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/model/attendance_report_m.dart';
import 'package:hrms/utils/permission_util.dart';
import 'package:hrms/utils/prefsKeys.dart';
import 'package:hrms/utils/shared_preferences.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/s_colors.dart';
import '../api/app_url.dart';
import '../routes/get_routes.dart';
import 'constants.dart';

class Fun {
  static const platform = MethodChannel('flutter.native/kotlin_helper');
  Future<Map<String, String>> getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = 'Unknown';
    String deviceName = 'Unknown';

    Future<bool> isFileSizeExceeded(File file) async {
      try {
        int size = await file.length();
        const int maxSize = 5 * 1024 * 1024; // 5MB in bytes
        if (size <= maxSize) {
          return false; // File size is within the limit (5MB)
        } else {
          return true; // File size exceeds the limit
        }
      } catch (e) {
        print('Error getting file size: $e');
        return true; // Error occurred, consider it as exceeding the limit
      }
    }

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id; // Unique ID on Android
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!; // Unique ID on iOS
        deviceName = iosInfo.utsname.machine;
      }
    } catch (e) {
      print('Error getting device details: $e');
    }

    return {'deviceId': deviceId, 'deviceName': deviceName};
  }
  static invalidToken(BuildContext context) async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offNamed(AppRoute.loginView);
  }

  static String capitalizeFirstLetter(String? text) {
    if (text == null || text.isEmpty) {
      return 'N/A';
    }
    return text[0].toUpperCase() + text.substring(1);
  }
  void showDisclosureDialog(
      BuildContext context,
      Function onDeny,
      Function onAllow,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Location Access Required'),
          content: Text(
            'HR Management - Rozgar collects location data to enable attendance tracking even when the app is closed or not in use. '
                'This is required to manage attendance reports.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDeny();
              },
              child: Text('Deny'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onAllow();
              },
              child: Text('Allow'),
            ),
          ],
        );
      },
    );
  }
  static isDeveloperOptionsEnabled() async {
    try {
      final bool isEnabled =
          await platform.invokeMethod('isDeveloperOptionsEnabled');
      return isEnabled;
    } on PlatformException catch (e) {
      print('Error checking developer options: ${e.message}');
      return false;
    }
  }

  static DateTime parseDateFromString(String inputDateString) {
    try {
      DateTime dateTime = DateTime.parse(inputDateString);
      return dateTime;
    } catch (e) {
      return DateTime.now();
    }
  }

  static DateTime convertDate(String inputDate) {
    try {
      DateTime parsedDate = DateFormat('dd MMM yyyy').parse(inputDate);
      return parsedDate;
    } catch (e) {
      try {
        DateTime parsedDate = DateFormat('dd MMMM yyyy').parse(inputDate);
        return parsedDate;
      } catch (e) {
        return DateTime.now();
      }
    }
  }

  static isDeveloperOptionEnabled(BuildContext context) async {
    if (!Platform.isAndroid) {
      return false;
    }
    bool isDeveloperOptionEnabled = await Fun.isDeveloperOptionsEnabled();
    if (isDeveloperOptionEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    color: SColors.rozgarRed,
                    size: 50.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Warning',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    Constants.developerWarning,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: SColors.rozgarRed,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return isDeveloperOptionEnabled;
  }

  static retryDialog(context, final Function() exit, final Function() retry) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Network Problem'),
          content: Text('There was a problem with the network.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                retry();
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                exit();
              },
              child: Text('Close App'),
            ),
          ],
        );
      },
    );
  }

  static getImageFromCamera() async {
    try {
      File? galleryFile;
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      XFile? xfilePick = pickedFile;
      if (xfilePick != null) {
        galleryFile = File(pickedFile!.path);
        return galleryFile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static saveFileToTemporary() async {
    final folder = await getTemporaryDirectory();
    final filePath = '${folder.path}/SalarySlip.pdf';
    final file = File(filePath);
    final raf = await file.open(mode: FileMode.writeOnlyAppend);
    await raf.writeString('string\n');
    await raf.close();
    savePdfToDownload(filePath);
    log('Created temp file: ${file.path}');
  }

  static savePdfToDownload(String filePath) async {
    try {
      final file = await CRFileSaver.saveFile(
        filePath,
        destinationFileName: 'SalarySlip.pdf',
      );
      log('Saved to $file');
    } on PlatformException catch (e) {
      log('file saving error: ${e.code}');
    }
  }

  static List<List<String>> removeDuplicates(List<List<String>> originalList) {
    Set<List<String>> uniqueItems = {};
    List<List<String>> result = [];

    for (var item in originalList) {
      if (uniqueItems.add(item)) {
        result.add(item);
      }
    }

    return result;
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void deleteSharePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static num calculateDaysDifference(DateTime startDate, DateTime endDate) {
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    Duration difference = end.add(Duration(days: 1)).difference(start);
    if (difference == 0) {
      return 0.5;
    } else {
      return difference.inDays;
    }
  }

  static String padNumberWithZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  static getPermissionList() async {
    String jsonString =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> data = json.decode(jsonString);
    List<int> permissions = List<int>.from(data['result']['permission']);
    return permissions;
  }

  static void showDefaultDialog(String sTitle, String sMessage) {
    Get.defaultDialog(
      // title: sTitle,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(sMessage)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Container(
                  margin: EdgeInsets.only(top: 20), child: Text('Okay')),
            ),
          ),
        ],
      ),
      confirmTextColor: Colors.white,
    );
  }

  static String convertDistanceToKilometers(double distanceInMeters) {
    if (distanceInMeters >= 1000) {
      double distanceInKilometers = distanceInMeters / 1000;
      return '${distanceInKilometers.toStringAsFixed(2)} km';
    } else {
      return '${distanceInMeters.toStringAsFixed(2)} m';
    }
  }

  // static void logOut(BuildContext context) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => loginScreen()));
  // }

  static logOut(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            title: Text('Log Out'),
            content: Text('Are you sure you want to Log out?'),
            actions: [
              TextButton(
                onPressed: () async {
                  WidgetsFlutterBinding.ensureInitialized();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.of(context).pop();
                  Get.offNamed(AppRoute.loginView);
                },
                child: Text('Log Out',
                    style: GoogleFonts.roboto(color: SColors.rozgarRed)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',
                    style: GoogleFonts.roboto(color: SColors.rozgarRed)),
              ),
            ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: SColors.rozgarRed,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<bool> checkInterNet() async {
    bool isConnection = false;
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      print("Internet connection is from Mobile data");
      isConnection = true;
    } else if (result == ConnectivityResult.wifi) {
      print("internet connection is from wifi");
      isConnection = true;
    } else if (result == ConnectivityResult.ethernet) {
      print("internet connection is from wired cable");
      isConnection = true;
    } else if (result == ConnectivityResult.bluetooth) {
      print("internet connection is from bluethooth threatening");
      isConnection = true;
    } else if (result == ConnectivityResult.none) {
      print("No internet connection");
      isConnection = false;
    }
    print(isConnection);
    return isConnection;
  }

  static Future<double> getDistance(
      double lat1, double lan1, double lat2, double lan2) async {
    double distance = await Geolocator.distanceBetween(
      lat1,
      lan1,
      lat2,
      lan2,
    );
    print('Distance between two points: $distance meters.');
    return distance;
  }

  // static ProgressDialog showProgressDialog(BuildContext context) {
  //   ProgressDialog pr;
  //   pr = ProgressDialog(context, type: ProgressDialogType.Normal);
  //   pr.style(
  //     message: 'Please wait...',
  //     borderRadius: 10.0,
  //     backgroundColor: Colors.white,
  //     progressWidget: CircularProgressIndicator(),
  //     elevation: 5.0,
  //     insetAnimCurve: Curves.easeInOut,
  //     progress: 0.0,
  //     maxProgress: 100.0,
  //     progressTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  //     messageTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  //   );
  //   return pr;
  // }

  static getCurrentPosition(
      {LocationAccuracy accuracy = LocationAccuracy.high}) async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy, timeLimit: const Duration(seconds: 5));
    return position;
  }

  static void locationErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Unavailable",
              style: GoogleFonts.roboto(
                  color: SColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16)),
          content: Text("Unable to retrieve location. Please try again",
              style: GoogleFonts.roboto(color: SColors.black, fontSize: 14)),
          actions: [
            // TextButton(
            //   onPressed: () async{
            //     final hasPermission = await PermissionUtil.handleLocationPermission(context);
            //     if (hasPermission) {
            //       Get.toNamed(AppRoute.myLocationScreen);
            //     }else{
            //       Fun.showToast("Kindly enable location access or turn on your location.");
            //     }
            //   },
            //   child: const Text("Live Location"),
            // ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("OK"),
          )
          ],
        );
      },
    );
  }

  static Future<String> getAddressFromLatLng(Position position) async {
    String currentAddress = "null";
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
    return currentAddress;
  }

  static void openGoogleMaps(double latitude, double longitude) {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

  static Future<String?> getLocationName(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placemark = placemarks[0];
    String? locationName =
        placemark.name ?? placemark.locality ?? placemark.administrativeArea;
    print(locationName);
    return locationName;
  }

  static List<Result> showList(int month, int year, List<Result> fsList) {
    var monthGv;
    if (month < 10) {
      monthGv = "0$month";
    } else {
      monthGv = month.toString();
    }
    String defaultTime = "$year-$monthGv-05 18:58:29.250759";
    final now = DateTime.parse(defaultTime);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final datesInMonth = <String>[];
    for (var i = 0; i < daysInMonth; i++) {
      final date = firstDayOfMonth.add(Duration(days: i));
      datesInMonth.add(formatter.format(date));
    }
    var attendanceList = <Result>[];
    for (int i = 1; i <= datesInMonth.length; i++) {
      attendanceList.add(Result(
          id: null,
          source: null,
          ip: null,
          lat: null,
          lng: null,
          remark: null,
          userId: null,
          deviceId: null,
          attendanceTypeId: null,
          inTime: datesInMonth[i - 1],
          outTime: null,
          arDetailId: null,
          available: null,
          shiftId: null,
          otDetailId: null,
          uid: null,
          otHours: null,
          attendanceStatusId: null,
          sourceOutTime: null,
          ipOutTime: null,
          latOutTime: null,
          lngOutTime: null,
          deviceIdOutTime: null,
          attendanceTypeName: null,
          inTimeDay: i,
          inTimeUnix: null,
          outTimeUnix: null));
    }

    return mergedList(fsList, attendanceList);
  }

  static List<Result> mergedList(List<Result> fsList, List<Result> snList) {
    for (var i = 0; i < snList.length; i++) {
      var matchingItems = fsList
          .where((element) => element.inTimeDay == snList[i].inTimeDay)
          .toList();
      if (matchingItems.isNotEmpty) {
        snList[i] = matchingItems[0];
      }
    }

    for (var j = 0; j < fsList.length; j++) {
      var matchingItems = snList
          .where((element) => element.inTimeDay == fsList[j].inTimeDay)
          .toList();
      if (matchingItems.isEmpty) {
        snList.add(fsList[j]);
      }
    }
    return snList;
  }

  static getProgDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  static int getWeekendCount(DateTime month) {
    int weekendCount = 0;
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(month.year, month.month, i);

      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        weekendCount++;
      }
    }
    return weekendCount;
  }

  static bool toggleValue(bool value) {
    return !value;
  }

  static Future<void> updateApp() async {
    if (Platform.isIOS) {
      final Uri iosUrl = Uri.parse(
          'https://apps.apple.com/in/app/hr-management-rozgar/id6449593738');
      if (!await launchUrl(iosUrl)) {
        throw Exception('Could not launch $iosUrl');
      }
    } else {
      final String appPackageName = 'com.rozgar.hrms';
      final String androidUrl = 'market://details?id=$appPackageName';
      if (await canLaunch(androidUrl)) {
        await launch(androidUrl);
      } else {
        throw 'Could not launch Play Store';
      }
    }
  }

  static String getAbsentCount(value) {
    if (value < 0) {
      return '0';
    } else {
      return value.toString();
    }
  }

  static showExitConfirmationDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            title: Text('Close App'),
            content: Text('Are you sure you want to close the app?'),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(color: SColors.rozgarRed),
                ),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: SColors.rozgarRed),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  exit(0);
                },
                child: Text(
                  'yes',
                  style: GoogleFonts.roboto(color: SColors.rozgarRed),
                ),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: SColors.rozgarRed),
                ),
              ),
            ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static String getFlag(String countryCode) {
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  static List<String> getBulletPoints(String text) {
    return text.split('\n').map((line) {
      if (line.isNotEmpty && line[0] != '\t') {
        return '• $line';
      }
      return line;
    }).toList();
  }

  static String formatDate(String dateString) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final outputFormat = DateFormat("dd MMMM yyyy");
    final dateTime = inputFormat.parse(dateString);
    final formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  static String getFormattedDate(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static int getCurrentDate() {
    DateTime now = DateTime.now();
    int formattedDate = now.day;
    return formattedDate;
  }

  static bool isDateBetween(DateTime startDate) {
    DateTime date = DateTime.now();
    return date.isAfter(startDate) && date.isBefore(date);
  }

  static double calculateHoursDifference(
      DateTime startDateStr, DateTime endDateStr) {
    Duration duration = endDateStr.difference(startDateStr);
    double hoursDifference = duration.inSeconds / 3600;
    return hoursDifference;
  }

  static String formatDateAndTime(
      BuildContext context, DateTime date, TimeOfDay time) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String formattedTime = time.format(context);
    return '$formattedDate $formattedTime';
  }

  double calculateTimeOfDayHoursDifference(
      TimeOfDay startTime, TimeOfDay endTime) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    int minutesDifference = endMinutes - startMinutes;
    double hoursDifference = minutesDifference / 60.0;
    return hoursDifference;
  }

  static List<String> printAllDaysBetweenDates(
      String startDateStr, String endDateStr) {
    DateTime startDate = DateTime.parse(startDateStr);
    DateTime endDate = DateTime.parse(endDateStr);
    endDate = endDate.add(Duration(days: 1));
    List<String> allDates = [];
    while (startDate.isBefore(endDate)) {
      allDates.add(DateFormat('yyyy-MM-dd').format(startDate.toLocal()));
      startDate = startDate.add(Duration(days: 1));
    }
    return allDates;
  }

  static bool checkSelectedStatus(int isEmergency) {
    if (isEmergency == 0) {
      return false;
    } else if (isEmergency == 1) {
      return true;
    } else {
      throw ArgumentError(
          "Invalid value for isEmergency. Only 0 or 1 are allowed.");
    }
  }

  static Future<String> selectFileOther() async {
    String resultPath = 'No file selected';
    bool isStoragePermission = true;
    bool isVideosPermission = true;
    bool isPhotosPermission = true;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      if (androidInfo.version.sdkInt >= 33) {
        isVideosPermission = await Permission.videos.status.isGranted;
        isPhotosPermission = await Permission.photos.status.isGranted;
      } else {
        isStoragePermission = await Permission.storage.status.isGranted;
      }

      if (isStoragePermission && isVideosPermission && isPhotosPermission) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        );
        if (result != null) {
          String filePath = result.files.single.path!;
          print(filePath);
          resultPath = filePath;
          return filePath;
        } else {
          resultPath = 'No file selected';
        }
      } else {
        // write your code here
      }
    } else {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        );
        if (result != null) {
          String filePath = result.files.single.path!;
          print(filePath);
          resultPath = filePath;
        } else {
          resultPath = 'No file selected';
        }
      } else {
        permissionDialog('Permission Required',
            'This permission is required for upload documents');
        return 'Permission not granted';
      }
    }
    return resultPath;
  }

  static customLogEvent(String sScreenName) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: sScreenName,
        // parameters: {"key": "value"},
      );
    } catch (e) {
      print("Error: Unable to send custom log event");
    }
  }
  static Future<String> selectImage() async {
    String resultPath = "null";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      File file = File(filePath);
      int fileSize = await file.length();
      if (fileSize <= 2000 * 1024) {
        print('File size is valid: $fileSize bytes');
        resultPath = filePath;
      } else {
        print('File size exceeds 2 MB: $fileSize bytes');
        resultPath = 'exceeds';
      }
    } else {
      resultPath = 'null';
    }
    return resultPath;
  }

  static Future<String> selectFile() async {
    String resultPath = 'No file selected';
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      String filePath = result.files.single.path!;
      print(filePath);
      resultPath = filePath;
    } else {
      resultPath = 'No file selected';
    }
    return resultPath;
  }

  static String truncateAndAddEllipsis(String input) {
    if (input.length <= 3) {
      return input; // Return the input as is if it's 3 characters or less
    } else {
      return input.substring(0, 10) + "..."; // Truncate and add "..."
    }
  }

  static void permissionDialog(String sTitle, String sMessage) {
    Get.defaultDialog(
      // title: sTitle,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(sMessage)),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(
                        result: false); // Close the dialog and return "false"
                  },
                  child: Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(
                        result: true); // Close the dialog and return "true"
                    openAppSettings();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          )
        ],
      ),
      confirmTextColor: Colors.white,
    );
  }

  static String getWeekDayAbbreviation(int weekday) {
    final Map<int, String> dayAbbreviations = {
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun',
    };

    return dayAbbreviations[weekday] ??
        'Invalid'; // Handles invalid weekday values
  }

  static int calculateTotalSeconds(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length != 3) {
      throw ArgumentError('Invalid time format. Expected format HH:MM:SS.');
    }
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    int totalSeconds = (hours * 3600) + (minutes * 60) + seconds;
    return totalSeconds;
  }


  static String calculateTotalHours(int day, List<Result> fsList) {
    var time = "00:00:00";
    if (fsList != null) {
      fsList.forEach((element) {
        if (element.inTimeDay == day) {
          if (element.inTime != null && element.outTime != null) {
            time = TimeHandler.addTimes(TimeHandler.calculateTotalTime(element.inTime!, element.outTime!), time);
          } else {
            time == "00";
          }
        }
      });
    }
    print("Today:$day Total Time is:$time");
    if (time == "00:00:00") {
      return "00";
    } else if (time == "0:00") {
      return "00";
    } else {
      return time;
    }
  }

  static String formatDateTimeString(String dateTimeString) {
    DateTime indianDateTime = DateTime.parse(dateTimeString);
    DateTime parsedDateTime =
        indianDateTime.add(Duration(hours: 5, minutes: 30));
    return "${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')} ${parsedDateTime.hour.toString().padLeft(2, '0')}:${parsedDateTime.minute.toString().padLeft(2, '0')}:${parsedDateTime.second.toString().padLeft(2, '0')}";
  }

  static getIndianTime(sTime) {
    if (sTime != null) {
      DateTime dateTime = DateTime.parse(sTime);
      dateTime = dateTime.add(Duration(hours: 5, minutes: 30));
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return "--";
    }
  }

  static getLoadingUICircular(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        color: SColors.white.withOpacity(0.4),
        width: width,
        height: height,
        child: const Center(
            heightFactor: 5.0,
            widthFactor: 5.0,
            child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: SColors.smashedPumpkin,
                    valueColor:
                        AlwaysStoppedAnimation(SColors.smashedPumpkin)))));
  }
  static getLoader(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        color: SColors.white,
        width: width,
        height: height,
        child: const Center(
            heightFactor: 5.0,
            widthFactor: 5.0,
            child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: SColors.smashedPumpkin,
                    valueColor:
                    AlwaysStoppedAnimation(SColors.smashedPumpkin)))));
  }


  static downloadDocuments(fileName) async {
    String sUser;
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    sUser = jsonMap['result']['id'].toString();
    String documentUrl =
        "${await AppUrl.url.getBaseUrl() + AppUrl.sDownloadDoc}/$sUser/$fileName";
    print(documentUrl);
    launch(documentUrl);
  }

//----------------------------get Image form camera ------------------------
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// File? galleryFile;
// final picker = ImagePicker();
//
// Future getImage(ImageSource img) async {
//   final pickedFile = await picker.pickImage(source: img);
//   XFile? xfilePick = pickedFile;
//   setState(
//         () {
//       if (xfilePick != null) {
//         galleryFile = File(pickedFile!.path);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
//             const SnackBar(content: Text('Nothing is selected')));
//       }
//     },
//   );
// }
// getImage(ImageSource.camera);
}

class AppSettings {}

class Pdf {
  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> downloadPdf(
      sEmployeeName,
      sEmployeeId,
      sDateOfJoining,
      sMonth,
      sTotalPaidDays,
      sDesignation,
      sGrossEarningPotential,
      sNetTakeHome,
      sOrgName,
      sAddress,
      earning,
      deduction) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Stack(
                      children: [
                        pw.Container(
                          padding: pw.EdgeInsets.all(1.0),
                          color: PdfColors.black,
                          // Set the background color to black
                          child: pw.Row(
                            mainAxisSize: pw.MainAxisSize.min,
                            children: [
                              pw.Container(
                                padding: pw.EdgeInsets.all(0.5),
                                color: PdfColors.red,
                                child: pw.Text(
                                  'Value',
                                  style: pw.TextStyle(
                                      color: PdfColors.white, fontSize: 5.0),
                                ),
                              ),
                              pw.Text(
                                'Innovation',
                                style: pw.TextStyle(
                                    color: PdfColors.white, fontSize: 5.0),
                              ),
                              pw.Container(
                                margin: pw.EdgeInsets.only(bottom: 4),
                                child: pw.Text(
                                  'Labs',
                                  style: pw.TextStyle(
                                      color: PdfColors.white, fontSize: 3.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 200),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          sOrgName,
                          style: pw.TextStyle(fontSize: 5),
                        ),
                        pw.SizedBox(height: 15),
                        pw.Text(sAddress, style: pw.TextStyle(fontSize: 5))
                      ],
                    )
                  ],
                ),
                pw.Divider(
                  color: PdfColors.black, // Change the color if needed
                  thickness: 1, // Change the thickness of the line
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Employee ID",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                            pw.Text(
                              "Employee Name",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                            pw.Text(
                              "Date Of Joining",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                          ],
                        ),
                        pw.SizedBox(width: 50),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(sEmployeeId,
                                style: pw.TextStyle(fontSize: 5)),
                            pw.Text(sEmployeeName,
                                style: pw.TextStyle(fontSize: 5)),
                            pw.Text(sDateOfJoining,
                                style: pw.TextStyle(fontSize: 5)),
                          ],
                        ),
                      ],
                    ),
                    // pw.SizedBox(width: 60),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Month",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                            pw.Text(
                              "Total Paid Day's",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                            pw.Text(
                              "Designation",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                          ],
                        ),
                        pw.SizedBox(width: 30),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(sMonth, style: pw.TextStyle(fontSize: 5)),
                            pw.Text(sTotalPaidDays,
                                style: pw.TextStyle(fontSize: 5)),
                            pw.Text(sDesignation,
                                style: pw.TextStyle(fontSize: 5)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Table(
                        border: pw.TableBorder.all(),
                        children: List.generate(
                          earning.length,
                          (index) {
                            return pw.TableRow(
                              decoration: pw.BoxDecoration(
                                color: index == 0
                                    ? PdfColors.black
                                    : null, // Set black background for the first row
                              ),
                              children: List.generate(
                                earning[index].length,
                                (index2) {
                                  return pw.Container(
                                    padding: pw.EdgeInsets.all(8.0),
                                    child: pw.Center(
                                      child: pw.Text(
                                        earning[index][index2],
                                        style: pw.TextStyle(
                                          fontSize: 5.0,
                                          color: index == 0
                                              ? PdfColors.white
                                              : PdfColors.black,
                                          // Set white text for the first row
                                          fontWeight: index == 0
                                              ? pw.FontWeight.bold
                                              : pw.FontWeight
                                                  .normal, // Make text bold for the first row
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // pw.SizedBox(width: 60),
                    pw.Expanded(
                      child: pw.Container(
                          margin: pw.EdgeInsets.only(left: 30),
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            children: List.generate(
                              deduction.length,
                              (index) {
                                return pw.TableRow(
                                  decoration: pw.BoxDecoration(
                                    color: index == 0
                                        ? PdfColors.black
                                        : null, // Set black background for the first row
                                  ),
                                  children: List.generate(
                                    deduction[index].length,
                                    (index2) {
                                      return pw.Container(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Center(
                                          child: pw.Text(
                                            deduction[index][index2],
                                            style: pw.TextStyle(
                                              fontSize: 5.0,
                                              color: index == 0
                                                  ? PdfColors.white
                                                  : PdfColors.black,
                                              // Set white text for the first row
                                              fontWeight: index == 0
                                                  ? pw.FontWeight.bold
                                                  : pw.FontWeight
                                                      .normal, // Make text bold for the first row
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Divider(
                  color: PdfColors.black, // Change the color if needed
                  thickness: 1, // Change the thickness of the line
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(width: 200),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Gross Earning Potential",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              "Net Take Home",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 5),
                            ),
                          ],
                        ),
                        pw.SizedBox(width: 50),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(sGrossEarningPotential,
                                style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 5),
                            pw.Text(sNetTakeHome,
                                style: pw.TextStyle(fontSize: 5)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
      );
      final folder = await getTemporaryDirectory();
      final filePath = '${folder.path}/SalarySlip.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      Fun.savePdfToDownload(filePath);
      Fun.showToast("Salary Slip Downloaded Successfully");

      return true;
    } catch (e) {
      print(e);
      Fun.showToast("Failed to Download Salary Slip");
      return false;
    }
  }
}
