import 'package:get/get.dart';
import 'package:hrms/app/modules/feedback/controllers/feedback_controller.dart';

class FeedbackBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }
}