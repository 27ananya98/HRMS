import 'package:get/get.dart';
import 'package:hrms/utils/time_handler.dart';
import '../../../../api/api_handler.dart';
import '../../../../model/upcoming_birthday.dart';
import 'package:intl/intl.dart'; // For date formatting and parsing

class UpcomingBirthdayController extends GetxController {
  var isLoading = true.obs;
  Rx<UpcomingBirthday> upcomingBirthdays = UpcomingBirthday().obs;
  RxList<Result> filteredBirthdays = <Result>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingBirthdays();
  }

  void fetchUpcomingBirthdays() async {
    try {
      isLoading(true);
      var birthdays = await ApiHandler().getBirthdayList();
      if (birthdays != null) {
        upcomingBirthdays.value = birthdays;
        filterUpcomingBirthdays();
      }
    } finally {
      isLoading(false);
    }
  }

  void filterUpcomingBirthdays() {
    DateTime currentDate = DateTime.now();
    List<Result> upcomingList = upcomingBirthdays.value.result!.where((birthday) {
      try {
        DateTime birthdayDate = TimeHandler.convertZuluToIST(birthday.dateOfBirth!);
        birthdayDate = DateTime(currentDate.year, birthdayDate.month, birthdayDate.day);
        if (birthdayDate.isAfter(currentDate) ||
            (birthdayDate.day == currentDate.day && birthdayDate.month == currentDate.month)) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }).toList();
    upcomingList.sort((a, b) {
      DateTime dateA = DateTime(currentDate.year, DateFormat('yyyy-MM-dd').parse(a.dateOfBirth!).month, DateFormat('yyyy-MM-dd').parse(a.dateOfBirth!).day);
      DateTime dateB = DateTime(currentDate.year, DateFormat('yyyy-MM-dd').parse(b.dateOfBirth!).month, DateFormat('yyyy-MM-dd').parse(b.dateOfBirth!).day);
      return dateA.compareTo(dateB);
    });
    filteredBirthdays.value = upcomingList;
  }

}
