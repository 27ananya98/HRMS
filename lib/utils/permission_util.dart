import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/s_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static requestLocationPermissionAndEnableLocation(context) async {
    final permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      // Permission granted, check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        // Location services are disabled, open a dialog to enable them
        final result = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enable Location Services',style: GoogleFonts.roboto(color: SColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18)),
              content: Text('Location services are required for this feature. Do you want to enable them?',style: GoogleFonts.roboto(color: SColors.black,
                   fontSize: 16)),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel',style:GoogleFonts.roboto(color: SColors.rozgarRed)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Enable',style: GoogleFonts.roboto(color: SColors.rozgarRed),),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        if (result == true) {
          // User chose to enable location services
          await Geolocator.openLocationSettings();
        } else {
          // User chose not to enable location services
          // Handle this case as needed
        }
      } else {
        // Location services are already enabled
      }
    } else {
      // Permission denied, handle this case as needed
    }
  }

  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      requestLocationPermissionAndEnableLocation(context);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fun.showToast('Location permissions are denied');
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fun.showToast(
          'Location permissions are permanently denied, we cannot request permissions.');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}
