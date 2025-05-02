import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../api/api_handler.dart';
import '../../../../model/AttendanceType.dart';
import '../../../../model/attendance_drop_down.dart';
import '../../../../model/check_in_status.dart';
import '../../../../utils/fun.dart';
import '../../../../utils/permission_util.dart';
import '../../../../utils/prefsKeys.dart';
import '../../../../utils/shared_preferences.dart';
import '../../../../utils/time_handler.dart';

class MyLocationController extends GetxController {
  var currentPosition = Rxn<LatLng>();
  final centerIndia = Rxn<LatLng>(LatLng(20.5937, 78.9629));
  var distanceToTarget = 0.0.obs;
  RxDouble iRadius = 100.0.obs;
  var isInRange = false.obs;
  late GoogleMapController mapController;
  RxString sDeviceId = "Na".obs;
  RxString sSource = "Na".obs;
  StreamSubscription<Position>? positionStream;
  RxString sTargetLat = "0.0".obs;
  RxString sTargetLng = "0.0".obs;
  RxBool isGeofenced = true.obs;
  RxString sStaticDownValue = "Default".obs;
  RxInt iAttendanceId = 1.obs;
  RxList<AttendanceDropDown> lsAttendanceType = <AttendanceDropDown>[].obs;
  RxInt iDropDownMenuIndexNumber = 0.obs;
  RxBool isDropDownMenuIndexNumber = false.obs;
  RxBool isAttendanceListLoaded = false.obs;
  final context = Get.context;
  RxBool loading = false.obs;
  RxBool isConnect = false.obs;
  RxBool isCheckInVisible = false.obs;
  RxBool isCheckOutVisible = false.obs;
  RxBool isStaticDownMenu = false.obs;
  RxList<dynamic> permissions = <dynamic>[].obs;
  File? cameraImage;

  @override
  void onInit() {
    super.onInit();
    updateWidgets();
    _getCurrentLocation();
    _startListeningToLocationChanges();
  }

  updateDeviceDetails()async{
    try {
      Map<String, String> deviceDetails = await Fun().getDeviceDetails();
      sDeviceId.value = deviceDetails['deviceId']!;
      sSource.value = deviceDetails['deviceName']!;
    }catch (e){
      print("Update Device Details: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }
  Future<AttendanceType> getAttendanceTypes(bool isCheckIn, attendanceId) async {
    AttendanceType response = await ApiHandler().getAttendanceType();
    if (response.result != null) {
      lsAttendanceType.clear();
      for (var element in response.result!) {
        lsAttendanceType.add(AttendanceDropDown(
            id: element.id,
            name: element.name,
            modifiedBy: element.modifiedBy,
            modifiedAt: element.modifiedAt,
            modifiedOn: element.modifiedOn,
            description: element.description,
            isGeofenced: element.isGeofenced,
            geofenceGroupId: element.geofenceGroupId,
            available: element.available,
            lat: element.lat,
            lng: element.lng,
            radius: element.radius,
            orgId: element.orgId));
      }
    }
    try {
      if (isCheckIn) {
        for (var element in response.result!) {
          if (element.id == attendanceId) {
            bool? isGeofence = element.isGeofenced;
            if (isGeofence != null && isGeofence) {
              isGeofenced.value = true;
              sTargetLat.value = element.lat!;
              sTargetLng.value = element.lng!;
              iRadius.value = double.parse(element.radius!);
              iAttendanceId.value = element.id!;
              sStaticDownValue.value = element.name!;
            } else {
              isGeofenced.value = false;
              iAttendanceId.value = element.id!;
              sStaticDownValue.value = element.name!;
              sTargetLat.value = currentPosition.value!.latitude.toString();
              sTargetLng.value = currentPosition.value!.longitude.toString();
            }
          }
        }
      } else {
        bool? isGeofence = response.result![0].isGeofenced;
        iDropDownMenuIndexNumber.value = 0;
        if (isGeofence != null && isGeofence) {
          isGeofenced.value = true;
          sTargetLat.value = response.result![0].lat!;
          sTargetLng.value = response.result![0].lng!;
          iRadius.value = double.parse(response.result![0].radius!);
          iAttendanceId.value = response.result![0].id!;
          sStaticDownValue.value = response.result![0].name!;
        } else {
          isGeofenced.value = false;
          iAttendanceId.value = response.result![0].id!;
          sStaticDownValue.value = response.result![0].name!;
          sTargetLat.value = currentPosition.value!.latitude.toString();
          sTargetLng.value = currentPosition.value!.longitude.toString();
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    return response;
  }
  Future<bool> checkLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }
  Future<void> _getCurrentLocation() async {
    loading.value = true;
    try{
      if (await checkLocationPermission()) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        currentPosition.value = LatLng(position.latitude, position.longitude);
        _updateDistance();
      } else {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required to continue.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }catch (e){
      loading.value = false;
    }
    loading.value = false;
  }
  void recenterToTargetLocation() {
    try{
      if (mapController != null && sTargetLat.value != "0.0" && sTargetLng.value != "0.0") {
        final targetLatLng = LatLng(
          double.tryParse(sTargetLat.value) ?? 0.0,
          double.tryParse(sTargetLng.value) ?? 0.0,
        );

        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(targetLatLng, 15.0), // Adjust zoom level as needed
        );
      } else {
        Get.snackbar(
          "Error",
          "Target location not available.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }catch (e){
      // Get.snackbar(
      //   "Error",
      //   "Target location not available.",
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }

  }
  void _startListeningToLocationChanges() async {
    if (await checkLocationPermission()) {
      positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1, // Trigger updates every 1 meter
        ),
      ).listen((Position position) {
        currentPosition.value = LatLng(position.latitude, position.longitude);
        _updateDistance();
      });
    }
  }
  void _updateDistance() {
     if(isGeofenced.value){
       if (currentPosition.value != null) {
         final distance = Geolocator.distanceBetween(
           currentPosition.value!.latitude,
           currentPosition.value!.longitude,
           double.tryParse(sTargetLat.value) ?? 0.0,
           double.tryParse(sTargetLng.value) ?? 0.0,
         );
         distanceToTarget.value = distance;
         isInRange.value = distance <= iRadius.value;
       }
     }else{
       isInRange.value = true;
       distanceToTarget.value = 0.0;
       iRadius.value = 0.0;
     }
  }
  markAttendance(BuildContext context, bool isCheckIn) async {
    final hasPermission = await PermissionUtil.handleLocationPermission(context);
    // if (Platform.isAndroid) {
    //   bool isDeveloper = await Fun.isDeveloperOptionEnabled(context);
    //   if (isDeveloper) return;
    // }
    if (hasPermission) {
      isConnect.value = await Fun.checkInterNet();
      if (!isConnect.value) {
        Fun.showToast("No internet connection...");
      } else {
        loading.value = true;
        try {

          double iDistance = 0.0;
          if (isGeofenced.value) {
            iDistance = await Fun.getDistance(
                currentPosition.value!.latitude,
                currentPosition.value!.longitude,
                double.parse(sTargetLat.value),
                double.parse(sTargetLng.value));
          } else {
            iDistance = await Fun.getDistance(currentPosition.value!.latitude,
                currentPosition.value!.longitude, currentPosition.value!.latitude,
              currentPosition.value!.longitude,);
          }
          if ((iDistance < iRadius.value + 50 || (!isCheckIn && (sTargetLat.value == "0.0" || sTargetLng.value == "0.0")))) {
            if (isCheckIn) {
              checkInAttendance(currentPosition.value!.latitude,
                currentPosition.value!.longitude,);
            } else {
              checkOutAttendance(currentPosition.value!.latitude,
                currentPosition.value!.longitude,);
            }
          } else {
            loading.value = false;
            Fun.showDefaultDialog("Distance",
                "${Fun.convertDistanceToKilometers(iDistance)} away from destination");
          }
        } catch (e) {
          loading.value = false;
          print('An error occurred: $e');
        }
      }
    }
  }
  checkInAttendance(double lat, double lng) async {
    bool isCameraCheckIn = false;
    try{
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      isCameraCheckIn = jsonMap['result']['conf']['selfie_at_checkin'];
    }catch (e){
      isCameraCheckIn = false;
    }

    cameraImage = null;
    if(isCameraCheckIn){
      cameraImage  = await Fun.getImageFromCamera();
    }
    if(isCameraCheckIn == true && cameraImage == null){
      loading.value = false;
      Fun.showToast("Please Select an image");
      return;
    }else{
      bool isStatus = await ApiHandler().checkIn(sDeviceId.value, sSource.value,iAttendanceId.value, lat, lng,cameraImage);
      if (isStatus == true) {
        var currentTime = TimeHandler.getCurrentTime();
        AppPreferences.shared.saveSharedPreferences(PrefsKeys.sUserLastLoginTime, currentTime);
        AppPreferences.shared.saveBoolSharedPreferences(PrefsKeys.isMbCheckInStatus, true);
        isCheckOutVisible.value = true;
        isCheckInVisible.value = false;
        isDropDownMenuIndexNumber.value = true;
        isStaticDownMenu.value = true;
        isAttendanceListLoaded.value = false;
        loading.value = false;
        Fun.showToast("Successful Check In");
        Get.back(result: 'success');
      } else {
        loading.value = false;
        return;
      }
    }
  }
  checkOutAttendance(double lat, double lng) async {
    bool isCameraCheckIn = false;
    try{
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      isCameraCheckIn = jsonMap['result']['conf']['selfie_at_checkin'];
    }catch (e){
      isCameraCheckIn = false;
    }
    cameraImage = null;
    if(isCameraCheckIn){
      cameraImage  = await Fun.getImageFromCamera();
    }
    if(isCameraCheckIn == true && cameraImage == null){
      loading.value = false;
      Fun.showToast("Please Select an image");
      return;
    }else{
      bool isStatus = await ApiHandler().checkOut(sDeviceId.value, sSource.value, iAttendanceId.value, lat, lng,cameraImage);
      if (isStatus == true) {
        AppPreferences.shared.saveBoolSharedPreferences(PrefsKeys.isMbCheckInStatus, false);
        isCheckOutVisible.value = false;
        isCheckInVisible.value = true;
        isStaticDownMenu.value = false;
        isAttendanceListLoaded.value = true;
        int index = 0;
        lsAttendanceType.forEach((element) {
          if (element.name == sStaticDownValue.value) {
            iDropDownMenuIndexNumber.value = index;
          }
          index++;
        });
        loading.value = false;
        Fun.showToast("Successful Check Out");
        Get.back(result: 'success');
      } else {
        loading.value = false;
        return;
      }
    }
  }
  setAttendanceTypeValue(AttendanceDropDown data) {
    if (data.isGeofenced!) {
      isGeofenced.value = data.isGeofenced!;
      sTargetLat.value = data.lat!;
      sTargetLng.value = data.lng!;
      iRadius.value = double.parse(data.radius!);
      iAttendanceId.value = data.id!;
      sStaticDownValue.value = data.name!;
    } else {
      isGeofenced.value = data.isGeofenced!;
      iAttendanceId.value = data.id!;
      sStaticDownValue.value = data.name!;
      sTargetLat.value = currentPosition.value!.latitude.toString();
      sTargetLng.value = currentPosition.value!.longitude.toString();
    }
    _updateDistance();
  }
  updateWidgets() async {
    updateDeviceDetails();
    try {
      if (await Fun.checkInterNet()) {
        loading.value == true;
        CheckInStatus responseDate = await ApiHandler().getCheckInStatus(context!);
        if (responseDate.status) {
          await getAttendanceTypes(true, responseDate.result!.attendanceTypeId);
          isCheckOutVisible.value = true;
          isCheckInVisible.value = false;
          isStaticDownMenu.value = true;
          isAttendanceListLoaded.value = false;
          iAttendanceId.value = responseDate.result!.attendanceTypeId;
          sStaticDownValue.value = responseDate.result!.attendanceTypeName;
        } else {
          await getAttendanceTypes(false, 0);
          isCheckOutVisible.value = false;
          isCheckInVisible.value = true;
          isStaticDownMenu.value = false;
          isAttendanceListLoaded.value = true;
        }
        recenterToTargetLocation();
        _updateDistance();
        loading.value = false;
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      Fun.retryDialog(context, () => {exit(0)}, () => {loading.value = true, updateWidgets()});
    }
  }
}
