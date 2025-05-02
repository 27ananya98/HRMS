import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/feedback_list/controllers/feedback_list_controller.dart';
import 'package:hrms/utils/time_handler.dart';
import '../../../model/feedback_list_model.dart';
import '../../../utils/s_colors.dart';
import '../../../widget/progress_dialog.dart';

class FeedbackListView extends GetView<FeedbackListController> {
  final FeedbackListController controller = Get.put(FeedbackListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Obx(() {
        // Show loader initially when loading is true
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // After loading, check if the feedback list is empty
        return ProgressDialog(
          loading: controller.isLoading.value,
          child: controller.feedbackList.isEmpty
              ? Center(child: Text("No feedback available"))
              : ListView.builder(
            itemCount: controller.feedbackList.length,
            itemBuilder: (context, index) {
              final feedback = controller.feedbackList[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Displaying the count
                      CircleAvatar(
                        backgroundColor: SColors.grey,
                        child: Text(
                          '${index + 1}', // Count display
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${TimeHandler.convertUtcToIndianDateTime(feedback.createdAt!)}"),
                            ],
                          ),
                        ),
                      ),
                      // Detail button
                      ElevatedButton.icon(
                        onPressed: () {
                          showFeedbackDetailDialog(context, feedback);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: SColors.rozgarRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                        ),
                        icon: Icon(Icons.visibility, size: 18,color: SColors.white,),
                        label: Text(
                          'Details',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: SColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
  void showFeedbackDetailDialog(BuildContext context, Result feedback) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          title: Center(
            child: Text(
              "Feedback Details",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: SColors.rozgarRed,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeedbackSection("HR Feedback", feedback.hrFeed!, feedback.hrRat.toString()),
                  _buildDivider(),
                  _buildFeedbackSection("Manager Feedback", feedback.repmFeed!, feedback.repmRat.toString()),
                  _buildDivider(),
                  _buildFeedbackSection("Policy Feedback", feedback.comPolFeed!, feedback.comPolRat.toString()),
                  _buildDivider(),
                  _buildFeedbackSection("Health Environment Feedback", feedback.healthenvFeed!, feedback.healthenvRat.toString()),
                  _buildDivider(),
                  _buildFeedbackSection("Safety Feedback", feedback.satetyFeed!, feedback.safetyRat.toString()),
                  _buildDivider(),
                  _buildDetailText("Overall Suggestion", feedback.overallSug!),
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: SColors.rozgarRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                ),
                child: Text(
                  "Close",
                  style: GoogleFonts.roboto(
                    color: SColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeedbackSection(String label, String feedback, String? rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailText(label, feedback),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 18),
            SizedBox(width: 4),
            Text(
              "Rating: ${rating?.toString() ?? 'N/A'}/10",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: "$label: ",
              style: TextStyle(fontWeight: FontWeight.bold, color: SColors.rozgarRed),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 24,
    );
  }

}
