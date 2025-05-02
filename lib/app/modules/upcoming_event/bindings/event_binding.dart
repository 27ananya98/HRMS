import 'package:get/get.dart';
import 'package:hrms/app/modules/upcoming_event/controllers/event_controller.dart';

class EventBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EventController>(() => EventController());
  }
}




