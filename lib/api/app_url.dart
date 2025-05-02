import 'package:hrms/utils/prefsKeys.dart';
import 'package:hrms/utils/shared_preferences.dart';

class AppUrl {
  static AppUrl url = AppUrl();
  static const String sTestURL = 'https://mtcapi.rozgarhrms.com';
  static const String aBaseURL = 'https://hrms-orgapi.rozgar.com';

  getBaseUrl() async {
    String value = await await AppPreferences.shared
        .getSharedPreferencesWithDefaultValue(PrefsKeys.sTestUrl, aBaseURL);
    return value;
  }
  static const String sTeamLeaveType= "/v1/leave/detail";
  static const String sCompoffApprovalType = "/v1/leave-type/approval-based";
  static const String sSalarySlip= "/v1/pay-slip";
  static const String sDownloadDoc= "/document/mtc";
  static const String sTeamEmployeeDetails= "/v1/employee/all";
  static const String sTeamCompOffApprove = "/v1/comp-off/comment";
  static const String sTeamAttendance = "/v1/attendance/daily-team-history";
  static const String sTeamCompOff = "/v1/comp-off/team";
  static const String sTeamAR = "/v1/ar/team";
  static const String sTeamArApprove = "/v1/ar/comment";
  static const String sTeamLeaveApprove = "/v1/leave/update-status";
  static const String sForgetPassword = "/v1/password/forget";
  static const String sTeamLeave = "/v1/leave/team-monthly";
  static const String sAddDocument = "/v1/employee/document";
  static const String sAssigneTo = "/v1/employee/active";
  static const String sAddExpense = "/v1/add-expense";
  static const String sCompOff = "/v1/comp-off/list";
  static const String sExpenseList = "/v1/expense/list";
  static const String sAddCompOff = "/v1/comp-off/add";
  static const String sLeaveStatus = "/v1/leave/detail";
  static const String sCancelLeaveRequest = "/v1/leave/request-cancellation";
  static const String sProfilePic = "/v1/employee/getProfilePic";
  static const String sUpdateProfilePic = "/v1/employee/profile-picture";
  static const String sEditAddress = "/v1/employee/address";
  static const String sDeleteFamilyDetails = "/v1/employee/family/";
  static const String sDeleteDocumentDetails = "/v1/employee/document/";
  static const String sAddWorkExp = "/v1/employee/experience";
  static const String sAddEducation = "/v1/employee/education";
  static const String sAnnouncement = "/v1/announcement/available";
  static const String sAttendanceType = "/v1/attendance-type/all";
  static const String sLogin = "/v1/auth/login";
  static const String sAddLeaveRequest = "/v1/leave/apply";
  static const String sAddAR = "/v1/ar/add";
  static const String sTestCheckInUrl = "/v1/attendance/check-in";
  static const String sEditFamilyDetailUrl = "/v1/employee/family";
  static const String sTestCheckOutUrl = "/v1/attendance/check-out";
  static const String sTestCheckInStatusUrl = "/v1/attendance/check-in";
  static const String sCompOffAttendanceList =
      '/v1/attendance/monthly-employee-history';
  static const String sAttendanceReportMain =
      '/v1/attendance/monthly-personal-history';
  static const String sLeaveReportMain = "/v1/leave/employee-monthly";
  static const String sHoliDaysListMain = "/v1/company-calendar/holiday";
  static const String sArList = "/v1/ar/list";
  static const String sShiftList = "/v1/shift-type/available";
  static const String sApprovalTypes = "/v1/leave-type/approval-based";
  static const String sCompanyDir = "/v1/employee/directory";
  static const String sBirthdayList = "/v1/company-calendar/birthday";
  static const String sAddAr = "/v1/ar/add";
  static const String sLeaveBalance = "/v1/leave-balance/detail";
  static const String sEmployeeDetails = "/v1/employee/detail";
  static const String sEditBasicDetails = "/v1/employee/basic";
  static const String sFamilyDetails = "/v1/employee/family/";
  static const String sUpdateApi = "/v1/latest-version";
  static const String sSalarySlipPdfName = "/v1/salary-slip-pdf/";
  static const String sPaySlip = "/v1/get-employee-last-month-salary-slip";
  static const String sAddDailyTask = "/v1/nt/add-daily-task";
  static const String sEditDailyTask = "/v1/nt/update-daily-task-employee";
  static const String sDailyTaskList = "/v1/nt/task_list_employee";
  static const String sTeamTaskList = "/v1/nt/task_list_team";
  static const String sManageTaskStatus = "/v1/nt/update_task_status_manager";
  static const String sUpcomingEvent = "/v1/event/event_list";
  static const String sDocumentList = "/v1/document-type/available";
  static const String sFeedbackForm = "/v1/nemp/feed";
  static const String sFeedbackFormList = "/v1/nemp/addedFeed";
  static const String sUploadBill = "/v1/expense/upload-bill";
  static const String sTeamTaskFilterListList = "/v1/nt/taskList_team";
}
