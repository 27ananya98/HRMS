import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms/api/app_url.dart';
import 'package:hrms/model/approval_types.dart';
import 'package:hrms/model/attendance_report_m.dart';
import 'package:hrms/model/family_details.dart';
import 'package:hrms/model/salary_slip_model.dart';
import 'package:hrms/model/shift_type.dart';
import 'package:hrms/utils/fun.dart';
import 'package:hrms/utils/snack.dart';
import '../model/AddExpenseBill.dart';
import '../model/AttendanceType.dart';
import '../model/add_daily_task.dart';
import '../model/add_od_response.dart';
import '../model/announcement.dart';
import '../model/ar_list.dart';
import '../model/assigne_to.dart';
import '../model/check_in_status.dart';
import '../model/comp_off.dart';
import '../model/comp_off_approval_type.dart';
import '../model/comp_off_ddm.dart';
import '../model/company_directory_modal.dart';
import '../model/document_type.dart';
import '../model/edit_basic_details.dart';
import '../model/expense_list.dart';
import '../model/feedback_form_model.dart';
import '../model/feedback_list_model.dart';
import '../model/holidays_list_model.dart';
import '../model/leave_balance.dart';
import '../model/leave_status.dart';
import '../model/leaves_report.dart';
import '../model/pay_slip.dart';
import '../model/profile_name.dart';
import '../model/profile_response.dart';
import '../model/salary_slip_name.dart';
import '../model/task_list.dart';
import '../model/team_ar_report.dart';
import '../model/team_attendance_m.dart';
import '../model/team_comoff_report.dart';
import '../model/team_employee.dart';
import '../model/team_leave_report.dart';
import '../model/team_leave_type.dart';
import '../model/team_task_list.dart';
import '../model/upcoming_birthday.dart';
import '../model/upcoming_event.dart';
import '../model/update_app.dart';
import '../utils/prefsKeys.dart';
import '../utils/shared_preferences.dart';

class ApiHandler {
  static ApiHandler handler = ApiHandler();
  Dio? dio;

  ApiHandler() {
    initDio();
  }

  void initDio() {
    dio = Dio();
    dio!.options
      ..connectTimeout = 60000
      ..receiveTimeout = 60000;
    dio?.interceptors.add(
        LogInterceptor(responseBody: true, error: true, requestBody: true));
  }
  addExpenseBill(formData) async {
    try {
      String sToken = "Bearer ";
      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sUploadBill,
          data: formData,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AddExpenseBill.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }


  getFeedbackList()async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sFeedbackFormList,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return FeedbackListModel.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }

  }

  addFeedback(body)async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(await AppUrl.url.getBaseUrl() + AppUrl.sFeedbackForm,
          data:body,
          options: Options(headers: <String, String>{'Authorization': sToken},));
      return FeedbackFormModel.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getDocumentType()async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sDocumentList,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return DocumentType.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }

  }

  getUpcomingEventList()async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sUpcomingEvent,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return UpcomingEvent.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }


  manageDailyTask(body)async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(await AppUrl.url.getBaseUrl() + AppUrl.sManageTaskStatus,
          data:body,
          options: Options(headers: <String, String>{'Authorization': sToken},));
      return response.data['status'];
    } on DioError catch (e) {
      _handleError(e);
    }
  }


  getTeamTaskList()async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sTeamTaskList,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamTaskList.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }
  getTeamTaskFilterList(String st_date, String end_date) async {
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      var sUserId = jsonMap['result']['EmployeeId'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sTeamTaskFilterListList}?filterEmp=&st_date=$st_date&end_date=$end_date",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamTaskList.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }
  addDailyTask(body)async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(await AppUrl.url.getBaseUrl() + AppUrl.sAddDailyTask,
          data:body,
          options: Options(headers: <String, String>{'Authorization': sToken},));
    return AddDailyTaskModel.fromJson(response.data);
    } on DioError catch (e) {
    _handleError(e);
    }
  }
  updateDailyTask(body)async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(await AppUrl.url.getBaseUrl() + AppUrl.sEditDailyTask,
          data:body,
          options: Options(headers: <String, String>{'Authorization': sToken},));
      return AddDailyTaskModel.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getDailyTask()async{
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sDailyTaskList,
    options: Options(headers: <String, String>{'Authorization': sToken}));
    return TaskList.fromJson(response.data);
    } on DioError catch (e) {
    _handleError(e);
    }
  }
  getPaySlipData(String sMonth, String sYear) async {
    try {
      String sToken = "Bearer ";
      String value = await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      var sUserId = jsonMap['result']['EmployeeId'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sPaySlip}?empId=$sUserId&year=$sYear&month=$sMonth",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return PaySlip.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getCompOffApprovalType()async{
    try {
      String sToken = "Bearer ";
      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sCompoffApprovalType,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return CompOffApprovalType.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }
  getSalarySlip(String sYear, String sMonth) async {
    String sUrl = sYear + "-" + sMonth;
    try {
      String sToken = "Bearer ";
      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sSalarySlip}?date=$sUrl",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return SalarySlipModel.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }
  getTeamLeaveType(leaveId)async{
    try {
      String sToken = "Bearer ";
      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sTeamLeaveType}?id=$leaveId",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamLeaveType.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getTeamAttendanceReport(date) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sTeamAttendance}?d=$date",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamAttendanceReport.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  teamCompOffApproval(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sTeamCompOffApprove,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getTeamCompOffReport(String sYear, String sMonth) async {
    String sUrl = sYear + "-" + sMonth + "-" + "01";
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sTeamCompOff}?dt=$sUrl",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamComoffReport.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  teamArApproval(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sTeamArApprove,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  teamLeaveApproval(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sTeamLeaveApprove,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  forgetPassword(number) async {
    try {
      final Map<String, dynamic> body = {"input": number};
      var isStatus = false;
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sForgetPassword,
          data: body);
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          //  fun.showToast("Mail has been sent with instructions to reset password. Please do the needful.");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getTeamArReport(String sYear, String sMonth) async {
    String sUrl = sYear + "-" + sMonth + "-" + "01";
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sTeamAR}?d=$sUrl",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamArReport.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getTeamLeaveReport(String sYear, String sMonth) async {
    String sUrl = sYear + "-" + sMonth + "-" + "01";
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sTeamLeave}?dt=$sUrl",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return TeamLeaveReport.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getAssigneList() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sAssigneTo,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AssigneTo.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getExpenseList() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sExpenseList}?formId=1",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return ExpenseList.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }
  getSalarySlipName()async{
    try {
      String sToken = "Bearer ";
      String employee_id = "";
      String value =
      await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      employee_id = jsonMap['result']['EmployeeId'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sSalarySlipPdfName}$employee_id",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return SalarySlipName.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addExpense(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddExpense,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addCompOff(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddCompOff,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getCompOffDdm(String sMonth, String sYear) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      var sUserId = jsonMap['result']['id'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sCompOffAttendanceList}?u=$sUserId&y=$sYear&m=$sMonth",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AddCompOffDdm.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getCompOffReportMonthly(String sYear, String sMonth) async {
    String sUrl = sYear + "-" + sMonth + "-" + "01";
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sCompOff}?dt=$sUrl",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return CompOff.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  cancelLeaveRequest(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sCancelLeaveRequest,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getLeaveStatus(id) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sLeaveStatus}?id=$id",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return LeaveStatus.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  editProfilePic(formData) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sUpdateProfilePic,
          data: formData,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getProfileName(sId) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sProfilePic,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      return ProfileName.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  deleteDocumentDetail(String sId) async {
    try {
      String sToken = "Bearer ";
      var isStatus = false;
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.delete(
          await AppUrl.url.getBaseUrl() + AppUrl.sDeleteDocumentDetails + sId,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Delete Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addEducationDetail(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddEducation,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  editAddress(jsonArray) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sEditAddress,
          data: jsonArray,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  deleteFamilyDetail(String sId) async {
    try {
      String sToken = "Bearer ";
      var isStatus = false;
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.delete(
          await AppUrl.url.getBaseUrl() + AppUrl.sDeleteFamilyDetails + sId,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Delete Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addDocument(formData) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      var sUserId = jsonMap['result']['id'];
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddDocument,
          data: formData,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addWorkExp(body) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddWorkExp,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  updateFamilyDetail(
      String sName,
      String id,
      String sRelationship,
      String sContact,
      bool isEmergency,
      String sDob,
      String sEmail,
      bool isDependant) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      var sUserId = jsonMap['result']['id'];
      final Map<String, dynamic> body = {
        "userId": sUserId,
        "id": id,
        "name": sName,
        "relationship": sRelationship,
        "contactNumber": sContact,
        "isEmergencyContact": isEmergency,
        "dateOfBirth": sDob,
        "address": "",
        "email": sEmail,
        "isDependant": isDependant
      };
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sEditFamilyDetailUrl,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addFamilyDetail(String sName, String sRelationship, String sContact,
      bool isEmergency, String sDob, String sEmail, bool isDependant) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      var sUserId = jsonMap['result']['id'];
      final Map<String, dynamic> body = {
        "userId": sUserId,
        "name": sName,
        "relationship": sRelationship,
        "contactNumber": sContact,
        "isEmergencyContact": isEmergency,
        "dateOfBirth": sDob,
        "address": "",
        "email": sEmail,
        "isDependant": isDependant
      };
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sEditFamilyDetailUrl,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          Fun.showToast("Update Successfully");
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed...");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  checkIn(String sDeviceId, String sSource, int iAttendanceTypeId, double dLat,
      double dLng,cameraImage) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      FormData body;
      // final Map<String, dynamic> body = {
      //   'attendanceTypeId': iAttendanceTypeId,
      //   'deviceId': sDeviceId,
      //   'lat': dLat,
      //   'lng': dLng,
      //   'source': sSource,
      // };
      if(cameraImage==null){
        body = FormData.fromMap({
          'attendanceTypeId': iAttendanceTypeId,
          'deviceId': sDeviceId,
          'lat': dLat,
          'lng': dLng,
          'source': sSource,
        });
      }else{
        body = FormData.fromMap({
          'attendanceTypeId': iAttendanceTypeId,
          'deviceId': sDeviceId,
          'lat': dLat,
          'lng': dLng,
          'source': sSource,
          "file": await MultipartFile.fromFile(
            cameraImage.path,
            filename: "img.jpg",
          ),
        });
      }


      // body.forEach((key, value) {
      //   formData.fields.add(MapEntry(key, value.toString()));
      // });
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sTestCheckInUrl,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data['status'];
        String? error = data['error'];
        if (status == true) {
          AppPreferences.shared
              .saveBoolSharedPreferences(PrefsKeys.isCheckInStatus, true);
          isStatus = true;
        } else {
          Fun.showToast(error!);
        }
      } else {
        Fun.showToast("Failed Check-IN");
      }
      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  checkOut(String sDeviceId, String sSource, int iAttendanceTypeId, double dLat,
      double dLng,cameraImage) async {
    try {
      var isStatus = false;
      String sToken = "Bearer ";
      FormData body;
      // final Map<String, dynamic> body = {
      //   'attendanceTypeId': iAttendanceTypeId,
      //   'deviceId': sDeviceId,
      //   'lat': dLat,
      //   'lng': dLng,
      //   'source': sSource,
      // };
      if(cameraImage==null){
        body = FormData.fromMap({
          'attendanceTypeId': iAttendanceTypeId,
          'deviceId': sDeviceId,
          'lat': dLat,
          'lng': dLng,
          'source': sSource,
        });
      }else{
        body = FormData.fromMap({
          'attendanceTypeId': iAttendanceTypeId,
          'deviceId': sDeviceId,
          'lat': dLat,
          'lng': dLng,
          'source': sSource,
          "file": await MultipartFile.fromFile(
            cameraImage.path,
            filename: "img.jpg",
          ),
        });
      }

      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sTestCheckOutUrl,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));

      if (response.statusCode == 200) {
        var data = response.data;
        bool status = data["status"];
        String? result = data["error"];
        if (status == true) {
          AppPreferences.shared
              .saveBoolSharedPreferences(PrefsKeys.isCheckInStatus, true);
          isStatus = true;
        } else {
          Fun.showToast(result!);
        }
      } else {
        throw Exception("Failed Check-IN");
      }

      return isStatus;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getAttendanceReportMonthly(String sMonth, String sYear) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sAttendanceReportMain}?m=$sMonth&y=$sYear",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AttendanceReportM.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getArList(String sMonth, String sYear) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sArList}?p=1&l=20&y=$sYear&m=$sMonth",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return ArList.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getHolidayList(String sYear) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sHoliDaysListMain}?y=$sYear}",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return HolidayListModel.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getCompanyDirectory() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sCompanyDir,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      CompanyDirectoryModal responseData =
          CompanyDirectoryModal.fromJson(response.data);
      String valueSI = json.encode(responseData.result!.list);
      return responseData.result!.list;
    } on DioError catch (e) {
      _handleError(e);
    }
  }
  getTeamEmployee() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sTeamEmployeeDetails,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      TeamEmployee responseData =
      TeamEmployee.fromJson(response.data);
      //String valueSI = json.encode(responseData.result!.list);
      return responseData;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getBirthdayList() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sBirthdayList,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return UpcomingBirthday.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getShiftType() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sShiftList,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      var data = json.decode(response.data);
      return ShiftType.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getLeaveBalance(String id, String p, String l) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sLeaveBalance}?id=$id&p=$p&l=$l",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return LeaveBalance.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getApprovalTypes() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sApprovalTypes,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      var data = json.decode(response.data);
      return ApprovalTypes.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getUpdateApp() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sUpdateApi,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return UpdateApp.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  editBasicDetails(body) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.put(
          await AppUrl.url.getBaseUrl() + AppUrl.sEditBasicDetails,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return EditBasicDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getMonthlyHistory(String sMonth, String sYear) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sAttendanceReportMain}?m=$sMonth&y=$sYear",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      var data = json.decode(response.data);
      return AttendanceReportM.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getMonthlyEmployeeLeave(String year, String month) async {
    String sUrl = year + "-" + month + "-01";
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sLeaveReportMain}?date=$sUrl ",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return MonthlyEmployeeLeaveReport.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getEmployeeDetail(int id) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sEmployeeDetails}?id=$id ",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return ProfileResponse.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getEmployeeDetailJ(int id) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sEmployeeDetails}?id=$id ",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return response;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getFamilyDetail(int id) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          "${await AppUrl.url.getBaseUrl() + AppUrl.sFamilyDetails}+${id.toString()} ",
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return FamilyDetails.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getAnnouncements(BuildContext context) async {
    try {
      AppUrl obj = AppUrl();
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await obj.getBaseUrl() + AppUrl.sAnnouncement,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AnnouncementModal.fromJson(response.data);
    } on DioError catch (e) {
      try{
        if(e.response?.statusCode == 403){
          Fun.showToast("Invalid Token");
          Fun.invalidToken(context);
        }
      }catch (e) {
        print(e);
      }
      _handleError(e);

    }
  }

  addAr(String shiftId, String attendanceTypeId, String attendanceId,
      String inTime, String outTime, String comment) async {
    final body = {
      "shiftId": "$shiftId",
      "attendanceTypeId": "$attendanceTypeId",
      "attendanceId": "$attendanceId",
      "inTime": "$inTime",
      "outTime": "$outTime",
      "comment": "$comment"
    };
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddAr,
          data: body,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AddOdResponse.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  addLeaveRequest(String sStartDate, String sEndDate, String sReason,
      int iLaveTypeId, num sNumberOfDays) async {
    try {
      AppUrl obj = AppUrl();
      String sToken = "Bearer ";
      Map<String, dynamic> requestBody = {
        "endDate": "$sEndDate",
        "leaveTypeId": "$iLaveTypeId",
        "numberOfDays": "$sNumberOfDays",
        "reason": "$sReason",
        "startDate": "$sStartDate",
      };
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await obj.getBaseUrl() + AppUrl.sAddLeaveRequest,
          data: requestBody,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      var data = json.encode(response.data);
      Map<String, dynamic> jsonResponse = json.decode(data);
      var status = jsonResponse['status'];
      var error = jsonResponse['error'];
      if (status.toString() == "true") {
        Fun.showToast("leave applied successfully");
        return true;
      } else {
        Fun.showToast(error.toString());
        return false;
      }
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getAttendanceType() async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sAttendanceType,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      return AttendanceType.fromJson(response.data);
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  getCheckInStatus(BuildContext context) async {
    try {
      String sToken = "Bearer ";
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.get(
          await AppUrl.url.getBaseUrl() + AppUrl.sTestCheckInStatusUrl,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      CheckInStatus responseDate = CheckInStatus.fromJson(response.data);
      if (responseDate.status) {
        AppPreferences.shared.saveSharedPreferences(
            PrefsKeys.sUserLastLoginTime,
            responseDate.result!.inTimeUnix.toString());
      }
      return CheckInStatus.fromJson(response.data);
    } on DioError catch (e) {
      try{
        if(e.response?.statusCode == 403){
          Fun.showToast("Invalid Token");
          Fun.invalidToken(context);
        }
      }catch (e) {
        print(e);
      }
      _handleError(e);
    }
  }

  addAR(String sAttendanceId, String sAttendanceTypeId, String sComment,
      String sInTime, String sOutTime, String sShiftId) async {
    try {
      String sToken = "Bearer ";
      Map<String, dynamic> requestBody = {
        "attendanceId": "$sAttendanceId",
        "attendanceTypeId": "$sAttendanceTypeId",
        "comment": "$sComment",
        "inTime": "$sInTime",
        "outTime": "$sOutTime",
        "shiftId": "$sShiftId"
      };
      String value =
          await AppPreferences.shared.getSharedPreferences(PrefsKeys.sLoging);
      Map<String, dynamic> jsonMap = json.decode(value);
      sToken += jsonMap['result']['token'];
      if (dio == null) initDio();
      final Response response = await dio!.post(
          await AppUrl.url.getBaseUrl() + AppUrl.sAddAR,
          data: requestBody,
          options: Options(headers: <String, String>{'Authorization': sToken}));
      var data = response.data;
      bool status = data['status'];
      String? error = data['error'];
      if (status.toString() == "true") {
        Fun.showToast("Attendance regularization applied successfully");
        return true;
      } else {
        Fun.showToast(error.toString());
        return error;
      }
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  _handleError(DioError e) {
    Snack.show(
        content: e.response!.data!,
        snackType: SnackType.error,
        behavior: SnackBarBehavior.floating);
  }
}
