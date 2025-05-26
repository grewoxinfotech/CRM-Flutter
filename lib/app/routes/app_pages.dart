import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/auth/binding/auth_binding.dart';
import 'package:crm_flutter/app/modules/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/binding/company_binding.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/views/company_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/binding/contact_binding.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/views/contact_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/widgets/conteact_overview.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/binding/deal_binding.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_add_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_detail_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/binding/lead_binding.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/binding/task_binding.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_edit_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/binding/attendance_binding.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/binding/Leave_binding.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/views/leave_overview_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/views/leave_screen.dart';
import 'package:crm_flutter/app/widgets/splash/splash.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    /// splash screen
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),

    /// app dashboard screens
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),

    /// auth screens
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),

    /// crm
    // company
    GetPage(
      name: AppRoutes.company,
      page: () => CompanyScreen(),
      binding: CompanyBinding(),
    ),

    // contact
    GetPage(
      name: AppRoutes.contact,
      page: () => ContactScreen(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: AppRoutes.contactOverView,
      page: () => ContactOverviewScreen(),
      binding: ContactBinding(),
    ),

    // deal
    GetPage(
      name: AppRoutes.deal,
      page: () => DealScreen(),
      binding: DealBinding(),
    ),
    GetPage(
      name: AppRoutes.dealDetail,
      page: () => DealDetailScreen(),
      binding: DealBinding(),
    ),
    GetPage(
      name: AppRoutes.dealAdd,
      page: () => DealAddScreen(),
      binding: DealBinding(),
    ),

    // lead
    GetPage(
      name: AppRoutes.lead,
      page: () => LeadScreen(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: AppRoutes.leadDetail,
      page: () => LeadDetailScreen(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: AppRoutes.leadAdd,
      page: () => LeadScreen(),
      binding: LeadBinding(),
    ),

    // task
    GetPage(
      name: AppRoutes.task,
      page: () => TaskScreen(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.taskEdit,
      page: () => TaskEditScreen(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.taskAdd,
      page: () => TaskAddScreen(),
      binding: TaskBinding(),
    ),

    /// hrm
    // attendance
    GetPage(
      name: AppRoutes.attendance,
      page: () => AttendanceScreen(),
      binding: AttendanceBinding(),
    ),

    // employee
    GetPage(name: AppRoutes.employee, page: () => TaskScreen()),

    // leave
    GetPage(
      name: AppRoutes.leave,
      page: () => LeaveScreen(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveOverView,
      page: () => LeaveOverviewScreen(),
      binding: LeaveBinding(),
    ),
  ];
}
