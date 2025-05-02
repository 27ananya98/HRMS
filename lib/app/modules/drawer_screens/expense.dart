import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/fun.dart';

import '../../../../api/api_handler.dart';
import '../../../../model/expense_list.dart';
import '../../../../utils/s_colors.dart';
import '../../../../widget/dialogs/expense_reimbursement_dialog.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  bool _isLoading = true;
  late Future<ExpenseList> _myFuture;

  @override
  void initState() {
    super.initState();
    Fun.customLogEvent("expense");
    _myFuture = getExpenseList();
  }

  Future<ExpenseList> getExpenseList() async {
    ExpenseList response = await ApiHandler().getExpenseList();
    return response;
  }

  getYesOrNo(value) {
    if (value) {
      return "Yes";
    } else {
      return "No";
    }
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
              icon: Icon(Icons.arrow_back,color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("Expense & Reimbursement",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: SColors.white,
                    fontSize: 16)),
          ),
          body: Stack(
            children: [
              Container(
                child: FutureBuilder(
                  future: _myFuture,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as ExpenseList;
                      return Container(
                        //  width: 80.0,
                        //             height: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                            itemCount: items == null
                                ? 0
                                : items.result!.expenses.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // The first item will be at the start
                                        Text(
                                            'REQ' +
                                                items.result!.expenses[index].Id
                                                    .toString(),
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                color: SColors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text("Assigned To",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'Total Amount',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  color: SColors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              items.result!.expenses[index]
                                                  .AssignedTo
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                                style: GoogleFonts.roboto(
                                                    color: SColors.black,
                                                    fontSize: 14)
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              items.result!.expenses[index]
                                                  .TotalAmount
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                                style: GoogleFonts.roboto(
                                                    color: SColors.black,
                                                    fontSize: 14)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Text(
                                              'Date',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  color: SColors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'Is Final Approved',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  color: SColors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                                items.result!.expenses[index]
                                                    .Date
                                                    .toString(),
                                                textAlign: TextAlign.left,style: GoogleFonts.roboto(
                                                color: SColors.black,
                                                fontSize: 14)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                                getYesOrNo(items
                                                    .result!
                                                    .expenses[index]
                                                    .IsFinalApproved),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.roboto(
                                                    color: SColors.black,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(SColors.rozgarRed), // Set the desired color here
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ExpenseReimbursementDialog();
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: SColors.rozgarRed,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
