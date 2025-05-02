import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/api/api_handler.dart';
import 'package:hrms/model/holidays_list_model.dart';
import 'package:intl/intl.dart';

import '../../../utils/s_colors.dart';
import '../../../utils/time_handler.dart';
import '../../../widget/progress_dialog.dart';

class HolidayList extends StatefulWidget {
  @override
  _HolidayListState createState() => _HolidayListState();
}

class _HolidayListState extends State<HolidayList> {
  String message = 'Welcome to the company directory!';
  Future<HolidayListModel>? future;
  late int selectedYear;
  bool loading = false;
  String sDate = "--";
  String sName = "--";
  String sType = "--";
  bool isListEmpty = false;
  bool isHolidayListEmpty = false;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    future = getHolidayLists(selectedYear);
  }

  Future<HolidayListModel> getHolidayLists(year) async {
    setState(() {
      loading = true;
    });
    List<String> holidayList = <String>[];
    HolidayListModel response =
        await ApiHandler().getHolidayList(year.toString());
    if (response.result != null) {
      response.result!.forEach((element) {
        holidayList.add(element.date!);
      });
      DateTime currentDate = DateTime.now();

      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      final latestDate = findUpcomingDate(holidayList, formattedDate);
      response.result!.forEach((element) {
        if (element.date.toString() == latestDate.toString()) {
          setState(() {
            sDate = TimeHandler.convertDate(element.date!);
            sName = element.name!;
            sType = element.holidayTypeName!;
          });
        }
      });
    }
    if (response.result!.isEmpty) {
      setState(() {
        isListEmpty = false;
        isHolidayListEmpty = true;
      });
    } else {
      setState(() {
        isListEmpty = true;
        isHolidayListEmpty = false;
      });
    }
    setState(() {
      loading = false;
    });
    return response;
  }

  String findUpcomingDate(List<String> dateList, String selectedDate) {
    DateTime selectedDateTime = DateTime.parse(selectedDate);
    DateTime upcomingDateTime =
        DateTime(3000); // Set a high future year initially
    String upcomingDate = "";
    for (String dateString in dateList) {
      DateTime date = DateTime.parse(dateString);
      if (date.isAfter(selectedDateTime) && date.isBefore(upcomingDateTime)) {
        upcomingDateTime = date;
        upcomingDate = date
            .toLocal()
            .toString()
            .substring(0, 10); // Convert to a localized string
      }
    }
    return upcomingDate;
  }

  Widget getHolidayType(text) {
    if (text == "Fixed Holiday") {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: SColors.rozgarRed,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 1), // Offset of the shadow
            ),
          ],
          borderRadius: BorderRadius.circular(
              5.0), // Adjust the radius for rounded corners
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 12),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: SColors.rozgarRed,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 1), // Offset of the shadow
            ),
          ],
          borderRadius: BorderRadius.circular(
              5.0), // Adjust the radius for rounded corners
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 12),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SColors.rozgarRed,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Holiday List',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: SColors.white,
                  fontSize: 18)),
        ),
        body: ProgressDialog(
            loading: loading,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            'Next Holiday',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: SColors.black,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: DropdownButton<int>(
                        value: selectedYear,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                            future = getHolidayLists(selectedYear);
                          });
                        },
                        items: List.generate(5, (index) {
                          return DropdownMenuItem<int>(
                            value: 2021 + index,
                            child: Text((2021 + index).toString()),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/vector_holiday_list.png'),
                      // Replace with your image path
                      fit: BoxFit
                          .cover, // You can change the BoxFit as per your requirement
                    ),
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 0.2, // Border width
                    ),
                  ),
                  child: Center(
                      child: ListTile(
                    title: Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(sDate,
                            style: GoogleFonts.roboto(
                                color: SColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18))),
                    subtitle: Text(sName,
                        style: GoogleFonts.roboto(
                            color: SColors.white, fontSize: 14)),
                    trailing: Text(sType,
                        style: GoogleFonts.roboto(
                            color: SColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  )),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Visibility(
                          visible: isListEmpty,
                          child: FutureBuilder<HolidayListModel>(
                            future: future,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final holidays = snapshot.data!;
                                return ListView.builder(
                                  itemCount: holidays.result!.length,
                                  itemBuilder: (context, index) {
                                    final holiday = holidays.result![index];
                                    return Container(
                                      height: 120,
                                      margin: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Divider(
                                            color: Colors.black,
                                            // Color of the horizontal line
                                            thickness:
                                                1.0, // Thickness of the horizontal line
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // Align items to both ends
                                            children: [
                                              // Item on the left
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      TimeHandler.convertDate(
                                                          holiday.date
                                                              .toString()),
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Container(
                                                      width: 1.0,
                                                      // Width of the vertical line
                                                      color: Colors.black,
                                                      // Color of the vertical line
                                                      height: double
                                                          .infinity, // Set the height to cover the full vertical space
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      holiday.name.toString(),
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  getHolidayType(holiday
                                                      .holidayTypeName
                                                      .toString()),
                                                ],
                                              )
                                            ],
                                          )),
                                          Divider(
                                            color: Colors.black,
                                            // Color of the horizontal line
                                            thickness:
                                                1.0, // Thickness of the horizontal line
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center(child: Text('${snapshot.error}'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      SColors.rozgarRed),
                                ));
                              }
                            },
                          )),
                      Visibility(
                        visible: isHolidayListEmpty,
                        child: Center(child: Text("Holidays List Not Found.")),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
