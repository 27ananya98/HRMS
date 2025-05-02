import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../model/attendance_drop_down.dart';
import '../../../../utils/s_colors.dart';
import '../controllers/my_location_controller.dart';

class MyLocationView extends GetView<MyLocationController> {
  const MyLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Obx(
           () {
            return Column(
              children: [
            Visibility(
              visible: controller.isAttendanceListLoaded.value,child:Text(
              "Select Attendance Type",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),),
                Visibility(
                  visible: controller.isStaticDownMenu.value,
                  child: Text(controller.sStaticDownValue.value,style: GoogleFonts.roboto(color: SColors.white, fontSize: 14)),
                ),
              ],
            );
          }
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
                  () {
                return Visibility(
                  visible: controller.isAttendanceListLoaded.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButton<AttendanceDropDown>(
                      value: controller.lsAttendanceType.isNotEmpty
                          ? controller.lsAttendanceType[controller.iDropDownMenuIndexNumber.value]
                          : null,
                      items: controller.lsAttendanceType.map((AttendanceDropDown item) {
                        return DropdownMenuItem<AttendanceDropDown>(
                          value: item,
                          child: Text(
                            item.name!,
                            style: GoogleFonts.roboto(
                                color: SColors.black, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                      onChanged: (AttendanceDropDown? selectedValue) {
                        if (selectedValue != null) {
                          controller.iDropDownMenuIndexNumber.value =
                              controller.lsAttendanceType.indexOf(selectedValue);
                          controller.setAttendanceTypeValue(selectedValue);
                        }
                      },
                      hint: const Text(
                        'Select a value',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      underline: Container(), // Removing the underline for cleaner look
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.currentPosition.value ??  controller.centerIndia.value!, // Fallback to (0.0, 0.0) if null
                zoom: 15.0,
              ),
              markers: {
                if (controller.currentPosition.value != null)
                  Marker(
                    markerId: const MarkerId('current_position'),
                    position: controller.currentPosition.value!,
                    infoWindow: const InfoWindow(title: 'Your Current Location'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                  ),
                if (controller.sTargetLat.value !=  "0.0" && controller.sTargetLng.value !=  "0.0")
                  Marker(
                    markerId: const MarkerId('target_location'),
                    position: LatLng(
                      double.tryParse(controller.sTargetLat.value) ?? 0.0,
                      double.tryParse(controller.sTargetLng.value) ?? 0.0,
                    ),
                    infoWindow: const InfoWindow(title: 'Target Location'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  ),

              },
              circles: {
                if (controller.sTargetLat.value !=  "0.0" && controller.sTargetLng.value !=  "0.0")
                  Circle(
                    circleId: const CircleId('target_circle'),
                    center: LatLng(
                      double.tryParse(controller.sTargetLat.value) ?? 0.0, // Default to 0.0 if parsing fails
                      double.tryParse(controller.sTargetLng.value) ?? 0.0,
                    ),
                    radius: controller.iRadius.value.toDouble(), // Default to 0.0 if null
                    fillColor: Colors.blue.withOpacity(0.3),
                    strokeColor: Colors.blue,
                    strokeWidth: 1,
                  ),
              },
              polylines: {
                if (controller.currentPosition.value != null && controller.sTargetLat.value !=  "0.0" && controller.sTargetLng.value !=  "0.0")
                  Polyline(
                    polylineId: const PolylineId('line_between_locations'),
                    points: [
                      controller.currentPosition.value!,
                      LatLng(
                        double.tryParse(controller.sTargetLat.value) ?? 0.0,
                        double.tryParse(controller.sTargetLng.value) ?? 0.0,
                      ),
                    ],
                    color: Colors.red,
                    width: 2,
                  ),
              },
              onMapCreated: (GoogleMapController mapController) async {
                controller.mapController = mapController;
                if (controller.currentPosition.value != null && controller.sTargetLat.value !=  "0.0" && controller.sTargetLng.value !=  "0.0") {
                  double distanceInMeters = Geolocator.distanceBetween(
                    controller.currentPosition.value!.latitude,
                    controller.currentPosition.value!.longitude,
                    double.tryParse(controller.sTargetLat.value) ?? 0.0,
                    double.tryParse(controller.sTargetLng.value) ?? 0.0,
                  );
                  print('Distance: ${distanceInMeters.toStringAsFixed(2)} meters');
                  // Optionally display the distance on the UI
                }
              },
              mapType: MapType.normal,
            ),
            Positioned(
              top: 20,
              left: 25,
              right: 25,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 280, // Reduced width
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade200, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Reduced padding
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Row(
                          children: [
                            Icon(
                              controller.distanceToTarget.value <= controller.iRadius.value
                                  ? Icons.location_on
                                  : Icons.warning_amber_rounded,
                              color: controller.distanceToTarget.value <= controller.iRadius.value
                                  ? Colors.green
                                  : Colors.red,
                              size: 28, // Reduced icon size
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Distance Alert",
                                style: GoogleFonts.roboto(
                                  fontSize: 16, // Reduced font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Distance Info
                        Text(
                          "Target is within ${controller.iRadius.value} meters range.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 14, // Reduced font size
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Current Distance
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: controller.distanceToTarget.value <= controller.iRadius.value
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Current Distance: ",
                                style: GoogleFonts.roboto(
                                  fontSize: 14, // Reduced font size
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "${controller.distanceToTarget.value.toStringAsFixed(0)} meters",
                                style: GoogleFonts.roboto(
                                  fontSize: 14, // Reduced font size
                                  fontWeight: FontWeight.bold,
                                  color: controller.distanceToTarget.value <= controller.iRadius.value
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.distanceToTarget.value <= controller.iRadius.value
                                    ? "You are within the target range!"
                                    : "You are outside the target range!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 12, // Reduced font size
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              controller.distanceToTarget.value <= controller.iRadius.value
                                  ? Icons.check_circle_outline
                                  : Icons.error_outline,
                              color: controller.distanceToTarget.value <= controller.iRadius.value
                                  ? Colors.green
                                  : Colors.red,
                              size: 24, // Reduced icon size
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 200, // Reduced button width
                          child: ElevatedButton.icon(
                            onPressed: controller.recenterToTargetLocation,
                            icon: const Icon(Icons.my_location, color: Colors.white, size: 20), // Smaller icon
                            label: Text(
                              "Recenter",
                              style: GoogleFonts.roboto(
                                fontSize: 14, // Reduced font size
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: controller.isInRange.value
                                  ? Colors.green
                                  : SColors.rozgarRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: controller.isCheckInVisible.value,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical:5, horizontal: 20),
                          backgroundColor: controller.isInRange.value
                              ? Colors.green
                              : SColors.rozgarRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: controller.isInRange.value ? 5 : 0,
                        ),
                        onPressed: () {
                          controller.markAttendance(context,true);
                        },
                        child: Text(
                          'Check In',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: controller.isCheckOutVisible.value,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          backgroundColor: controller.isInRange.value
                              ? Colors.green
                              : SColors.rozgarRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: controller.isInRange.value ? 5 : 0,
                        ),
                        onPressed: () {
                          controller.markAttendance(context,false);
                        },
                        child: Text(
                          'Check Out',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
