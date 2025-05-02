import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/model/team_task_list.dart';

import '../../../../../api/api_handler.dart';
import '../../../../../utils/fun.dart';
import '../../../../../utils/prefsKeys.dart';
import '../../../../../utils/shared_preferences.dart';

class TeamController extends GetxController {
  var sFrom = Rxn<DateTime>();
  var sTo = Rxn<DateTime>();
  RxBool isLoading = false.obs;
  Rx<TeamTaskList> teamTaskList = TeamTaskList().obs;
  Rx<TeamTaskList> filteredTaskList = TeamTaskList().obs;
  RxString searchTerm = ''.obs;

  RxBool isSearchVisible = false.obs;
  RxBool isSearchActive = false.obs;
  @override
  void onInit() {
    super.onInit();
    getTeamTaskList(true);
    searchTerm.listen((_) {
      filterTaskList();
    });
  }

  Future<void> selectOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sTo.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != sTo.value) {
      sTo.value = picked;
      if(sFrom.value != null && sTo.value!=null){
        getTeamTaskFilterList(true,DateFormat('yyyy-MM-dd').format(sFrom.value!), DateFormat('yyyy-MM-dd').format(sTo.value!));
      }
    }
  }

  manageTaskStatus(int taskId, String date, bool isApprove, int empId) async {
    DateTime parsedDate = DateFormat('dd MMM yyyy').parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    final Map<String, dynamic> addTask = {
      "empId": empId,
      "task_status": isApprove,
      "task_id": taskId,
      "task_date": formattedDate,
    };

    try {
      isLoading.value = true;
      await ApiHandler().manageDailyTask(addTask);
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      await getTeamTaskList(true);
    } catch (e) {
      Fun.showToast("Technical error: $e");
    } finally {
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      isLoading.value = false;
    }
  }

  Future<void> selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sFrom.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != sFrom.value) {
      sFrom.value = picked;
      if(sFrom.value != null && sTo.value!=null){
        getTeamTaskFilterList(true,DateFormat('yyyy-MM-dd').format(sFrom.value!), DateFormat('yyyy-MM-dd').format(sTo.value!));
      }
    }
  }

  void filterTaskList() {
    if (searchTerm.value.isEmpty) {
      filteredTaskList.value = teamTaskList.value; // No search term, show all
    } else {
      final filteredResults = teamTaskList.value.result?.where((task) {
        return task.name!.toLowerCase().contains(searchTerm.value.toLowerCase());
      }).toList();
      filteredTaskList.value = TeamTaskList(result: filteredResults);
    }
  }

  getTeamTaskList(bool isVisible) async {
    isLoading.value = isVisible;
    try {
      TeamTaskList response = await ApiHandler().getTeamTaskList();
      response.result?.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      teamTaskList.value = response;
      filterTaskList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTeamTaskFilterList(bool isVisible, String st_date, String end_date) async {
    isLoading.value = isVisible;
    try {
      TeamTaskList response = await ApiHandler().getTeamTaskFilterList(st_date, end_date);
      response.result?.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      teamTaskList.value = response;
      filterTaskList();
    } finally {
      isLoading.value = false;
    }
  }
}
