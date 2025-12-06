import 'package:crm_flutter/app/care/constants/ic_res.dart';
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
import 'package:crm_flutter/app/modules/job/job_functionality/interview_schedule/views/add_interview_schedule_screen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/offer_letter/views/offer_letter_screen.dart';
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
import '../../../modules/job/job_functionality/job_applications/views/job_application_screen.dart';
import '../../../modules/job/job_functionality/job_candidate/views/job_candidate_screen.dart';
import '../../../modules/job/job_functionality/job_list/views/job_list_screen.dart';
import '../../../modules/job/job_functionality/job_onboarding/views/job_onboarding_screen.dart';

class ModuleConfig {
  final String name;
  final String tag;
  final String screen;
  final String category;

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
      category: json['category'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'tag': tag, 'screen': screen, 'category': category};
  }
}

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

  "JobListScreen": () => JobListScreen(),

  "JobInterviewScreen": () => AddInterviewScheduleScreen(),
  "JobCandidateScreen": () => JobCandidateScreen(),
  "JobOnboardingScreen": () => JobOnboardingScreen(),
  "JobApplicationScreen": () => JobApplicationScreen(),
  "JobOfferLetterScreen": () => OfferLetterScreen(),
};

class ModuleIconMapper {
  static final Map<String, String> _iconMap = {
    "dashboards-deal": ICRes.deal,
    "dashboards-lead": ICRes.lead,
    "dashboards-task": ICRes.task,
    "extra-hrm-employee": ICRes.employee,
    "extra-hrm-payroll": ICRes.payroll,
    "extra-hrm-role": ICRes.role,
    "extra-hrm-branch": ICRes.branch,

    "extra-hrm-holiday": ICRes.holiday,
    "extra-hrm-meeting": ICRes.meeting,
    "extra-hrm-document": ICRes.document,

    "extra-hrm-department": ICRes.department,
    "extra-hrm-designation": ICRes.designation,

    "extra-hrm-announcement": ICRes.announcement,
    "extra-hrm-jobs-joblist": ICRes.jobList,
    "dashboards-TaskCalendar": ICRes.calendar,

    "extra-hrm-trainingSetup": ICRes.training,
    "extra-users-client-list": ICRes.customer,
    "dashboards-sales-invoice": ICRes.salesInvoice,
    "dashboards-sales-revenue": ICRes.revenue,
    "extra-hrm-jobs-interview": ICRes.calendar,
    "dashboards-sales-customer": ICRes.customer,
    "extra-hrm-leave-leavelist": ICRes.leave,
    "dashboards-purchase-vendor": ICRes.vendor,
    "dashboards-purchase-billing": ICRes.bill,
    "extra-hrm-jobs-jobcandidate": ICRes.jobCandidate,
    "extra-hrm-jobs-jobonbording": ICRes.jobOnboarding,
    "dashboards-sales-credit-notes": ICRes.creditNote,
    "extra-hrm-jobs-jobapplication": ICRes.jobApplication,
    "extra-hrm-jobs-jobofferletter": ICRes.offerLetter,
    "dashboards-purchase-debit-note": ICRes.debitNote,
    "dashboards-sales-product-services": ICRes.product,
    "extra-hrm-attendance-attendancelist": ICRes.attendance,
  };

  static String getIcon(String tag) {
    return _iconMap[tag] ?? ICRes.notifications;
  }
}
