import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../api/api_handler.dart';
import '../../model/add_daily_task.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class AddDailyTask extends StatefulWidget {
  final Function() callback;
  final String? taskId;
  final String? title;
  final String? description;

  AddDailyTask({
    required this.callback,
    this.taskId,
    this.title,
    this.description,
  });

  @override
  _AddDailyTaskState createState() => _AddDailyTaskState();
}

class _AddDailyTaskState extends State<AddDailyTask> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _taskNameController;
  late TextEditingController _descriptionController;
  bool isProgress = false;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController(text: widget.title ?? "");
    _descriptionController = TextEditingController(text: widget.description ?? "");
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  addOrUpdateTask(String title, String description) async {
    String sError = "Technical issue";
    setState(() {
      isProgress = true;
    });

    String formattedDate = DateFormat('MM-dd-yyyy').format(DateTime.now());
    final Map<String, dynamic> addTask = {
      "title": title,
      "description": description,
      "created_at": formattedDate,
      "modified_at": formattedDate
    };

    try {
      bool isSuccess;
      if (widget.taskId == null) {
        AddDailyTaskModel  response =  await ApiHandler().addDailyTask(addTask);
        sError = response.error.toString();
        print(sError);

        isSuccess = response.status!;
      } else {
        final Map<String, dynamic> updateTask = {
          "task_id": widget.taskId,
          "title": title,
          "description": description,
          "modified_at": formattedDate,
        };
        AddDailyTaskModel  response =  await ApiHandler().updateDailyTask(updateTask);
        sError = response.error.toString();
        isSuccess = response.status!;
      }

      if (isSuccess) {
        print("Task ${widget.taskId == null ? 'added' : 'updated'} successfully.");
        widget.callback();
        Navigator.of(context).pop();
      }else{
        Get.snackbar("Request Failed", sError, colorText: Colors.white, backgroundColor: SColors.rozgarRed, snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar("Request Failed", sError, colorText: Colors.white, backgroundColor: SColors.rozgarRed, snackPosition: SnackPosition.TOP,
      );
      print("Error in task ${widget.taskId == null ? 'addition' : 'update'}.");
    } finally {
      setState(() {
        isProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      color: SColors.rozgarRed,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    '${widget.taskId == null ? 'Add' : 'Edit'} Task Details',
                                    style: GoogleFonts.roboto(
                                        color: SColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  "Title *",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                    color: SColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _taskNameController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: SColors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: SColors.rozgarRed),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a task name.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              // Trigger revalidation for this field
                            });
                          },
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Description *",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                    color: SColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: SColors.rozgarRed),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: ' ',
                          ),
                          maxLines: null,
                          maxLength: 500,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              // Trigger revalidation for this field
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  SColors.rozgarRed),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                addOrUpdateTask(
                                  _taskNameController.text,
                                  _descriptionController.text,
                                );
                              }
                            },
                            child: Text('Submit', style: GoogleFonts.roboto(color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: isProgress,
              child: Fun.getLoadingUICircular(context),
            ),
          ),
        ],
      ),
    );
  }
}
