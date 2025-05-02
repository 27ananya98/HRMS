import 'package:get/get.dart';
import 'package:hrms/app/modules/emp_home_pages/controllers/emp_home_controller.dart';

class EmpHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EmpHomeController>(() => EmpHomeController());
  }
}