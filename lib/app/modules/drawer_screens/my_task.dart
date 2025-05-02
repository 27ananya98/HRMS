import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:hrms/utils/fun.dart';
import 'package:intl/intl.dart';

import '../../../model/task_list.dart';
import '../../../utils/s_colors.dart';
import '../../../widget/cards/task_card.dart';
import '../../../widget/dialogs/add_daily_task.dart';
import '../../../widget/progress_dialog.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  DateTime? sFrom;
  DateTime? sTo;
  late DateTime _selectedDate;
  TaskList? taskList;
  bool isLoading = false;  // Flag to track loading state
  bool hasError = false;   // Flag to track if there's an API error

  @override
  void initState() {
    super.initState();
    Fun.customLogEvent("my_task");
    _selectedDate = DateTime.now();
    getTaskList(true);
  }

  getTaskList(bool isVisible) async {
    setState(() {
      isLoading = isVisible;
      hasError = false;  // Reset error flag
    });

    try {
      TaskList response = await ApiHandler().getDailyTask();
      response.result?.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));

      setState(() {
        taskList = response.result != null && response.result!.isNotEmpty ? response : null;
      });
    } catch (e) {
      // If the API call fails, set hasError to true
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;  // Hide loader after API call is done
      });
    }
  }

  Future<void> _selectOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != sTo) {
      setState(() {
        sTo = picked;
      });
    }
  }

  Future<void> _selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sFrom,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != sFrom) {
      setState(() {
        sFrom = picked;
      });
    }
  }

  void _openAddTaskDialog({String? taskId, String? title, String? description}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDailyTask(
          callback:()async {
            await  getTaskList(true);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress Dialog Example',
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
              "My Task",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.white,
                fontSize: 18,
              ),
            ),
          ),
          body: isLoading
              ? Fun.getLoadingUICircular(context) // Show loader while loading
              : hasError
              ? Center(
            child: Text(
              "Failed to load data. Please try again.",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.black,
                fontSize: 16,
              ),
            ),
          )
              : (taskList == null || taskList!.result!.isEmpty)
              ? Center(
            child: Text(
              "No data found.",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: SColors.black,
                fontSize: 16,
              ),
            ),
          )
              : RefreshIndicator(
            onRefresh: () async {
              await getTaskList(false);  // Refresh the task list
            },
            child: ListView.builder(
              itemCount: taskList!.result!.length,
              itemBuilder: (context, index) {
                final reversedList = taskList!.result!.reversed.toList();
                final task = reversedList[index];
                return TaskCard(
                  task: task,
                  onTap: (task) {
                    try{
                      DateTime taskDate = DateFormat('dd MMM yyyy').parse(task.createdAt!);
                      DateTime currentDate = DateTime.now();
                      DateTime formattedCurrentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
                      if (taskDate == formattedCurrentDate) {
                        _openAddTaskDialog(
                          taskId: task.id.toString(),
                          title: task.title,
                          description: task.description,
                        );
                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("You are not allowed to edit tasks from previous days"),
                            backgroundColor: SColors.rozgarRed, // Set the background color to red
                          ),
                        );
                      }
                    }catch (e){
                      _openAddTaskDialog(
                        taskId: task.id.toString(),
                        title: task.title,
                        description: task.description,
                      );
                    }

                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _openAddTaskDialog();
            },
            backgroundColor: SColors.rozgarRed,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

}
