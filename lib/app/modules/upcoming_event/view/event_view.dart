import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/app/modules/upcoming_event/controllers/event_controller.dart';
import '../../../../utils/s_colors.dart';
import '../../../../utils/time_handler.dart';
import '../../../../widget/dialogs/PgDialogWs.dart';
import '../../../../widget/progress_dialog.dart';

class EventView extends GetView<EventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SColors.rozgarRed,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Event List',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 18)),
      ),
      body: Obx(() {
        return PgDialogWs(
          loading: controller.isLoading.value,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [SColors.rozgarRed, Colors.orangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, color: Colors.white, size: 36),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.sTitle.value,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          Text(
                            controller.sDate.value,
                            style: GoogleFonts.roboto(
                                color: Colors.white70,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // Icon(Icons.chevron_right, color: Colors.white70, size: 30),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Visibility(
                      visible: controller.isListEmpty.value,
                      child: ListView.builder(
                        itemCount: controller.response.value.result?.length,
                        itemBuilder: (context, index) {
                          final event = controller.response.value.result![index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16.0),
                                leading: CircleAvatar(
                                  backgroundColor: SColors.rozgarRed,
                                  child: Icon(Icons.event_available,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  event.title.toString(),
                                  style: GoogleFonts.roboto(
                                      color: SColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                subtitle: Text(
                                  TimeHandler.convertDate(
                                      event.eventDt.toString()),
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
                                ),
                                // trailing: Icon(Icons.chevron_right,
                                //     color: Colors.grey.shade600),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: controller.isEventListEmpty.value,
                      child: Center(
                        child: Text(
                          "No upcoming events available.",
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
