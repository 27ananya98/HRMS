import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../api/api_handler.dart';
import '../../model/team_employee.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class CreateTeamTask extends StatefulWidget {
  final Function() callback;

  CreateTeamTask({required this.callback});

  @override
  _CreateTeamTaskState createState() => _CreateTeamTaskState();
}

class _CreateTeamTaskState extends State<CreateTeamTask> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String sProjectName = "";
  String sPriority = "";
  String sStatus = "";
  String sDescription = "";
  bool isProgress = false;
  String? sFileName;
  bool isTimeBound = false;
  bool selectedValue = false;
  late double _distanceToField;
  late TextfieldTagsController _controller;
  List<String> _pickLanguage = <String>[];
  // List<Result> memberList = <Result>[];
  TeamEmployee? responseData ;
  List<int> projectAssignTo = <int>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _EndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
    // Fetch team employees in initState
    _fetchTeamEmployees();
  }
  Future<void> _fetchTeamEmployees() async {
    try {
      final response = await ApiHandler().getTeamEmployee();
      final employeeNames = response.result!.map((element) => element.name.toLowerCase()!).toList().cast<String>();
      setState(() {
        responseData = response;
        _pickLanguage = employeeNames;
      });
    } catch (error) {
      // Handle error
      print('Error fetching team employees: $error');
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
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
                                alignment: Alignment.centerRight,
                                // Aligns the child to the right side
                                child: Container(
                                  width: 26, // Adjust the width as needed
                                  height: 26, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // Half of the height or width for a circular shape
                                    border: Border.all(
                                      color: Colors.grey, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    color: Colors
                                        .white, // Background color of the container
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      color: SColors.rozgarRed,
                                      // Icon color
                                      size:
                                          20, // Adjust the icon size as needed
                                    ),
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Create Project Details',
                                  style: GoogleFonts.roboto(
                                      color: SColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Project name",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            sProjectName =
                                text; // Update the value of _inputText
                          });
                        },
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: SColors.rozgarRed),
                            ),
                            hintText: "Write Description"),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Priority',
                                  style: GoogleFonts.roboto(
                                      color: SColors.grey, fontSize: 14)),
                            ),
                            Container(
                              child: Text('Status',
                                  style: GoogleFonts.roboto(
                                      color: SColors.grey, fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  sPriority = text;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  sStatus = text;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Members of Project/Task Group",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //////////////////////////Tags///////////////////////////////////
                      // Column(
                      //   children: [
                      //     Autocomplete<String>(
                      //       optionsViewBuilder: (context, onSelected, options) {
                      //         return Container(
                      //           margin: const EdgeInsets.symmetric(
                      //               horizontal: 10.0, vertical: 4.0),
                      //           child: Align(
                      //             alignment: Alignment.topCenter,
                      //             child: Material(
                      //               elevation: 4.0,
                      //               child: ConstrainedBox(
                      //                 constraints: const BoxConstraints(maxHeight: 200),
                      //                 child: ListView.builder(
                      //                   shrinkWrap: true,
                      //                   itemCount: options.length,
                      //                   itemBuilder: (BuildContext context, int index) {
                      //                     final dynamic option = options.elementAt(index);
                      //                     return TextButton(
                      //                       onPressed: () {
                      //                         onSelected(option);
                      //                       },
                      //                       child: Align(
                      //                         alignment: Alignment.centerLeft,
                      //                         child: Padding(
                      //                           padding: const EdgeInsets.symmetric(
                      //                               vertical: 15.0),
                      //                           child: Text(
                      //                             '$option',
                      //                             textAlign: TextAlign.left,
                      //                             style: GoogleFonts.roboto(
                      //                                 color: SColors.black,
                      //                                 fontWeight: FontWeight.w500,
                      //                                 fontSize: 14),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       optionsBuilder: (TextEditingValue textEditingValue) {
                      //         if (textEditingValue.text == '') {
                      //           return const Iterable<String>.empty();
                      //         }
                      //         return _pickLanguage.where((String option) {
                      //           return option.contains(textEditingValue.text.toLowerCase());
                      //         });
                      //       },
                      //       onSelected: (String selectedTag) {
                      //         _controller.addTag = selectedTag;
                      //       },
                      //       fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
                      //         return TextFieldTags(
                      //           textEditingController: ttec,
                      //           focusNode: tfn,
                      //           textfieldTagsController: _controller,
                      //           textSeparators: const [' ', ','],
                      //           letterCase: LetterCase.normal,
                      //           validator: (String tag) {
                      //             if (!_pickLanguage.contains(tag.toLowerCase())) {
                      //               return 'Please select a correct employee';
                      //             } else if (_controller.getTags!.contains(tag)) {
                      //               return 'You already entered that';
                      //             }
                      //             return null;
                      //           },
                      //           inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
                      //             return ((context, sc, tags, onTagDelete) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //                 child: TextField(
                      //                   controller: tec,
                      //                   focusNode: fn,
                      //                   decoration: InputDecoration(
                      //                     border: const UnderlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: SColors.rozgarRed,
                      //                           width: 3.0),
                      //                     ),
                      //                     focusedBorder: const UnderlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: SColors.rozgarRed,
                      //                           width: 1.0),
                      //                     ),
                      //                      helperStyle: GoogleFonts.roboto(
                      //                       color: SColors.rozgarRed,
                      //                     ),
                      //                      errorText: error,
                      //                     prefixIconConstraints: BoxConstraints(
                      //                         maxWidth: _distanceToField * 0.74),
                      //                     prefixIcon: tags.isNotEmpty
                      //                         ? SingleChildScrollView(
                      //                       controller: sc,
                      //                       scrollDirection: Axis.horizontal,
                      //                       child: Row(
                      //                         children: tags.map((String tag) {
                      //                           return Container(
                      //                             decoration: const BoxDecoration(
                      //                               borderRadius: BorderRadius.all(
                      //                                 Radius.circular(20.0),
                      //                               ),
                      //                               color:
                      //                               SColors.rozgarRed,
                      //                             ),
                      //                             margin:
                      //                             const EdgeInsets.only(right: 10.0),
                      //                             padding: const EdgeInsets.symmetric(
                      //                                 horizontal: 10.0, vertical: 4.0),
                      //                             child: Row(
                      //                               mainAxisAlignment:
                      //                               MainAxisAlignment.spaceBetween,
                      //                               children: [
                      //                                 InkWell(
                      //                                   child: Text(
                      //                                     '#$tag',
                      //                                     style: GoogleFonts.roboto(
                      //                                         color: Colors.white),
                      //                                   ),
                      //                                   onTap: () {
                      //                                     //print("$tag selected");
                      //                                   },
                      //                                 ),
                      //                                 const SizedBox(width: 4.0),
                      //                                 InkWell(
                      //                                   child: const Icon(
                      //                                     Icons.cancel,
                      //                                     size: 14.0,
                      //                                     color: Color.fromARGB(
                      //                                         255, 233, 233, 233),
                      //                                   ),
                      //                                   onTap: () {
                      //                                     onTagDelete(tag);
                      //                                   },
                      //                                 )
                      //                               ],
                      //                             ),
                      //                           );
                      //                         }).toList(),
                      //                       ),
                      //                     )
                      //                         : null,
                      //                   ),
                      //                   onChanged: onChanged,
                      //                   onSubmitted: onSubmitted,
                      //                 ),
                      //               );
                      //             });
                      //           },
                      //         );
                      //       },
                      //     )
                      //   ],
                      // ),
                      ////////////////////////////////////Tags///////////////////////////////////////////
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Project is time bound?",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<bool>(
                                      value: false,
                                      groupValue: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          isTimeBound = value!;
                                          selectedValue = value;
                                          print(value);
                                        });
                                      },
                                    ),
                                    Text('No'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<bool>(
                                      value: true,
                                      groupValue: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          isTimeBound = value!;
                                          selectedValue = value;
                                        });
                                      },
                                    ),
                                    Text('Yes'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isTimeBound,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Start Date',
                                        style: GoogleFonts.roboto(
                                            color: SColors.grey, fontSize: 14)),
                                  ),
                                  Container(
                                    child: Text('End Date',
                                        style: GoogleFonts.roboto(
                                            color: SColors.grey, fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // Scroll horizontally
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                          child: Text(
                                              '${DateFormat('MMM dd, yyyy').format(startDate)}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  color: Color(0xFF000000))),
                                          onTap: () {
                                            _startDate(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          iconSize: 20,
                                          tooltip: 'Tap to open date picker',
                                          onPressed: () {
                                            _startDate(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                          child: Text(
                                              '${DateFormat('MMM dd, yyyy').format(endDate)}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  color: Color(0xFF000000))),
                                          onTap: () {
                                            _EndDate(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          iconSize: 20,
                                          tooltip: 'Tap to open date picker',
                                          onPressed: () {
                                            _EndDate(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Description",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    color: SColors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              sDescription = text; // Update the value of _inputText
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter text',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(
                              color: SColors.rozgarRed,
                              width: 2,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            elevation: 0,
                            primary: Colors.transparent,
                            onPrimary: SColors.rozgarRed,
                          ),
                          onPressed: () {
                            if (sProjectName.length <2) {
                              Fun.showToast("Please give proper project name");
                              return;
                            }
                            else if (_controller.getTags!.isEmpty){
                              Fun.showToast("Please Select Project Members");
                              return;
                            }
                            else if (sPriority.length<2){
                              Fun.showToast("Please give proper priority");
                              return;
                            }else if (sStatus.length<2){
                              Fun.showToast("Please give proper status");
                              return;
                            }else if (sDescription.length<2){
                              Fun.showToast("Please give proper description");
                              return;
                            }else{
                              Fun.showToast("Submit Successfully");
                              List<int> matchingIds = [];
                              responseData!.result!.forEach((element){
                                if (_controller.getTags!.contains(element.name!.toLowerCase())) {
                                  matchingIds.add(element.id!);
                                }
                              });
                              print(sProjectName);
                              print(sPriority);
                              print(sStatus);
                              print(sDescription);
                              print(matchingIds);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ))),
          ),
          Center(
            child: Visibility(
                visible: isProgress, child: Fun.getLoadingUICircular(context)),
          ),
        ],
      ),
    );
  }
}
