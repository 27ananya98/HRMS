import 'package:get/get.dart';
import 'package:hrms/app/modules/download_salary_slip/bindings/salary_slip_binding.dart';
import 'package:hrms/app/modules/download_salary_slip/views/salary_slip_view.dart';
import 'package:hrms/app/modules/feedback/bindings/feedback_binding.dart';
import 'package:hrms/app/modules/feedback/views/feedback_view.dart';
import 'package:hrms/app/modules/upcoming_event/bindings/event_binding.dart';
import 'package:hrms/app/modules/upcoming_event/view/event_view.dart';

import '../app/feedback_list/bindings/feedback_list_binding.dart';
import '../app/feedback_list/views/feedback_list_view.dart';
import '../app/modules/company/company_directory.dart';
import '../app/modules/company/holiday_list.dart';
import '../app/modules/download_pay_slip/bindings/pay_slip_binding.dart';
import '../app/modules/download_pay_slip/views/pay_slip_view.dart';
import '../app/modules/drawer_screens/attendance.dart';
import '../app/modules/drawer_screens/attendance/dashboard.dart';
import '../app/modules/drawer_screens/attendance/regularization.dart';
import '../app/modules/drawer_screens/attendance/report.dart';
import '../app/modules/drawer_screens/comp_off.dart';
import '../app/modules/drawer_screens/expense.dart';
import '../app/modules/drawer_screens/leave.dart';
import '../app/modules/drawer_screens/leave/holiday_page.dart';
import '../app/modules/drawer_screens/leave/leave_dash.dart';
import '../app/modules/drawer_screens/leave/leave_request.dart';
import '../app/modules/drawer_screens/my_task.dart';
import '../app/modules/drawer_screens/salary_slip.dart';
import '../app/modules/emp_home_pages/bindings/emp_home_binding.dart';
import '../app/modules/emp_home_pages/views/emp_home_view.dart';
import '../app/modules/employee/profile.dart';
import '../app/modules/home/bindings/home_binding.dart';
import '../app/modules/home/views/home_view.dart';
import '../app/modules/login/views/login_view.dart';
import '../app/modules/mng_home_pages/bindings/mang_home_binding.dart';
import '../app/modules/mng_home_pages/views/mang_home_view.dart';
import '../app/modules/my_location/bindings/my_location_binding.dart';
import '../app/modules/my_location/views/my_location_view.dart';
import '../app/modules/splash/bindings/splash_binding.dart';
import '../app/modules/splash/views/splash_view.dart';
import '../app/modules/team/create_task_project/bindings/team_binding.dart';
import '../app/modules/team/create_task_project/views/team_view.dart';
import '../app/modules/upcoming_birthdays/bindings/upcoming_birthday_binding.dart';
import '../app/modules/upcoming_birthdays/views/upcoming_birthday_view.dart';
import '../drawer_handler.dart';
import 'get_routes.dart';

class GetAppRoute {
  List<GetPage> getRoutes() {
    return [
      GetPage(
        name: AppRoute.initial,
        page: () => SplashView(),
        binding: SplashBinding(),
       ),
      GetPage(
        name: AppRoute.homeView,
        page: () => HomeView(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: AppRoute.loginView,
        page: () => LoginView(),
      ),
      GetPage(
          name: AppRoute.mangHomeView,
          page: () => MangHomeView(),
          binding: MangHomeBinding(),
          transition: Transition.zoom),
      GetPage(
          name: AppRoute.empHomeView,
          page: () => EmpHomeView(),
          binding: EmpHomeBinding(),
          transition: Transition.zoom),
      GetPage(
          name: AppRoute.teamView,
          page: () => TeamView(),
          binding: TeamBinding(),
          transition: Transition.zoom),
      GetPage(
        name: AppRoute.drawerHandler,
        page: () => DrawerHandler(),
      ),
      GetPage(
        name: AppRoute.dashboard,
        page: () => Dashboard(),
      ),
      GetPage(
        name: AppRoute.regularization,
        page: () => Regularization(),
      ),
      // GetPage(
      //   name: AppRoute.regularizationDialog,
      //   page: () => RegularizationDialog(),
      // ),
      GetPage(
        name: AppRoute.report,
        page: () => Report(),
      ),
      GetPage(
        name: AppRoute.holidayList,
        page: () => HolidayPage(),
      ),
      GetPage(
        name: AppRoute.leaveDash,
        page: () => LeaveDash(),
      ),
      GetPage(
        name: AppRoute.leaveRequest,
        page: () => LeaveRequest(),
      ),
      GetPage(
        name: AppRoute.attendance,
        page: () => Attendance(),
      ),
      GetPage(
        name: AppRoute.compOff,
        page: () => CompOff(),
      ),
      GetPage(
        name: AppRoute.expense,
        page: () => Expense(),
      ),
      GetPage(
        name: AppRoute.leave,
        page: () => Leave(),
      ),
      GetPage(
        name: AppRoute.myTask,
        page: () => MyTask(),
      ), GetPage(
        name: AppRoute.salarySlip,
        page: () => SalarySlip(),
      ),
      GetPage(
        name: AppRoute.companyDirectory,
        page: () => CompanyDirectory(),
      ),
      GetPage(
        name: AppRoute.holidayListH,
        page: () => HolidayList(),
      ),
      GetPage(
        name: AppRoute.profile,
        page: () => Profile(),
      ),
      GetPage(
        name: AppRoute.downloadSalarySlip,
        page: () => SalarySlipView(),
        binding: SalarySlipBinding(),
      ) ,GetPage(
        name: AppRoute.downloadPaySlip,
        page: () => PaySlipView(),
        binding: PaySlipBinding(),
      ),GetPage(
        name: AppRoute.event,
        page: () => EventView(),
        binding: EventBinding(),
      ),GetPage(
        name: AppRoute.feedback,
        page: () => FeedbackView(),
        binding: FeedbackBinding(),
      ),GetPage(
        name: AppRoute.feedbackList,
        page: () => FeedbackListView(),
        binding: FeedbackListBinding(),
      ),GetPage(
        name: AppRoute.upcomingBirthdayList,
        page: () => UpcomingBirthdayView(),
        binding: UpcomingBirthdayBinding(),
      ),GetPage(
        name: AppRoute.myLocationScreen,
        page: () => MyLocationView(),
        binding: MyLocationBinding(),
      )
    ];
  }
}
