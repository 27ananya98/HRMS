import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/pay_slip.dart';
class AtliCorporatePaySlip{
  Widget atliEmpInvestment(PaySlip? response){
    return Container(
      height: 160,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.1, // Adjust the width as needed
        ),
      ),
      child: Column(children: [
        Row( children: [
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
                          child: Text(
                              'Investments',
                              style: GoogleFonts.roboto(
                                  fontSize: 3)
                          )),
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
                                  fontWeight:
                                  FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('80',
                              style: GoogleFonts.roboto(
                                  fontSize: 3,
                                  fontWeight:
                                  FontWeight.bold))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text('C',
                              style: GoogleFonts.roboto(
                                  fontSize: 3,
                                  fontWeight:
                                  FontWeight.bold))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],),
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
                        child: Text('PF+VPF',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.pfVpf ?? "",style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('LIC',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('Mutual Fund ',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
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
                        child: Text('Total Investment u/s 80 C\n',style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(response?.result?.totalInvestmentUnder_80c ?? "",style: GoogleFonts.roboto(
                            fontSize: 3,
                            fontWeight:
                            FontWeight.bold))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],),
    );
  }
}
