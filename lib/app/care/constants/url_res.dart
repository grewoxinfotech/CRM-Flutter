import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';

class UrlRes {
  static const String baseURL = "https://api.raiser.in/api/v1";

  /// headers from api
  static const String contentType = "Content-type";
  static const String applicationJson = "application/json";

  /// headers for auth
  static const String authorization = "Authorization";

  static Future<Map<String, String>> getHeaders() async {
    final token = await SecureStorage.getToken();
    return {contentType: applicationJson, authorization: "Bearer $token"};
  }

  // auth api
  static const String auth = "$baseURL/auth";
  static const String login = "$auth/login";

  /// crm api
  // Lead
  static const String lead = "$baseURL/leads";

  // Deal
  static const String deal = "$baseURL/deals";

  // Contract
  static const String contracts = "$baseURL/contracts";

  // CRM System
  static const String pipelines = "$baseURL/pipelines";
  static const String stages = "$baseURL/stages";
  static const String labels = "$baseURL/labels";

  // company account
  static const String companyAccounts = "$baseURL/company-accounts";

  // contact account
  static const String contacts = "$baseURL/contacts";

  // Custom form
  static const String customForms = "$baseURL/custom-forms";

  // Task
  static const String tasks = "$baseURL/tasks";

  // task calender
  static const String taskCalendars = "$baseURL/taskcalendars";

  // Follow ups
  static const String followupTasks = "$baseURL/followup-tasks";
  static const String followupMeetings = "$baseURL/followup-meetings";
  static const String followupCalls = "$baseURL/followup-calls";

  // Notes
  static const String notes = "$baseURL/notes";

  static String stage(String x) {
    return "$baseURL/stages?stageType=$x&client_id=true";
  }

  static const String roles = "$baseURL/roles";

  /// hrm api
  // employee
  static const String employees = "$baseURL/employees";

  // payroll sales
  static const String salary = "$baseURL/salary";

  // leave management
  static const String leaves = "$baseURL/leaves";

  // Recruitment
  static const String skills = "$baseURL/skills";
  static const String jobs = "$baseURL/jobs";
  static const String jobApplications = "$baseURL/job-applications";
  static const String jobOnboarding = "$baseURL/job-onboarding";
  static const String interviewSchedules = "$baseURL/interview-schedules";
  static const String offerLetters = "$baseURL/offer-letters";

  // Document
  static const String documents = "$baseURL/documents";

  // meeting
  static const String meetings = "$baseURL/meetings";

  // Training
  static const String trainings = "$baseURL/trainings";

  // HRM System
  static const String leaveTypes = "$baseURL/leave-types";
  static const String documentTypes = "$baseURL/document-types";
  static const String payslipTypes = "$baseURL/payslip-types";
  static const String allowanceOptions = "$baseURL/allowance-options";
  static const String loanOptions = "$baseURL/loan-options";
  static const String deductionOptions = "$baseURL/deduction-options";
  static const String goalTypes = "$baseURL/goal-types";
  static const String trainingTypes = "$baseURL/training-types";
  static const String awardTypes = "$baseURL/award-types";
  static const String terminationTypes = "$baseURL/termination-types";
  static const String jobCategories = "$baseURL/job-categories";
  static const String jobStages = "$baseURL/job-stages";
  static const String performanceTypes = "$baseURL/performance-types";
  static const String competencies = "$baseURL/competencies";

  // Company Policy
  static const String policies = "$baseURL/policies";

  // Branch
  static const String branches = "$baseURL/branches";

  // Departments
  static const String departments = "$baseURL/departments";

  // Designation
  static const String designations = "$baseURL/designations";

  // Attendance setup
  static const String attendance = "$baseURL/attendance";

  // Holiday setup
  static const String holidays = "$baseURL/holidays";

  // calendar
  static const String calendar = "$baseURL/calendar";
}
