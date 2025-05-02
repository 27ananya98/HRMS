import 'package:get/get.dart';
import 'package:hrms/app/modules/download_pay_slip/controllers/pay_slip_controller.dart';

class PaySlipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaySlipController>(() => PaySlipController());
  }
}
