import 'package:hrms/app/modules/drawer_screens/salary_slip.dart';

import '../../app/modules/drawer_screens/attendance.dart';
import '../../app/modules/drawer_screens/comp_off.dart';
import '../../app/modules/drawer_screens/expense.dart';
import '../../app/modules/drawer_screens/my_task.dart';
import '../../app/modules/home/views/home_view.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomeView>(() => HomeView());
    register<Attendance>(() => Attendance());
    register<CompOff>(() => CompOff());
    register<SalarySlip>(() => SalarySlip());
    register<Expense>(() => Expense());
    register<MyTask>(() => MyTask());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) return _constructors[type]!();
  }
}
