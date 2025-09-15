import 'dart:ui';

import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/database/helper/sqlite_db_helper.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/company/view/company_screen.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/views/contact_screen.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/interview_schedule/views/interview_schedule_screeen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_applications/views/job_application_screen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_candidate/views/job_candidate_screen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_list/views/job_list_screen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_onboarding/views/job_onboarding_screen.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/offer_letter/views/offer_letter_screen.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/views/invoice_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:get/get.dart';

import '../../../access/controller/access_controller.dart';

class JobFunctionController extends GetxController {
  final RxList<FunctionModel> functions = <FunctionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initAccessController();
  }

  Future<void> _initAccessController() async {
    // Initialize AccessController if not already
    AccessController accessController;
    if (!Get.isRegistered<AccessController>()) {
      accessController = Get.put(AccessController());
    } else {
      accessController = Get.find<AccessController>();
    }

    // Fetch role data
    final DBHelper dbHelper = DBHelper();
    final user = await SecureStorage.getUserData();
    final roleId = user?.roleId;
    if (roleId == null) return;

    final roleData = await dbHelper.getRoleById(roleId);
    if (roleData == null) return;

    // Initialize AccessController with permissions
    accessController.init(roleData.permissions ?? {});

    // Now safely update functions
    updateFunctions(accessController);
  }

  void updateFunctions(AccessController accessController) {
    // Initialize RolesService first
    if (!Get.isRegistered<RolesService>()) {
      Get.put(RolesService());
    }

    // Then initialize RoleController
    if (!Get.isRegistered<RoleController>()) {
      Get.put(RoleController());
    }

    // Initialize LabelService and LabelController
    if (!Get.isRegistered<LabelService>()) {
      Get.put(LabelService());
    }

    if (!Get.isRegistered<LabelController>()) {
      Get.put(LabelController());
    }

    if (!Get.isRegistered<AccessController>()) {
      Get.put(AccessController());
    }

    functions.value = [
      if (accessController.can(AccessModule.jobList, AccessAction.view) ||
          accessController.can(AccessModule.jobList, AccessAction.create) ||
          accessController.can(AccessModule.jobList, AccessAction.update) ||
          accessController.can(AccessModule.jobList, AccessAction.delete))
        FunctionModel(
          title: 'Job',
          iconPath: ICRes.jobList,
          color: const Color(0xff008dad),
          screenBuilder: JobListScreen(),
        ),

      if (accessController.can(AccessModule.jobCandidate, AccessAction.view) ||
          accessController.can(
            AccessModule.jobCandidate,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.jobCandidate,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.jobCandidate, AccessAction.delete))
        FunctionModel(
          title: 'Job Candidate',
          iconPath: ICRes.jobCandidate,
          color: const Color(0xff0600ad),
          screenBuilder: JobCandidateScreen(),
        ),
      if (accessController.can(AccessModule.jobOnboarding, AccessAction.view) ||
          accessController.can(
            AccessModule.jobOnboarding,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.jobOnboarding,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.jobOnboarding, AccessAction.delete))
        FunctionModel(
          title: 'Job On-Boarding',
          iconPath: ICRes.jobOnboarding,
          color: const Color(0xff2bad00),
          screenBuilder: JobOnboardingScreen(),
        ),
      if (accessController.can(
            AccessModule.jobApplication,
            AccessAction.view,
          ) ||
          accessController.can(
            AccessModule.jobApplication,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.jobApplication,
            AccessAction.update,
          ) ||
          accessController.can(
            AccessModule.jobApplication,
            AccessAction.delete,
          ))
        FunctionModel(
          title: 'Job Applications',
          iconPath: ICRes.jobApplication,
          color: const Color(0xffad0000),
          screenBuilder: JobApplicationScreen(),
        ),
      if (accessController.can(
            AccessModule.jobOfferLetter,
            AccessAction.view,
          ) ||
          accessController.can(
            AccessModule.jobOfferLetter,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.jobOfferLetter,
            AccessAction.update,
          ) ||
          accessController.can(
            AccessModule.jobOfferLetter,
            AccessAction.delete,
          ))
        FunctionModel(
          title: 'Offer Letters',
          iconPath: ICRes.offerLetter,
          color: const Color(0xff9600ad),
          screenBuilder: OfferLetterScreen(),
        ),

      if (accessController.can(AccessModule.jobInterview, AccessAction.view) ||
          accessController.can(
            AccessModule.jobInterview,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.jobInterview,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.jobInterview, AccessAction.delete))
        FunctionModel(
          title: 'Interviews',
          iconPath: ICRes.calendar,
          color: const Color(0xffad6800),
          screenBuilder: InterviewScheduleCalendarScreen(),
        ),
    ];
  }
}
