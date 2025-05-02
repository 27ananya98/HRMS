import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:hrms/widget/salary_module/pay_slip_widgets.dart';

import '../../model/pay_slip.dart';
import 'atli_corporate_pay_slip.dart';
import 'atli_emp_pay_slip.dart';
import 'atli_mep_pay_slip.dart';
import 'foxcon_pay_slip.dart';
import 'kk_pay_slip.dart';

class PaySlipTemplates {

  Widget getPaySlipTemplate(PaySlip? response){
    if(response!.status == true){
      if(response.result!.entity == "KK"){
        return kkPaySlip(response);
      }else if(response.result!.entity == "ATLI"){
        return getAtliTemplate(response);
      }else if(response.result!.entity == "ATlI-CORPORATE"){
        return atliCorporatePaySlip(response);
      }else if(response.result!.entity == "FOXCON"){
        return foxConPaySlip(response);
      }else{
        return atliMepPaySlip(response);
      }
    }else{
      return Text("");
    }
  }
  Widget getAtliTemplate(PaySlip? response) {
    return Column(
      children: [
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ValueInnovation Labs Pvt Ltd",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payslip for the month: ${TimeHandler.getFormattedDate(response?.result?.month, response?.result?.year!)}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "Location: ${response?.result?.locName}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        AtliEmpPaySlip().employeeDetail(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpAttendance(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpEarningsDeduction(response),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount in word : ${response?.result?.amountInWords}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bank Name:  ${response?.result?.bank ?? ""}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "A/c No.: ${response?.result?.bankAcc}" ?? "",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 10),
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Income Tax Worksheet for the monthly february 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'April 2023-March 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.2, // Adjust the width as needed
            ),
          ),
          child: Row(
            children: [
              Expanded(child: AtliEmpPaySlip().atliEmpTaxableEarning(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpDeductionUCVIA(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpInvestment(response)),
              Expanded(child: AtliEmpPaySlip().employeeHrs(response)),
            ],
          ),
        )
      ],
    );
  }
  Widget atliCorporatePaySlip(PaySlip? response) {
    return Column(
      children: [
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ValueInnovation Labs Pvt Ltd",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payslip for the month: ${TimeHandler.getFormattedDate(response?.result?.month, response?.result?.year!)}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "Location: ${response?.result?.locName}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        AtliEmpPaySlip().employeeDetail(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpAttendance(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpEarningsDeduction(response),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount in word : ${response?.result?.amountInWords}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bank Name:  ${response?.result?.bank ?? ""}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "A/c No.: ${response?.result?.bankAcc}" ?? "",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 10),
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Income Tax Worksheet for the monthly february 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'April 2023-March 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.2, // Adjust the width as needed
            ),
          ),
          child: Row(
            children: [
              Expanded(child: AtliEmpPaySlip().atliEmpTaxableEarning(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpDeductionUCVIA(response)),
              Expanded(child: AtliCorporatePaySlip().atliEmpInvestment(response)),
              Expanded(child: AtliEmpPaySlip().employeeHrs(response)),
            ],
          ),
        )
      ],
    );
  }
  Widget foxConPaySlip(PaySlip? response) {
    return Column(
      children: [
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ValueInnovation Labs Pvt Ltd",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payslip for the month: ${TimeHandler.getFormattedDate(response?.result?.month, response?.result?.year!)}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "Location: ${response?.result?.locName}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        AtliEmpPaySlip().employeeDetail(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpAttendance(response),
        SizedBox(height: 5),
        FoxConPaySlip().atliEmpEarningsDeduction(response),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount in word : ${response?.result?.amountInWords}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bank Name:  ${response?.result?.bank ?? ""}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
            "A/c No.: ${response?.result?.bankAcc}" ?? "",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 10),
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Income Tax Worksheet for the monthly february 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'April 2023-March 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.2, // Adjust the width as needed
            ),
          ),
          child: Row(
            children: [
              Expanded(child: AtliEmpPaySlip().atliEmpTaxableEarning(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpDeductionUCVIA(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpInvestment(response)),
              Expanded(child: AtliEmpPaySlip().employeeHrs(response)),
            ],
          ),
        )
      ],
    );
  }
  Widget kkPaySlip(PaySlip? response) {
    return Column(
      children: [
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ValueInnovation Labs Pvt Ltd",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payslip for the month: ${TimeHandler.getFormattedDate(response?.result?.month, response?.result?.year!)}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "Location: ${response?.result?.locName}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        AtliEmpPaySlip().employeeDetail(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpAttendance(response),
        SizedBox(height: 5),
        FoxConPaySlip().atliEmpEarningsDeduction(response),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount in word : ${response?.result?.amountInWords}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bank Name:  ${response?.result?.bank ?? ""}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "A/c No.: ${response?.result?.bankAcc}" ?? "",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 10),
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Income Tax Worksheet for the monthly ${TimeHandler.getFormattedDate(response?.result?.month, response?.result?.year!)}',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'April 2023-March 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.2, // Adjust the width as needed
            ),
          ),
          child: Row(
            children: [
              Expanded(child: AtliEmpPaySlip().atliEmpTaxableEarning(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpDeductionUCVIA(response)),
              Expanded(child: KkPaySlip().kkEmpInvestment(response)),
              Expanded(child: AtliEmpPaySlip().employeeHrs(response)),
            ],
          ),
        )
      ],
    );
  }
  Widget atliMepPaySlip(PaySlip? response) {
    return Column(
      children: [
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ValueInnovation Labs Pvt Ltd",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payslip for the month: ${TimeHandler.getFormattedDate(response?.result?.month, response?.result?.year)}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "Location: ${response?.result?.locName}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 5),
        AtliEmpPaySlip().employeeDetail(response),
        SizedBox(height: 5),
        AtliEmpPaySlip().atliEmpAttendance(response),
        SizedBox(height: 5),
        AtliMepPaySlip().atliMepEmpEarningsDeduction(response),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount in word : ${response?.result?.amountInWords}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bank Name:  ${response?.result?.bank ?? ""}",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
            Text(
              "A/c No.: ${response?.result?.bankAcc}" ?? "",
              style: GoogleFonts.roboto(fontSize: 3),
            ),
          ],
        ),
        SizedBox(height: 10),
        PaySlipWidgets().companyLogo(),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Income Tax Worksheet for the monthly february 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'April 2023-March 2024',
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 3.0),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.2, // Adjust the width as needed
            ),
          ),
          child: Row(
            children: [
              Expanded(child: AtliEmpPaySlip().atliEmpTaxableEarning(response)),
              Expanded(child: AtliEmpPaySlip().atliEmpDeductionUCVIA(response)),
              Expanded(child: AtliCorporatePaySlip().atliEmpInvestment(response)),
              Expanded(child: AtliEmpPaySlip().employeeHrs(response)),
            ],
          ),
        )
      ],
    );
  }

}
