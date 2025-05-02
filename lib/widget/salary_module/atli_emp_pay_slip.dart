import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/pay_slip.dart';

class AtliEmpPaySlip {
  Widget employeeDetail(PaySlip? response) {
    return Table(
      border: TableBorder.all(
        color: Colors.black,
        // Adjust the color of the border
        width: 0.2,
        // Adjust the thickness of the border
        style: BorderStyle.solid,
      ),
      children: [
        TableRow(
          children: [
            TableCell(
                child: Center(
                    child: Text('Emp Code',
                        style: GoogleFonts.roboto(
                            fontSize: 3, fontWeight: FontWeight.bold)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.empcode ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child:
                        Text('Name', style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.name ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child:
                        Text('Level', style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child:
                        Text('    ', style: GoogleFonts.roboto(fontSize: 3)))),
          ],
        ),
        TableRow(
          children: [
            TableCell(
                child: Center(
                    child: Text('Department',
                        style: GoogleFonts.roboto(
                            fontSize: 3, fontWeight: FontWeight.bold)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.department ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text('Pan No',
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.pan ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text('Designation',
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.designation ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
          ],
        ),
        TableRow(
          children: [
            TableCell(
                child: Center(
                    child: Text('ESIC No',
                        style: GoogleFonts.roboto(
                            fontSize: 3, fontWeight: FontWeight.bold)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.employeeEsic ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text('UAN No',
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.uanNo ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child:
                        Text('DOJ', style: GoogleFonts.roboto(fontSize: 3)))),
            TableCell(
                child: Center(
                    child: Text(response?.result?.doj ?? "",
                        style: GoogleFonts.roboto(fontSize: 3)))),
          ],
        ),
      ],
    );
  }

  Widget atliEmpAttendance(PaySlip? response) {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(50),
        1: FlexColumnWidth(1),
        2: FixedColumnWidth(50),
        3: FlexColumnWidth(1),
        4: FixedColumnWidth(50),
        5: FlexColumnWidth(1),
        6: FixedColumnWidth(50),
        7: FlexColumnWidth(1),
      },
      border: TableBorder.all(
        color: Colors.black,
        width: 0.2,
        style: BorderStyle.solid,
      ),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Center(
                  child: Text('Total present Days: ',
                      style: GoogleFonts.roboto(
                          fontSize: 3, fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(
                  child: Text(response?.result?.totalPresentDays ?? "", style: GoogleFonts.roboto(fontSize: 3))),
            ),
            TableCell(
              child: Center(
                  child: Text('Actual Present Days :',
                      style: GoogleFonts.roboto(
                          fontSize: 3, fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(
                  child: Text(response?.result?.actualPresentDays ?? "",
                      style: GoogleFonts.roboto(fontSize: 3))),
            ),
            TableCell(
              child: Center(
                  child: Text('EL Balance',
                      style: GoogleFonts.roboto(
                          fontSize: 3, fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(
                  child: Text(response?.result?.el ?? "",
                      style: GoogleFonts.roboto(fontSize: 3))),
            ),
            TableCell(
              child: Center(
                  child: Text('CL Balance',
                      style: GoogleFonts.roboto(
                          fontSize: 3, fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(
                  child: Text((double.tryParse(response?.result?.cl ?? "") ?? 0).toStringAsFixed(1),
                      style: GoogleFonts.roboto(fontSize: 3))),
            ),
            TableCell(
              child: Center(
                  child: Text('SL Balance',
                      style: GoogleFonts.roboto(
                          fontSize: 3, fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(
                  child: Text((double.tryParse(response?.result?.sl ?? "") ?? 0).toStringAsFixed(1),
                      style: GoogleFonts.roboto(fontSize: 3))),
            ),
          ],
        ),
      ],
    );
  }

  Widget atliEmpEarningsDeduction(PaySlip? response) {
    return Column(children: [
      Table(
        border: TableBorder.all(
          color: Colors.black,
          // Adjust the color of the border
          width: 0.2,
          // Adjust the thickness of the border
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Center(
                    child: Text('Earnings',
                        style: GoogleFonts.roboto(fontSize: 3))),
              ),
              TableCell(
                child: Center(
                    child: Text('Deductions',
                        style: GoogleFonts.roboto(
                            fontSize: 3, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Header',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Paid',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Header',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Paid',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Basic',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.basic ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('EMPLOYEE PF',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.employeePf ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('HRA',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.hra ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('EMPLOYEE ESIC',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.employeeEsic ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('SPECIAL ALLOWANCE',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.specialAllowance ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('EMPLOYEE WELFARE',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.employeeWelfare ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('BONUS/ARREAR',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.bonus ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('PERFORMANCE MONTHLY HOLD',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('OTHER ALLOWANCE',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.otherAllowance ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('SALARY ADVANCE',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.salaryAdvance ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('INCOME TAX',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.incomeTax ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('PENALTY',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('GROSS',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.grossSalary ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('TOTAL DEDUCTION:',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.totalDeduction ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('PERFORMANCE QUARTERLY RELEASED',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('SALARY CREDIT:',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(response?.result?.salaryCredit ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Center(
                      child: Text('PERFORMANCE HOLD-QUARTERLY STATEMENT',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Jan 24',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Feb 24',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Mar 24',
                          style: GoogleFonts.roboto(
                              fontSize: 3, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget atliEmpTaxableEarning(PaySlip? response) {
    return Container(
        height: 200,
        width: 85,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.1, // Adjust the width as needed
          ),
        ),
        child: Column(children: [
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Center(
                    child: Text("Taxable Earnings",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 3.0)),
                  ))
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('BASIC',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(response?.result?.basicAnnually ?? "",
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('HRA',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(response?.result?.offeredBasic ?? "",
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('SPL ALLOW',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(response?.result?.specialAllowance ?? "",
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('OTHER ALLOW',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(response?.result?.otherAllowance ?? "",
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Gross Salary',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.offeredGrossSalary ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Application tax rates: ',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('New Regime',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Deducations',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Standard Deducation',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.standardDeduction ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ProfessionalTax',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.pta ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Pre.Emp.Professional Tax',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Any Other Income',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Chapter VI-A and 80 C',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Taxable Income',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.taxableIncome ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('****Tax Liability',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.incomeTaxLiability ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Tax Rebate u/s 87 A',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.taxRebate_87a ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Sub Total',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.subTotal ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Subcharge',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.surchargeCess ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Cess',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Total Tax',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.totalTax ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Previous Employee Tax',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.previousEmployerTax ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Net Tax',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.netTax ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Tax deduceted till last month',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            response?.result?.taxDeductionTillLastMonth ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Tax to be deducted',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.taxToBeDeduction ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Tax deducation for this month',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            response?.result?.taxDeductionForThisMonth ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Revised Tax/Month',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.revisedTax ?? "",
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
        ]));
  }

  Widget atliEmpDeductionUCVIA(PaySlip? response) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.1, // Adjust the width as needed
          ),
        ),
        height: 170,
        width: 85,
        child: Column(children: [
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Center(
                    child: Text("Deduction U/C VI-A",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 3.0)),
                  ))
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('80 D',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Total Deduction u/c VI-A',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child:
                            Text(response?.result?.totalDeductionUnderViA ?? "",
                                style: GoogleFonts.roboto(
                                  fontSize: 3,
                                ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(' ',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                fontSize: 3,
                              )))),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
          Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Total Other Income',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',
                            style: GoogleFonts.roboto(
                              fontSize: 3,
                            ))),
                  )),
                ]),
              ]),
        ]));
  }

  Widget atliEmpInvestment(PaySlip? response) {
    return Container(
      height: 160,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.1, // Adjust the width as needed
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    // Adjust the color of the border
                    width: 0.2,
                    // Adjust the thickness of the border
                    style: BorderStyle.solid,
                  ),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('Investments',
                                  style: GoogleFonts.roboto(fontSize: 3))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    // Adjust the color of the border
                    width: 0.2,
                    // Adjust the thickness of the border
                    style: BorderStyle.solid,
                  ),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('U/S',
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('80',
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('C',
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('PF+VPF',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(response?.result?.pfVpf ?? "",
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Education Fees',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total Investment u/s 80 C\n',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                              response?.result?.totalInvestmentUnder_80c ?? "",
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget employeeHrs(PaySlip? response) {
    return Container(
      height: 160,
      width: 98,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    // Adjust the color of the border
                    width: 0.2,
                    // Adjust the thickness of the border
                    style: BorderStyle.solid,
                  ),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('HRA Calculation',
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Table(
            columnWidths: {
              0: FixedColumnWidth(100),
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              1: FixedColumnWidth(25),
              2: FlexColumnWidth(1),
              2: FixedColumnWidth(30),
            },
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Rent Paid \nFrom      \n10\n1. ******HRA\n2.Rent 10% Basic\n3.40% of Basic\nLeast of above is exempt.\n',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('\n01/04/2023\n31/03/2024',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Text(response?.result?.rentPaid ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold)),
                              Text(response?.result?.hra ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold)),
                              Text(response?.result?.rent_10Basic ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold)),
                              Text(response?.result?.per_40OfBasic ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold)),
                              Text(response?.result?.leastOfAbove ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 3,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 0.2,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('RFA Calculation',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Rent Paid',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('From',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('To',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Taxable RFA Value',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Furniture Cost',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Taxable Furniture Perk',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('\n',
                              style: GoogleFonts.roboto(
                                  fontSize: 3, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
