import 'package:get/get.dart';
import 'package:hrms/app/modules/upcoming_birthdays/controllers/UpcomingBirthdayController.dart';

class UpcomingBirthdayBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UpcomingBirthdayController>(() =>UpcomingBirthdayController());
  }

}