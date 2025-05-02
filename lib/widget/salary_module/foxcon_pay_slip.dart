import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/pay_slip.dart';
class FoxConPaySlip{
  Widget atliEmpEarningsDeduction(PaySlip? response){
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
                        style: GoogleFonts.roboto(
                            fontSize: 3))),
              ),
              TableCell(
                child: Center(
                    child: Text('Deductions',
                        style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('Header',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('Paid',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('Header',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('Paid',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('Basic Salary',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.basic ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('EMPLOYEE PF',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.employeePf ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('HRA',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.hra ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('EMPLOYEE ESIC',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.employeeEsic ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          'SPECIAL ALLOWANCE',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.specialAllowance ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          'EMPLOYEE WELFARE',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.employeeWelfare ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('BONUS/ARREAR',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.bonus ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          'PERFORMANCE MONTHLY HOLD',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('OTHER ALLOWANCE',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.otherAllowance ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('SALARY ADVANCE',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.salaryAdvance ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('INCOME TAX',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.incomeTax ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('PT',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text("",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          '',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text("",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text("",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          '',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.totalDeduction ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('GROSS',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.grossSalary ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          'TOTAL DEDUCTION:',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.totalDeduction ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
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
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text('',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text("",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                          'Salary Credited',
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0),
                  child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: Text(response?.result?.salaryCredit ?? "",
                          style: GoogleFonts.roboto(
                              fontSize: 3,
                              fontWeight: FontWeight
                                  .bold))),
                ),
              ),
            ],
          ),
        ],
      ),

    ]);
  }
 }