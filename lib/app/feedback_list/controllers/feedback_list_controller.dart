import 'package:get/get.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:hrms/model/feedback_list_model.dart';

class FeedbackListController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Result> feedbackList = <Result>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFeedbackList();
  }

  getFeedbackList() async {
    isLoading.value = true;
    FeedbackListModel response = await ApiHandler().getFeedbackList();
    if (response.status == true && response.result != null) {
      feedbackList.assignAll(response.result!);
    }
    isLoading.value = false;
  }
}
