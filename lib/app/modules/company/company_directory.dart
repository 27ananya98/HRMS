import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../api/api_handler.dart';
import '../../../model/company_directory_modal.dart';
import '../../../utils/s_colors.dart';
import '../../../widget/cards/company_dir_card.dart';


class CompanyDirectory extends StatefulWidget {
  @override
  _CompanyDirectoryState createState() => _CompanyDirectoryState();
}

class _CompanyDirectoryState extends State<CompanyDirectory> {
  late Future<List<AllEmpList>?> responseData;
  late Future<List<AllEmpList>?> searchingList;
  List<AllEmpList>? lsCompanyDir;

  String message = 'Welcome to the company directory!';

  @override
  void initState() {
    super.initState();
    responseData = getCompanyDirectory() as Future<List<AllEmpList>?>;
    searchingList = responseData;
  }

  Future<List<AllEmpList>> getCompanyDirectory() async {
    return await ApiHandler().getCompanyDirectory();
  }

    Future<List<AllEmpList>> getSearchList(searchingList) async {
    return await searchingList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SColors.rozgarRed,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Company Directory',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: SColors.white,
                  fontSize: 18)),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        responseData = getSearchList(searchingList).then((itemList) {
                          return itemList!
                              .where((item) => item.name
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )),
              Expanded(
                  child: FutureBuilder(
                future: responseData,
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as List<AllEmpList>;
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),

                      //  width: 80.0,
                      //             height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return getCompanyDirCard(items, index);
                          }),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(SColors.rozgarRed),
                    ));
                  }
                },
              ))
            ],
          ),
        ));
  }
}
