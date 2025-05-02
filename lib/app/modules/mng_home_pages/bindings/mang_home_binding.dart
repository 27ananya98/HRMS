import 'package:get/get.dart';
import 'package:hrms/app/modules/mng_home_pages/controllers/mang_home_controller.dart';

class MangHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MangHomeController>(() => MangHomeController());
  }
}