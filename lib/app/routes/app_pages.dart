import 'package:crm_flutter/app/modules/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/views/company_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/views/contact_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/custom_form/views/custom_form_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_add_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_detail_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_edit_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/views/leave_screen.dart';
import 'package:crm_flutter/app/widgets/splash/splash.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),

    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.company, page: () => CompanyScreen()),
    GetPage(name: AppRoutes.company, page: () => CustomFormScreen()),
    GetPage(name: AppRoutes.contact, page: () => ContactScreen()),
    GetPage(name: AppRoutes.deal, page: () => DealScreen()),
    GetPage(name: AppRoutes.deal, page: () => DealDetailScreen()),
    GetPage(name: AppRoutes.deal, page: () => DealAddScreen()),
    GetPage(name: AppRoutes.lead, page: () => LeadScreen()),
    GetPage(name: AppRoutes.lead, page: () => LeadDetailScreen()),
    GetPage(name: AppRoutes.lead, page: () => LeadScreen()),
    GetPage(name: AppRoutes.task, page: () => TaskScreen()),
    GetPage(name: AppRoutes.task, page: () => TaskEditScreen()),
    GetPage(name: AppRoutes.task, page: () => TaskAddScreen()),
    GetPage(name: AppRoutes.attendance, page: () => AttendanceScreen()),
    GetPage(name: AppRoutes.employee, page: () => TaskScreen()),
    GetPage(name: AppRoutes.leave, page: () => LeaveScreen()),
  ];
}
