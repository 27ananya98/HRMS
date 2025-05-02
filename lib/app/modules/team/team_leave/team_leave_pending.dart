import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/utils/screen_widget.dart';
import 'package:hrms/utils/time_handler.dart';
import 'package:intl/intl.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../model/team_leave_report.dart';
import '../../../../../widget/cards/team_leave_card.dart';
import '../../../../../widget/progress_dialog.dart';

class TeamLeavePending extends StatefulWidget {
  @override
  _ReoprtPageState createState() => _ReoprtPageState();
}

class _ReoprtPageState extends State<TeamLeavePending>
    with AutomaticKeepAliveClientMixin<TeamLeavePending> {
  String sMonthName = "00";
  int daysInMonth = 0;
  late DateTime currentDate;
  bool loading = false;
  bool isEmpty = false;
  Future<TeamLeaveReport>? _myFuture;
  TextEditingController searchController = TextEditingController();
  List<Pending> filteredItems = [];
  TeamLeaveReport? myList;

  void startProgress() {
    setState(() {
      loading = true;
    });
    Future.delayed(Duration(seconds: 6), () {
      stopProgress();
    });
  }

  void stopProgress() {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    setState(() {
      sMonthName = TimeHandler.sMonthYear(currentDate);
      daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    });
    updatePendingRequest();
  }

  void onSearchChanged(String value) {
    String searchTerm = value.toLowerCase();
    setState(() {
      filteredItems = myList?.result!.pending
              ?.where((item) =>
                  item.createdByName!.toLowerCase().contains(searchTerm))
              .toList() ??
          [];
    });
  }

  updatePendingRequest() {
    _myFuture = monthlyTeamEmployeeLeave(
        DateFormat('yyyy').format(currentDate).toString(),
        DateFormat('MM').format(currentDate).toString());
  }

  updateLoading(value) {
    setState(() {
      loading = value;
    });
  }

  Future<TeamLeaveReport> monthlyTeamEmployeeLeave(
      String sYear, String sMonth) async {
    TeamLeaveReport response =
        await ApiHandler().getTeamLeaveReport(sYear, sMonth);
    if (response.result!.others!.isEmpty && response.result!.pending!.isEmpty) {
      setState(() {
        isEmpty = true;
      });
    } else {
      myList = response;
      setState(() {
        filteredItems = myList!.result!.pending!;
      });
    }
    stopProgress();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loading: loading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenWidget.disBetween(10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        startProgress();
                        setState(() {
                          sMonthName = TimeHandler.sMonthYear(
                              TimeHandler.getLastMonth(currentDate));
                          daysInMonth = DateTime(
                                  TimeHandler.getLastMonth(currentDate).year,
                                  TimeHandler.getLastMonth(currentDate).month +
                                      1,
                                  0)
                              .day;
                          String sLastMonth = DateFormat('MM')
                              .format(TimeHandler.getLastMonth(currentDate));
                          String sLastYear = DateFormat('yyyy')
                              .format(TimeHandler.getLastMonth(currentDate));
                          setState(() => _myFuture =
                              monthlyTeamEmployeeLeave(sLastYear, sLastMonth));

                          currentDate = TimeHandler.getLastMonth(currentDate);
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 90.0),
                          child: const FaIcon(
                            FontAwesomeIcons.angleLeft,
                            // Define the icon you want to use
                            color: Colors.black,
                            size: 30, // Customize the color
                          ))),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(sMonthName,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            //fontStyle: FontStyle.italic,
                          )),
                      Text("$daysInMonth Days",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            //fontStyle: FontStyle.italic,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        startProgress();
                        setState(() {
                          sMonthName = TimeHandler.sMonthYear(
                              TimeHandler.getNextMonth(currentDate));
                          daysInMonth = DateTime(
                                  TimeHandler.getNextMonth(currentDate).year,
                                  TimeHandler.getNextMonth(currentDate).month +
                                      1,
                                  0)
                              .day;
                          String sLastMonth = DateFormat('MM')
                              .format(TimeHandler.getNextMonth(currentDate));
                          String sLastYear = DateFormat('yyyy')
                              .format(TimeHandler.getNextMonth(currentDate));
                          setState(() => _myFuture =
                              monthlyTeamEmployeeLeave(sLastYear, sLastMonth));
                          currentDate = TimeHandler.getNextMonth(currentDate);
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 30.0),
                          child: const FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Colors.black,
                            size: 30, // Customize the color
                          ))),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search by name...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200], // Change the background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0), // Adjust the border radius
                      borderSide: BorderSide.none, // Hide the border side
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Adjust the content padding
                    suffixIcon: searchController.text.isNotEmpty ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear(); // Clear the search text
                        onSearchChanged(''); // Trigger the search method with an empty string
                      },
                    ) : null, // Show clear button only when the search text is not empty
                  ),
                ),
              ),
              Visibility(
                visible: isEmpty,
                child: Column(
                  children: [
                    Container(
                        width: 250,
                        height: 250,
                        alignment: Alignment.center,
                        child: const Image(
                          image: AssetImage('assets/images/img_comp_off.png'),
                        )),
                    Container(
                      alignment: Alignment.center,
                      child: Text("No Record Found",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16)),
                    ),
                  ],
                ),
              ),
              FutureBuilder<TeamLeaveReport>(
                future: _myFuture,
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as TeamLeaveReport;
                    var updatedReport = TeamLeaveReport(
                      status: items.status,
                      result: Result(
                        pending: filteredItems,
                        others: items.result?.others,
                        other: items.result?.other,
                        watchers: items.result?.watchers,
                      ),
                      error: items.error,
                      version: items.version,
                    );

                    return Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredItems == null
                                ? 0
                                : filteredItems.length,
                            itemBuilder: (context, index) {
                              String sRequestID =
                                  filteredItems[index].id.toString();
                              String createOn = TimeHandler.getDateFromUnix(
                                  filteredItems[index].createdOn.toString());
                              String createdByName =
                                  filteredItems[index].createdByName.toString();
                              String modifiedByName = filteredItems[index]
                                  .modifiedByName
                                  .toString();
                              int? leaveStatusId =
                                  filteredItems[index].leaveStatusId;
                              String numberOfDays =
                                  filteredItems[index].numberOfDays.toString();
                              String startDate = TimeHandler.convertDate(
                                  TimeHandler.getDateFromUnix(items
                                      .result!.pending![index].startDate
                                      .toString()
                                      .substring(0, 10)));
                              String endDate = TimeHandler.convertDate(
                                  TimeHandler.getDateFromUnix(items
                                      .result!.pending![index].endDate
                                      .toString()
                                      .substring(0, 10)));
                              String leaveTypeName =
                                  filteredItems[index].leaveTypeName.toString();
                              String assignedToName = filteredItems[index]
                                  .assignedToName
                                  .toString();
                              bool? isPending = filteredItems[index].pending;
                              int? cancellationRequestedBy = items.result!
                                  .pending![index].cancellationRequestedBy;
                              String reason =
                                  filteredItems[index].reason.toString();
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  print(GestureDetector);
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: TeamLeaveRequests
                                    .teamLeavePendingRequestCard(
                                        context,
                                        isPending,
                                        createdByName,
                                        "LEREQ" + sRequestID,
                                        leaveStatusId,
                                        numberOfDays,
                                        startDate + " - " + endDate,
                                        createOn,
                                        leaveTypeName,
                                        assignedToName,
                                        cancellationRequestedBy,
                                        modifiedByName,
                                        reason,
                                        sRequestID,
                                        updatePendingRequest,
                                        updateLoading),
                              );
                            }),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
