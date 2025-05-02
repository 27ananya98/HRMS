import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/widget/dialogs/add_daily_task.dart';
import 'package:hrms/model/team_task_list.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/s_colors.dart';
import '../../../../../widget/cards/team_task_card.dart';
import '../controllers/team_controller.dart';
class TeamView extends GetView<TeamController> {
  void openAddTaskDialog({String? taskId, String? title, String? description}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AddDailyTask(
          callback: () async {
            await controller.getTeamTaskList(false);
          },
          taskId: taskId,
          title: title,
          description: description,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SColors.rozgarRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Team Task",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: SColors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Slightly reduce padding
            child: Container(
              height: 45, // Make the widget narrower
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25), // Curve the corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Position the shadow
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  controller.searchTerm.value = value; // Update search term
                },
                decoration: InputDecoration(
                  hintText: 'Search Employee', // Use hint instead of label
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Reduce padding inside the text field
                  border: InputBorder.none, // Remove border since we have a custom container
                  suffixIcon: Icon(Icons.search, color: Colors.grey), // Add search icon on the right
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child:Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only( right: 10, left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "From",
                              style: GoogleFonts.roboto(
                                  color: SColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            child: Text(
                              "To",
                              style: GoogleFonts.roboto(
                                  color: SColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                        return Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          InkWell(
                                            child: Text(
                                                controller.sFrom.value == null
                                                    ? 'MM-DD-YYY'
                                                    : '${DateFormat('MM-dd-yyyy').format(controller.sFrom.value!)}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    color: SColors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12)
                                            ),
                                            onTap: () {
                                              controller.selectInDate(context);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            iconSize: 20,
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              controller.selectInDate(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                          controller.sTo.value == null
                                              ? 'MM-DD-YYY'
                                              : '${DateFormat('MM-dd-yyyy').format(controller.sTo.value!)}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                                color: SColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12)
                                      ),
                                      onTap: () {
                                        controller.selectOutDate(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      iconSize: 20,
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        controller.selectOutDate(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              final tasks = controller.filteredTaskList.value.result?.reversed.toList();
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.getTeamTaskList(false); // Refresh the task list
                },
                child: tasks == null || tasks.isEmpty
                    ? Center(child: Text('No tasks found'))
                    : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TeamTaskCard(
                      task: task,
                      onTap: (task) {
                        // Handle task tap if needed
                      },
                      onMenuSelected: (String choice, Result task) {
                        switch (choice) {
                          case 'Edit':
                            openAddTaskDialog(
                              taskId: task.id.toString(),
                              title: task.title,
                              description: task.description,
                            );
                            break;
                          case 'Approve':
                            controller.manageTaskStatus(task.id!, task.createdAt!, true, task.userid!);
                            break;
                          case 'Reject':
                            controller.manageTaskStatus(task.id!, task.createdAt!, false, task.userid!);
                            break;
                        }
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
