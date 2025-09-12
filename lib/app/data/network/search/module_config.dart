import 'package:crm_flutter/app/data/network/sales_invoice/service/sales_invoice_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/hrm/announcement/views/announcement_screen.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/modules/hrm/branch/views/branch_screen.dart';
import 'package:crm_flutter/app/modules/hrm/calendar/views/calendar_screen.dart';
import 'package:crm_flutter/app/modules/hrm/department/views/department_screen.dart';
import 'package:crm_flutter/app/modules/hrm/designation/views/designation_screen.dart';
import 'package:crm_flutter/app/modules/hrm/document/screen/document_screen.dart';
import 'package:crm_flutter/app/modules/hrm/employee/views/employee_screen.dart';
import 'package:crm_flutter/app/modules/hrm/holiday/views/holiday_screen.dart';
import 'package:crm_flutter/app/modules/hrm/leave_management/views/leave_screen.dart';
import 'package:crm_flutter/app/modules/hrm/meeting/views/meeting_screen.dart';
import 'package:crm_flutter/app/modules/hrm/payroll/views/payroll_screen.dart';
import 'package:crm_flutter/app/modules/hrm/role/views/role_screen.dart';
import 'package:crm_flutter/app/modules/hrm/training/views/training_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/billing/views/billing_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/debit_notes/views/debit_note_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/views/vendor_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/credit_notes/views/credit_notes_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/views/invoice_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/revenue/views/revenue_screen.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:flutter/material.dart';

import '../../../modules/crm/crm_functionality/deal/views/deal_screen.dart';

class ModuleConfig {
  final String name;
  final String tag;
  final String screen;
  final String category; // new field

  ModuleConfig({
    required this.name,
    required this.tag,
    required this.screen,
    required this.category,
  });

  factory ModuleConfig.fromJson(Map<String, dynamic> json) {
    return ModuleConfig(
      name: json['name'],
      tag: json['tag'],
      screen: json['screen'],
      category: json['category'] ?? 'Unknown', // default if missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tag': tag,
      'screen': screen,
      'category': category,
    };
  }
}

/// Map of screen name → Widget builder
final Map<String, dynamic> screenMapper = {
  "RoleScreen": () => RoleScreen(),
  "DealScreen": () => DealScreen(),
  "LeadScreen": () => LeadScreen(),
  "TaskScreen": () => TaskScreen(),
  "BranchScreen": () => BranchScreen(),
  "HolidayScreen": () => HolidayScreen(),
  "MeetingScreen": () => MeetingScreen(),
  "PayrollScreen": () => PayrollScreen(),
  "DocumentScreen": () => DocumentScreen(),
  "EmployeeScreen": () => EmployeeScreen(),

  "DepartmentScreen": () => DepartmentScreen(),
  "DesignationScreen": () => DesignationScreen(),

  "AnnouncementScreen": () => AnnouncementScreen(),

  "TaskCalendarScreen": () => CalendarScreen(),

  "TrainingSetupScreen": () => TrainingScreen(),

  "SalesInvoiceScreen": () => InvoiceScreen(),
  "SalesRevenueScreen": () => RevenueScreen(),

  "SalesCustomerScreen": () => CustomerScreen(),
  "LeaveListScreen": () => LeaveScreen(),
  "PurchaseVendorScreen": () => VendorsScreen(),
  "PurchaseBillingScreen": () => BillingScreen(),

  "CreditNotesScreen": () => CreditNoteScreen(),

  "DebitNoteScreen": () => DebitNotesScreen(),
  "ProductServicesScreen": () => ProductsServicesScreen(),
  "AttendanceListScreen": () => AttendanceScreen(),
};

class ModuleIconMapper {
  static final Map<String, IconData> _iconMap = {
    "dashboards-deal": Icons.handshake, // Deals
    "dashboards-lead": Icons.trending_up, // Leads
    "dashboards-task": Icons.task_alt, // Tasks
    "extra-hrm-employee": Icons.people_alt, // Employees
    "extra-hrm-payroll": Icons.payments, // Payroll
    "extra-hrm-role": Icons.admin_panel_settings, // Roles
    "extra-hrm-branch": Icons.apartment, // Branches
    "extra-users-list": Icons.supervised_user_circle, // Users
    "extra-hrm-holiday": Icons.beach_access, // Holidays
    "extra-hrm-meeting": Icons.video_call, // Meetings
    "extra-hrm-document": Icons.description, // Documents
    "dashboards-proposal": Icons.request_page, // Proposals
    "extra-hrm-department": Icons.business, // Departments
    "extra-hrm-designation": Icons.badge, // Designation
    "dashboards-systemsetup": Icons.settings, // System Setup
    "extra-hrm-announcement": Icons.campaign, // Announcements
    "extra-hrm-jobs-joblist": Icons.work_outline, // Job List
    "dashboards-TaskCalendar": Icons.calendar_today, // Task Calendar
    "dashboards-project-list": Icons.folder_open, // Projects
    "extra-hrm-trainingSetup": Icons.school, // Training
    "extra-users-client-list": Icons.group, // Clients
    "dashboards-sales-invoice": Icons.receipt_long, // Sales Invoice
    "dashboards-sales-revenue": Icons.show_chart, // Revenue
    "extra-hrm-jobs-interview": Icons.record_voice_over, // Interview
    "dashboards-sales-customer": Icons.person_outline, // Customer
    "extra-hrm-leave-leavelist": Icons.time_to_leave, // Leaves
    "dashboards-purchase-vendor": Icons.store, // Vendor
    "dashboards-purchase-billing": Icons.request_quote, // Billing
    "extra-hrm-jobs-jobcandidate": Icons.assignment_ind, // Candidate
    "extra-hrm-jobs-jobonbording": Icons.how_to_reg, // Onboarding
    "dashboards-sales-credit-notes": Icons.note_add, // Credit Notes
    "extra-hrm-jobs-jobapplication": Icons.fact_check, // Application
    "extra-hrm-jobs-jobofferletter": Icons.mark_email_read, // Offer Letter
    "dashboards-purchase-debit-note": Icons.note, // Debit Notes
    "dashboards-sales-product-services": Icons.inventory, // Products/Services
    "extra-hrm-attendance-attendancelist": Icons.check_circle, // Attendance
  };

  /// Get icon by tag
  static IconData getIcon(String tag) {
    return _iconMap[tag] ?? Icons.apps; // default icon
  }
}


