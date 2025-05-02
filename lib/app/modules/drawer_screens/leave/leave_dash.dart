import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';

import '../../../../model/leave_balance.dart';
import '../../../../utils/fun.dart';
import '../../../../utils/prefsKeys.dart';
import '../../../../utils/s_colors.dart';
import '../../../../utils/shared_preferences.dart';
import 'leave_dialog.dart';

class LeaveDash extends StatefulWidget {
  @override
  _LeaveDashState createState() => _LeaveDashState();
}

class _LeaveDashState extends State<LeaveDash>
    with AutomaticKeepAliveClientMixin<LeaveDash> {
  Future<LeaveBalance>? myFuture;

  @override
  void initState() {
    super.initState();
    Fun.customLogEvent("leave_dash");
    setState(() {
      myFuture = listLeaveBalance();
    });
  }

  // getLeaveBalance() {
  //   ApiHandler().getLeaveBalance(853, 1, 50).then((value) => {
  //         setState(() {
  //           String jsonString = json.encode(value);
  //           print(jsonString);
  //         })
  //       });
  // }

  Future<LeaveBalance> listLeaveBalance() async {
    String value =
        await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
    Map<String, dynamic> jsonMap = json.decode(value);
    var id = jsonMap['result']['id'];
    String idString = id.toString();
    LeaveBalance response =
        await ApiHandler().getLeaveBalance(idString, "1", "50");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: FutureBuilder<LeaveBalance>(
        future: myFuture,
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as LeaveBalance;

            return Column(
              children: [
                Container(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items == null
                          ? 0
                          : items.result?.leaveTypeList?.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Positioned(
                                  // top: 20, // Adjust the position according to your preference
                                  // left: 20, // Adjust the position according to your preference
                                  child: Container(
                                    height: 140,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //border: Border.all(color: Colors.black),
                                      color: Colors.white, //

                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ], // Set the color you want for your rounded rectangle
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Total",
                                                style: GoogleFonts.roboto(),
                                              )),
                                              Text(
                                                "Taken",
                                                style: GoogleFonts.roboto(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      (items
                                                              .result
                                                              ?.leaveTypeList![
                                                                  index]
                                                              .total)
                                                          .toString(),
                                                    style: GoogleFonts.roboto(
                                                        color: SColors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),

                                                  )),
                                              Text(
                                                  (items
                                                          .result
                                                          ?.leaveTypeList![
                                                              index]
                                                          .used)
                                                      .toString(),
                                                style: GoogleFonts.roboto(
                                                    color: SColors.rozgarRed,
                                                    fontWeight: FontWeight.bold,),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text(
                                            (double.parse(items
                                                            .result
                                                            ?.leaveTypeList![
                                                                index]
                                                            .total
                                                            ?.toString() ??
                                                        "0") -
                                                    double.parse(items
                                                            .result
                                                            ?.leaveTypeList![
                                                                index]
                                                            .used
                                                            ?.toString() ??
                                                        "0"))
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                color: SColors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 32),

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 130,
                                  // Adjust the position according to your preference
                                  left: 10,
                                  // Adjust the position according to your preference
                                  child: Container(
                                      height: 20,
                                      width: 130,
                                      //padding: EdgeInsets.only(top:10),
                                      // margin: EdgeInsets.only(bottom: 10),
                                      margin: EdgeInsets.only(bottom: 20),
                                      // margin: EdgeInsets.all(10)
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.grey),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                        //
                                        // Set the radius value according to your preference
                                        color: Colors
                                            .white, // Set the color you want for your rounded rectangle
                                      ),
                                      child: Center(
                                          child: Text(
                                              (items
                                                      .result
                                                      ?.leaveTypeList![index]
                                                      .name)
                                                  .toString()
                                                  .substring(
                                                      0,
                                                      (items
                                                                      .result
                                                                      ?.leaveTypeList![
                                                                          index]
                                                                      .name)
                                                                  .toString()
                                                                  .length <
                                                              16
                                                          ? (items
                                                                  .result
                                                                  ?.leaveTypeList![
                                                                      index]
                                                                  .name)
                                                              .toString()
                                                              .length
                                                          : 16),
                                              style: GoogleFonts.roboto(fontSize: 12)))),
                                ),
                              ],
                            ));
                      }),
                ),
                Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/img_comp_off.png'),
                    )),
                ElevatedButton(
                  onPressed: () => {
                    // fun.showToast("Coming Soon...")

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LeaveDiaolg(myFuture!);
                      },
                    )
                  },
                  child: Text(
                    "Apply Leave",
                    style: GoogleFonts.roboto(
                        color: SColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),

                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(SColors.rozgarRed),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive =>
      true; // Return true to keep the state of this page widget alive.
}
