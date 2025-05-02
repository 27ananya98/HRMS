import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:hrms/model/feedback_form_model.dart' hide Result;
import 'package:hrms/model/feedback_list_model.dart';
import '../../../../utils/s_colors.dart';


class FeedbackController extends GetxController {
  var rating = <String, int>{}.obs;
  final hrFeedbackController = TextEditingController();
  final managerFeedbackController = TextEditingController();
  final policiesFeedbackController = TextEditingController();
  final environmentFeedbackController = TextEditingController();
  final safetyFeedbackController = TextEditingController();
  final suggestionsController = TextEditingController();
  RxBool isLoading = false.obs;  // Flag to track loading state
  var hrFeedbackError = ''.obs;
  var managerFeedbackError = ''.obs;
  var policiesFeedbackError = ''.obs;
  var environmentFeedbackError = ''.obs;
  var safetyFeedbackError = ''.obs;
  var suggestionsError = ''.obs;
  var isSubmitted = false.obs;
  RxBool isContainThisMonthFeedBack = false.obs;
  RxList<Result> feedbackList = <Result>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFeedbackInfo();
  }
  getFeedbackInfo()async{
    isContainThisMonthFeedBack.value = await hasFeedbackForCurrentMonth();
  }
  void updateRating(String title, int value) {
    rating[title] = value;
    update();
  }

  bool validateForm() {
    bool isValid = true;
    isSubmitted.value = true;
    if (hrFeedbackController.text.isEmpty) {
      hrFeedbackError.value = "HR Executive feedback can't be empty.";
      isValid = false;
    } else {
      hrFeedbackError.value = '';
    }
    if (managerFeedbackController.text.isEmpty) {
      managerFeedbackError.value = "Reporting Manager feedback can't be empty.";
      isValid = false;
    } else {
      managerFeedbackError.value = '';
    }
    if (policiesFeedbackController.text.isEmpty) {
      policiesFeedbackError.value = "Company Policies feedback can't be empty.";
      isValid = false;
    } else {
      policiesFeedbackError.value = '';
    }
    if (environmentFeedbackController.text.isEmpty) {
      environmentFeedbackError.value = "Healthy Work can't be empty.";
      isValid = false;
    } else {
      environmentFeedbackError.value = '';
    }
    if (safetyFeedbackController.text.isEmpty) {
      safetyFeedbackError.value = "Safety Feedback can't be empty.";
      isValid = false;
    } else {
      safetyFeedbackError.value = '';
    }
    // if (suggestionsController.text.isEmpty) {
    //   suggestionsError.value = "Suggestions can't be empty.";
    //   isValid = false;
    // } else {
    //   suggestionsError.value = '';
    // }
    if (rating.length < 5) {
      isValid = false;
    }
    if(isContainThisMonthFeedBack.value == true) {
      Get.snackbar(
        "Alert",
        "You are allowed to submit only one feedback per month.",
        colorText: Colors.white,
        backgroundColor: SColors.rozgarRed,
        snackPosition: SnackPosition.TOP,
      );
      isValid = false;
    }

    return isValid;
  }

  addFeedbackDetails() async{
    var body = {
      "hr_feed":hrFeedbackController.text,
      "hr_rat":rating.values.toList()[0],
      "repm_feed":managerFeedbackController.text,
      "repm_rat":rating.values.toList()[1],
      "comPol_feed":policiesFeedbackController.text,
      "comPol_rat":rating.values.toList()[2],
      "healthenv_feed":environmentFeedbackController.text,
      "healthenv_rat":rating.values.toList()[3],
      "satety_feed":safetyFeedbackController.text,
      "safety_rat":rating.values.toList()[4],
      "overall_sug":suggestionsController.text
    };
    try{
      isLoading.value = true;
      FeedbackFormModel response = await ApiHandler().addFeedback(body);
      if(response.status == true){
        hrFeedbackController.clear();
        managerFeedbackController.clear();
        policiesFeedbackController.clear();
        environmentFeedbackController.clear();
        safetyFeedbackController.clear();
        suggestionsController.clear();
        rating.clear(); // Clear all ratings
        hrFeedbackError.value = '';
        managerFeedbackError.value = '';
        policiesFeedbackError.value = '';
        environmentFeedbackError.value = '';
        safetyFeedbackError.value = '';
        suggestionsError.value = '';
        isSubmitted.value = false;
        Get.snackbar("Submission Successful","Your information Has Been Submitted", colorText: Colors.white, backgroundColor: SColors.rozgarRed, snackPosition: SnackPosition.TOP,);
      }else{
        Get.snackbar("Request Failed",response.error.toString(), colorText: Colors.white, backgroundColor: SColors.rozgarRed, snackPosition: SnackPosition.TOP,);
      }
      isLoading.value = false;
    }catch (e){
      Get.snackbar("Request Failed", "Something went wrong", colorText: Colors.white, backgroundColor: SColors.rozgarRed, snackPosition: SnackPosition.TOP,);
      isLoading.value = false;
    }

  }
  Future<bool> hasFeedbackForCurrentMonth() async {
    isLoading.value = true; // Set loading state
    FeedbackListModel response = await ApiHandler().getFeedbackList();
    isLoading.value = false; // Reset loading state

    if (response.status == true && response.result != null) {
      feedbackList.assignAll(response.result!);

      final currentDate = DateTime.now();
      final currentYear = currentDate.year;
      final currentMonth = currentDate.month;

      return feedbackList.any((feedback) {
        if (feedback.createdAt != null) {
          final feedbackDate = DateTime.parse(feedback.createdAt!);
          return feedbackDate.year == currentYear && feedbackDate.month == currentMonth;
        }
        return false;
      });
    }
    return false; // No feedback available or API call failed
  }

  @override
  void onClose() {
    hrFeedbackController.dispose();
    managerFeedbackController.dispose();
    policiesFeedbackController.dispose();
    environmentFeedbackController.dispose();
    safetyFeedbackController.dispose();
    suggestionsController.dispose();
    super.onClose();
  }
}
