import 'package:get/get.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:hrms/model/upcoming_event.dart';
import 'package:intl/intl.dart';
import '../../../../utils/time_handler.dart';

class EventController extends GetxController {
  var isLoading = false.obs;
  var response = UpcomingEvent().obs;
  var sDate = "--".obs;
  var sTitle = "--".obs;
  var isListEmpty = false.obs;
  var isEventListEmpty = false.obs;
  var selectedYear = DateTime.now().year;

  @override
  void onInit() {
    super.onInit();
    getEventLists(selectedYear);
  }

  Future<void> getEventLists(int year) async {
    isLoading.value = true;

    try {
      List<String> eventList = [];
      UpcomingEvent? apiResponse = await ApiHandler().getUpcomingEventList();

      // Check if the response and result list are not null
      if (apiResponse != null && apiResponse.result != null) {
        apiResponse.result!.forEach((element) {
          if (element.eventDt != null) {
            eventList.add(element.eventDt!);
          }
        });

        final currentDate = DateTime.now();
        final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
        final latestDate = findUpcomingDate(eventList, formattedDate);

        apiResponse.result!.forEach((element) {
          if (element.eventDt != null &&
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(element.eventDt!)) ==
                  latestDate) {
            sDate.value = TimeHandler.convertDate(element.eventDt!);
            sTitle.value = element.title ?? '--';
          }
        });
      }

      isListEmpty.value = apiResponse?.result?.isNotEmpty ?? false;
      isEventListEmpty.value = apiResponse?.result?.isEmpty ?? true;
      response.value = apiResponse ?? UpcomingEvent(); // Ensure no null assignment
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String findUpcomingDate(List<String> dateList, String selectedDate) {
    final selectedDateTime = DateTime.parse(selectedDate);
    DateTime upcomingDateTime = DateTime(3000);
    String upcomingDate = "";

    for (String dateString in dateList) {
      final date = DateTime.parse(dateString);
      if (date.isAfter(selectedDateTime) && date.isBefore(upcomingDateTime)) {
        upcomingDateTime = date;
        upcomingDate = DateFormat('yyyy-MM-dd').format(date);
      }
    }

    return upcomingDate;
  }
}
