import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import '../../api/api_handler.dart';
import '../../app/modules/drawer_screens/expense.dart';
import '../../model/AddExpenseBill.dart';
import '../../model/assigne_to.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';
import '../progress_dialog.dart';

class ExpenseReimbursementDialog extends StatefulWidget {
  @override
  _ExpenseReimbursementDialogState createState() =>
      _ExpenseReimbursementDialogState();
}

class _ExpenseReimbursementDialogState
    extends State<ExpenseReimbursementDialog> {
  DateTime? sTo;
  String sDescription = "";
  String sAmount = "0";

  late DateTime _selectedDate;
  String? sFileName;
  String? selectedFilePath;
  bool isProgress = false;
  bool isAttendanceListLoaded = false;
  int selectedOptionIndex = 0;
  List<String> attendanceList = <String>["Assigned To"];
  AssigneTo? responseData;
  AddExpenseBill? response;
  // Controllers and validation flags
  late final TextEditingController expenseAmmount = TextEditingController();
  late final TextEditingController descriptionController = TextEditingController();

  bool isAmountValid = true;
  bool isDateValid = true;
  bool isAssignedToValid = true;
  bool isFileSelected = true;
  bool isDescriptionValid = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    getAssignedList().then((value) => setState(() {
      attendanceList.clear();
      attendanceList = value;
      isAttendanceListLoaded = true;
      isProgress = false;
    }));
  }

  Future<List<String>> getAssignedList() async {
    setState(() {
      isAttendanceListLoaded = false;
      isProgress = true;
    });
    List<String> attendanceList = <String>[];
    try {
      AssigneTo response = await ApiHandler().getAssigneList();
      attendanceList.clear();
      attendanceList.add("Assigned To");
      response.result!.forEach((ele) {
        if (ele.name != null) {
          String? value = ele.name;
          attendanceList.add(value!);
        }
      });
      setState(() {
        responseData = response;
      });
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      Navigator.of(context).pop();
    }
    return attendanceList;
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

  selectFile() {
    Fun.selectFile().then((value) => {
      setState(() {
        sFileName = path.basename(value);
        selectedFilePath = value;
        uploadExpensBill(
          File(selectedFilePath!),
          sFileName!,
        );
      })
    });
  }

  uploadExpensBill(filePath,fileName)async{
    setState(() => isProgress = true);
    try{
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath.path, filename: fileName),
      });
      response = await ApiHandler().addExpenseBill(formData);
    }catch (e) {
      Fun.showToast("Something went wrong!");
    } finally {
      setState(() => isProgress = false);
    }
  }

  uploadExpense(String assignedTo, String date, String description,String totalAmount) async {
    setState(() => isProgress = true);
    try {
     var body = {
        "assignedTo": assignedTo,
        "costCenter": "",
        "date": date,
        "description": description,
        "fileName": response?.result?.fileName,
        "gstNo": "",
        "originalFile": response?.result?.originalFile,
        "reciptNo": "",
        "totalAmount": totalAmount,
        "isInvoiceTaxPaid": false,
        "custom_fields": [],
      };
      bool isSuccess = await ApiHandler().addExpense(body);
      if (isSuccess) {
        _navigateToExpenseScreen();
      }
    } catch (e) {
      Fun.showToast("Something went wrong!");
    } finally {
      setState(() => isProgress = false);
    }
  }
  void _navigateToExpenseScreen() {
    Navigator.of(context).pop();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Expense()));
  }
  bool validateFields() {
    setState(() {
      isAmountValid = sAmount.isNotEmpty && double.tryParse(sAmount) != null && double.parse(sAmount) > 0;
      isDateValid = sTo != null;
      isAssignedToValid = selectedOptionIndex > 0;
      isFileSelected = selectedFilePath != null;
      isDescriptionValid = sDescription.isNotEmpty && sDescription.length > 1;
    });
    return isAmountValid && isDateValid && isAssignedToValid && isFileSelected && isDescriptionValid;
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ProgressDialog(
                loading: isProgress,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15),
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
                                    border: Border.all(color: Colors.grey, width: 2.0),
                                    color: Colors.white,
                                  ),
                                  child: const Center(
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
                                    'Add Expense',
                                    style: GoogleFonts.roboto(
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text('Expense Date'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectOutDate(context);
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectOutDate(context);
                              },
                              child: Text(
                                sTo == null ? 'MMM-dd-yyyy' : '${DateFormat('MMM dd, yyyy').format(sTo!)}',
                                style: GoogleFonts.roboto(
                                  color: isDateValid ? Colors.black : SColors.rozgarRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!isDateValid)
                          Text(
                            'Please select a date',
                            style: TextStyle(color: SColors.rozgarRed, fontSize: 12),
                          ),
                        Text('Expense Amount'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text('₹', style: GoogleFonts.roboto(color: SColors.black, fontSize: 14)),
                            SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                height: 35, // Fixed height for the TextField
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: expenseAmmount,
                                  onChanged: (text) {
                                    setState(() {
                                      sAmount = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: isAmountValid ? Colors.grey : SColors.rozgarRed),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )

                        ,
                        if (!isAmountValid)
                          Text(
                            'Please enter a valid amount',
                            style: TextStyle(color: SColors.rozgarRed, fontSize: 12),
                          ),
                        SizedBox(height: 20),
                        Text('Assigned To *'),
                        SizedBox(height: 10),
                        DropdownButton(
                          value: attendanceList[selectedOptionIndex],
                          icon: Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          items: attendanceList.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOptionIndex = attendanceList.indexOf(newValue!);
                            });
                          },
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 1,
                            color: isAssignedToValid ? Colors.grey : SColors.rozgarRed,
                          ),
                        ),
                        if (!isAssignedToValid)
                          Text(
                            'Please select a valid person',
                            style: TextStyle(color: SColors.rozgarRed, fontSize: 12),
                          ),
                        SizedBox(height: 20),
                        Text('Upload Files *'),
                        GestureDetector(
                          onTap: () {
                            selectFile();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: isFileSelected ? Colors.grey : SColors.rozgarRed),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    sFileName ?? 'Select a file',
                                    style: TextStyle(color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                                Icon(Icons.attach_file_outlined, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        if (!isFileSelected)
                          Text(
                            'Please select a file to upload',
                            style: TextStyle(color: SColors.rozgarRed, fontSize: 12),
                          ),
                        SizedBox(height: 10),
                        Text('Expense Description'),
                        SizedBox(height: 10),
                        TextField(
                          controller: descriptionController,
                          onChanged: (text) {
                            setState(() {
                              sDescription = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: isDescriptionValid ? Colors.grey : SColors.rozgarRed),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        if (!isDescriptionValid)
                          Text(
                            'Description cannot be empty',
                            style: TextStyle(color: SColors.rozgarRed, fontSize: 12),
                          ),
                        SizedBox(height: 10),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            if (validateFields()) {
                              uploadExpense(
                                responseData!.result![selectedOptionIndex-1].id.toString(),
                                DateFormat("yyyy-MM-dd").format(sTo!),
                                descriptionController.text,
                                sAmount.toString(),
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: SColors.rozgarRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Upload',
                                style: TextStyle(color: SColors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
