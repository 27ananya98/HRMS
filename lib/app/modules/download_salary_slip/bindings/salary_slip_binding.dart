import 'package:get/get.dart';
import 'package:hrms/app/modules/download_salary_slip/controllers/salary_slip_controller.dart';

class SalarySlipBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SalarySlipController>(() => SalarySlipController());
  }
}