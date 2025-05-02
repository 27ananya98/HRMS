import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/feedback/controllers/feedback_controller.dart';
import '../../../../routes/get_routes.dart';
import '../../../../utils/fun.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/progress_dialog.dart';

class FeedbackView extends GetView<FeedbackController> {
  FeedbackController controller = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: SColors.rozgarRed,
      ),
      home: WillPopScope(
        onWillPop: () async {
          Fun.showExitConfirmationDialog(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: SColors.rozgarRed,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Feedback Form",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 18,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  Get.toNamed(AppRoute.feedbackList);
                },
              ),
            ],
          ),
          body:Obx(() {
            return ProgressDialog(
              loading: controller.isLoading.value,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    buildFeedbackField(
                        "HR Department Feedback *", controller.hrFeedbackController,
                        controller.hrFeedbackError),
                    buildFeedbackField("Reporting Manager Feedback *",
                        controller.managerFeedbackController,
                        controller.managerFeedbackError),
                    buildFeedbackField("Company Policies Feedback *",
                        controller.policiesFeedbackController,
                        controller.policiesFeedbackError),
                    buildFeedbackField("Healthy Work Environment *",
                        controller.environmentFeedbackController,
                        controller.environmentFeedbackError),
                    buildFeedbackField(
                        "Safety Feedback *", controller.safetyFeedbackController,
                        controller.safetyFeedbackError),
                    Text("Overall Suggestions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextField(
                      controller: controller.suggestionsController,
                      maxLength: 500,
                      maxLines: null,
                      onChanged: (value) {
                        if (value.length > 500) {
                          controller.suggestionsController.text = value.substring(0, 500);
                          controller.suggestionsController.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.suggestionsController.text.length),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: SColors.rozgarRed), // Set focused border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: SColors.black), // Set enabled border color
                        ),
                      ),
                    ),
                    Obx(() => Text(
                      controller.suggestionsError.value,
                      style: TextStyle(color: Colors.red),
                    )),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: SColors.rozgarRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                        ),
                        onPressed: () {
                          if (controller.validateForm()) {
                            controller. addFeedbackDetails();
                          }
                        },
                        child: Text(
                          "Submit",
                          style: GoogleFonts.roboto(color: SColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }) ,
        ),
      ),
    );
  }

  Widget buildFeedbackField(String title, TextEditingController textController, RxString errorText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextField(
          controller: textController,
          maxLength: 500,
          maxLines: null,
          onChanged: (value) {
            if (value.length > 500) {
              textController.text = value.substring(0, 500);
              textController.selection = TextSelection.fromPosition(
                TextPosition(offset: textController.text.length),
              );
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: SColors.rozgarRed), // Set focused border color
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: SColors.black), // Set enabled border color
            ),
          ),
        ),
        Obx(() => Text(
          errorText.value,
          style: GoogleFonts.roboto(fontSize: 15,color: SColors.rozgarRed),
        )),
        SizedBox(height: 5),
        Text("Rating (1 to 10)", style: GoogleFonts.roboto(fontSize: 16)),
        Obx(() {
          bool isRatingMissing = controller.rating[title] == null;
          bool showRedBorder = isRatingMissing && controller.isSubmitted.value; // Show red border only after submission
          return Wrap(
            children: List.generate(10, (index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical:3), // Reduced padding
                  minimumSize: Size(40, 20), // Reduced button size
                  primary: controller.rating[title] == index + 1
                      ? SColors.rozgarRed
                      : Colors.grey,
                  side: showRedBorder
                      ? BorderSide(color: SColors.rozgarRed, width: 1)
                      : BorderSide.none, // Apply red border if rating is missing after submission
                ),
                onPressed: () {
                  controller.updateRating(title, index + 1);
                },
                child: Text(
                  "${index + 1}",
                  style: GoogleFonts.roboto(
                    color: SColors.white,
                    fontSize: 12, // Reduced font size
                  ),
                ),
              );
            }),
          )
          ;
        }),
        SizedBox(height: 20),
      ],
    );
  }


}
