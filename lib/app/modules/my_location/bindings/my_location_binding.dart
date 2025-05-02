import 'package:get/get.dart';
import 'package:hrms/app/modules/my_location/controllers/my_location_controller.dart';

class MyLocationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyLocationController>(() => MyLocationController());
  }

}