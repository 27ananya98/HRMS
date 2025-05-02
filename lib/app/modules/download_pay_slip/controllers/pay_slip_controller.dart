import 'package:get/get.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:intl/intl.dart';

import '../../../../model/pay_slip.dart';
import '../../../../utils/fun.dart';
import '../../../../utils/time_handler.dart';

class PaySlipController extends GetxController {
  RxBool loading = false.obs;
  Rx<PaySlip> response = PaySlip().obs;
  RxString sMonthName = "00".obs;
  RxString sTotal = "00".obs;
  RxInt daysInMonth = 0.obs;
  late DateTime currentDate;
  RxBool isEmpty = false.obs;
  RxString sTitle = "Download Pay Slip".obs;
  @override
  void onInit() {
    Fun.customLogEvent("salary_slip");
    currentDate = DateTime.now();
    currentDate = DateTime.now();
    String sMonth = DateFormat('MM').format(currentDate);
    String sYear = DateFormat('yyyy').format(currentDate);
    sMonthName.value = TimeHandler.getYearName(currentDate);
    daysInMonth.value =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    getPaySlipData(sYear,sMonth);
  }

  getPaySlipData(year, month) async {
    loading.value = true;
    try {
      response.value = await ApiHandler().getPaySlipData(month, year);
       if(response.value.status == false){
         isEmpty.value = true;
       }else{
         isEmpty.value = false;
       }
    } catch (e) {
      isEmpty.value = true;
      loading.value = false;
    }
    loading.value = false;
  }
}
