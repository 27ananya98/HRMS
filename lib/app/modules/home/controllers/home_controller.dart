import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrms/model/AttendanceType.dart';
import 'package:hrms/model/attendance_drop_down.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/permission_util.dart';
import 'package:hrms/utils/prefsKeys.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../api/api_handler.dart';
import '../../../../model/announcement.dart';
import '../../../../model/check_in_status.dart';
import '../../../../model/update_app.dart';
import '../../../../routes/get_routes.dart';
import '../../../../utils/shared_preferences.dart';

class HomeController extends GetxController {
  final BuildContext? context = Get.context;
  Timer? _timer;
  final RxInt remainingSeconds = 0.obs;
  final RxString timeToDisplay = "00.00.00".obs;
  final RxBool loading = false.obs;
  final RxBool isConnect = false.obs;
  final RxBool isCheckInternet = false.obs;
  final RxInt iAttendanceId = 1.obs;
  final RxBool isCheckInVisible = false.obs;
  final RxBool isCheckOutVisible = false.obs;
  final RxBool isAttendanceListLoaded = false.obs;
  final RxString sAnnouncement = "Please Wait...".obs;
  final RxString sUserName = "Please Wait...".obs;
  final RxString sMobile = "Please Wait...".obs;
  final RxInt iDropDownMenuIndexNumber = 0.obs;
  final RxBool isDropDownMenuIndexNumber = false.obs;
  final RxBool isUpdateWidget = false.obs;
  final RxBool isDataLoading = true.obs;
  final RxBool isStaticDownMenu = false.obs;
  final RxString sStaticDownValue = "Default".obs;
  final RxInt iCheckOutAttendanceId = 1.obs;
  final RxString sLat = "0.0".obs;
  final RxString sLng = "0.0".obs;
  final RxBool isGeofenced = true.obs;
  final RxDouble iRadius = 100.0.obs;
  final RxList<AttendanceDropDown> lsAttendanceType =
      <AttendanceDropDown>[].obs;
  final RxList<dynamic> permissions = <dynamic>[].obs;
  File? cameraImage;
  Position? currentPos;
  Timer? timer;
  final RxString sDeviceId = "Na".obs;
  final RxString sSource = "Na".obs;

  @override
  void onInit() {
    super.onInit();

    updateWidgets();
  }

  Future<void> moveToGoogleMap(BuildContext context) async {
    final hasPermission =
        await PermissionUtil.handleLocationPermission(context);
    if (hasPermission) {
      final result = await Get.toNamed(AppRoute.myLocationScreen);
      if (result == 'success') {
        updateWidgets();
      }
    } else {
      Fun.showToast("Kindly enable location access or turn on your location.");
    }
  }

  Future<void> updateDeviceDetails() async {
    try {
      final deviceDetails = await Fun().getDeviceDetails();
      sDeviceId.value = deviceDetails['deviceId']!;
      sSource.value = deviceDetails['deviceName']!;
    } catch (e) {
      print("Update Device Details: ${e.toString()}");
    }
  }

  Future<void> updateLocation() async {
    currentPos = await Fun.getCurrentPosition();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer(const Duration(minutes: 5), () {
      currentPos = null;
      print("currentPos is set to null after 5 minutes.");
      timer?.cancel();
    });
  }

  void startTimerFrom() {
    getLastTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds.value++;
      timeToDisplay.value = TimeHandler.getTimer(remainingSeconds.value);
      print(timeToDisplay);

    });
  }

  void resetTimer() {
    _timer?.cancel();
    remainingSeconds.value = 0;
    timeToDisplay.value = "00.00.00";
  }

  Future<void> getLastTime() async {
    final sUserLastTime = await AppPreferences.shared
        .getSharedPreferences(PrefsKeys.sUserLastLoginTime);
    remainingSeconds.value =
        TimeHandler.timeStartFrom(int.parse(sUserLastTime));
  }

  Future<void> setUserName() async {
    final value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    final jsonMap = json.decode(value);
    sUserName.value = jsonMap['result']['name'];
    sMobile.value = jsonMap['result']['mobile'];
  }

  Future<bool> updateInternetConnection() async {
    return await Fun.checkInterNet();
  }

  Future<List<dynamic>> getAppUpdateDetails() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final response = await ApiHandler().getUpdateApp();
    return [response, version];
  }

  Future<AnnouncementModal> getAnnouncements(BuildContext context) async {
    return await ApiHandler().getAnnouncements(context);
  }

  Future<AttendanceType> getAttendanceTypes(
      bool isCheckIn, int attendanceId) async {
    final response = await ApiHandler().getAttendanceType();

    if (response.result != null) {
      print(response.result);
      lsAttendanceType.clear();

      if (response.result is List) {
        lsAttendanceType.addAll(
          (response.result as List)
              .map((element) => AttendanceDropDown.fromJson(
              element is Map<String, dynamic> ? element : element.toJson())) // Ensure JSON conversion
              .toList(),
        );
      }

      final element = lsAttendanceType.isNotEmpty
          ? (isCheckIn
          ? lsAttendanceType.firstWhere(
            (element) => element.id == attendanceId,
        orElse: () => lsAttendanceType.first,
      )
          : lsAttendanceType.first)
          : throw Exception("No attendance types available");

      isGeofenced.value = element.isGeofenced ?? false;
      sLat.value = element.lat ?? "0.0";
      sLng.value = element.lng ?? "0.0";
      iRadius.value = double.parse(element.radius ?? "100.0");
      iAttendanceId.value = element.id ?? 1;
      sStaticDownValue.value = element.name ?? "Default";
    }

    return response;
  }


  void setAttendanceTypeValue(AttendanceDropDown data) {
    isGeofenced.value = data.isGeofenced ?? false;
    sLat.value = data.lat ?? "0.0";
    sLng.value = data.lng ?? "0.0";
    iRadius.value = double.parse(data.radius ?? "100.0");
    iAttendanceId.value = data.id ?? 1;
    sStaticDownValue.value = data.name ?? "Default";
  }

  Future<void> markAttendance(BuildContext context, bool isCheckIn) async {
    final hasPermission =
        await PermissionUtil.handleLocationPermission(context);
    if (!hasPermission) return;

    isConnect.value = await Fun.checkInterNet();
    if (!isConnect.value) {
      Fun.showToast("No internet connection...");
      return;
    }

    loading.value = true;
    try {
      final position = currentPos ?? await Fun.getCurrentPosition();
      double iDistance = isGeofenced.value
          ? await Fun.getDistance(position.latitude, position.longitude,
              double.parse(sLat.value), double.parse(sLng.value))
          : 0.0;

      if (iDistance < iRadius.value + 50 ||
          (!isCheckIn && (sLat.value == "0.0" || sLng.value == "0.0"))) {
        isCheckIn
            ? await checkInAttendance(position.latitude, position.longitude)
            : await checkOutAttendance(position.latitude, position.longitude);
      } else {
        loading.value = false;
        currentPos = null;
        Fun.showDefaultDialog("Distance",
            "${Fun.convertDistanceToKilometers(iDistance)} away from destination");
      }
    } catch (e) {
      loading.value = false;
      Fun.locationErrorDialog(context);
      print('An error occurred: $e');
    }
  }

  Future<bool> checkLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<void> checkInAttendance(double lat, double lng) async {
    final isCameraCheckIn = await _getCameraCheckInStatus();
    cameraImage = isCameraCheckIn ? await Fun.getImageFromCamera() : null;

    if (isCameraCheckIn && cameraImage == null) {
      loading.value = false;
      Fun.showToast("Please Select an image");
      return;
    }

    final isStatus = await ApiHandler().checkIn(sDeviceId.value, sSource.value,
        iAttendanceId.value, lat, lng, cameraImage);
    if (isStatus) {
      print("check in");
      await _handleSuccessfulCheckIn();
    } else {
      loading.value = false;
    }
  }

  Future<void> checkOutAttendance(double lat, double lng) async {
    final isCameraCheckIn = await _getCameraCheckInStatus();
    cameraImage = isCameraCheckIn ? await Fun.getImageFromCamera() : null;

    if (isCameraCheckIn && cameraImage == null) {
      loading.value = false;
      Fun.showToast("Please Select an image");
      return;
    }

    final isStatus = await ApiHandler().checkOut(sDeviceId.value, sSource.value,
        iAttendanceId.value, lat, lng, cameraImage);
    if (isStatus) {
      await _handleSuccessfulCheckOut();
    } else {
      loading.value = false;
    }
  }

  Future<void> updateWidgets() async {
    await updateDeviceDetails();
    await getPermissionsList();
    await setUserName();

    try {
      isCheckInternet.value = !(await updateInternetConnection());
      if (!isCheckInternet.value) {
        CheckInStatus responseDate = await ApiHandler().getCheckInStatus(context!);
        print("===0000000${responseDate.status}");

       checkLocationPermission().then((value) {
         if(value==true){
           updateLocation();
         }
       });


        if (responseDate.status) {
          resetTimer();
          startTimerFrom();
          print("0000000000000000000000000000");
          await getAttendanceTypes(true, responseDate.result!.attendanceTypeId);
          isCheckOutVisible.value = true;
          isCheckInVisible.value = false;
          isStaticDownMenu.value = true;
          isAttendanceListLoaded.value = false;
          iAttendanceId.value = responseDate.result!.attendanceTypeId;
          sStaticDownValue.value = responseDate.result!.attendanceTypeName;
        } else {
          resetTimer();
          await getAttendanceTypes(false, 0);
          isCheckOutVisible.value = false;
          isCheckInVisible.value = true;
          isStaticDownMenu.value = false;
          isAttendanceListLoaded.value = true;
        }

        final announcement = await getAnnouncements(context!);
        if(announcement.result?.isNotEmpty??false) {
          sAnnouncement.value = announcement.result![0].detail!;

        }
        isDataLoading.value= false;


        final appUpdateDetails = await getAppUpdateDetails();
        isUpdateWidget.value =
            (appUpdateDetails[0].result.VERSIONCODE).toString() !=
                appUpdateDetails[1].toString();
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }


  Future<void> getPermissionsList() async {
    final value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    final userPermissionJson = jsonDecode(value);
    permissions.value = userPermissionJson['result']['permission'];
  }

  Future<bool> _getCameraCheckInStatus() async {
    try {
      final value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      final jsonMap = json.decode(value);
      return jsonMap['result']['conf']['selfie_at_checkin'] ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _handleSuccessfulCheckIn() async {
    final currentTime = TimeHandler.getCurrentTime();
    await AppPreferences.shared
        .saveSharedPreferences(PrefsKeys.sUserLastLoginTime, currentTime);
    await AppPreferences.shared
        .saveBoolSharedPreferences(PrefsKeys.isMbCheckInStatus, true);
    resetTimer();
    getLastTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds.value++;
      timeToDisplay.value = TimeHandler.getTimer(remainingSeconds.value);
    });
    isCheckOutVisible.value = true;
    isCheckInVisible.value = false;
    isDropDownMenuIndexNumber.value = true;
    isStaticDownMenu.value = true;
    isAttendanceListLoaded.value = false;
    loading.value = false;
    Fun.showToast("Successful Check In");
  }

  Future<void> _handleSuccessfulCheckOut() async {
    await AppPreferences.shared
        .saveBoolSharedPreferences(PrefsKeys.isMbCheckInStatus, false);
    resetTimer();
    isCheckOutVisible.value = false;
    isCheckInVisible.value = true;
    isStaticDownMenu.value = false;
    isAttendanceListLoaded.value = true;
    final index = lsAttendanceType
        .indexWhere((element) => element.name == sStaticDownValue.value);
    if (index != -1) iDropDownMenuIndexNumber.value = index;
    loading.value = false;
    Fun.showToast("Successful Check Out");
  }
}
