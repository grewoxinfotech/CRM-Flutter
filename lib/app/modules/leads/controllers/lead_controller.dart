import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/models/lead_model.dart';
import 'package:crm_flutter/app/data/service/lead_service.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_add_screen.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LeadController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<LeadModel> leadsList = <LeadModel>[].obs;
  final LeadService leadService = LeadService();
  final context = Get.context!;

  final TextEditingController leadTitle = TextEditingController();
  final TextEditingController interestLevel = TextEditingController();
  final TextEditingController leadValue = TextEditingController();
  final TextEditingController pipeline = TextEditingController();
  final TextEditingController stage = TextEditingController();
  final TextEditingController source = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController teamMembers = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchLeads();
  }

  Future<void> addLead() async {
    print("press : Add Lead Button");
    isLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.to(LeadAddScreen()); // Optional delay for splash animation
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
    isLoading(false);
  }

  Future<void> fetchLeads() async {
    isLoading(true);
    try {
      final leads = await leadService.fetchLeads();
      leadsList.assignAll(leads);
    } catch (e) {
      print("Error: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to load leads : $e",
        contentType: ContentType.warning,
        color: Get.theme.colorScheme.error,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteLead(String leadId) async {
    isLoading(true);
    try {
      bool success = await leadService.deleteLead(leadId);
      if (success) {
        leadsList.removeWhere((lead) => lead.id == leadId);
        Get.back();
        Get.snackbar("Success", "Lead deleted successfully");
        isLoading(false);
        return true;
      } else {
        Get.snackbar("Error", "Failed to delete lead");
        isLoading(false);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      isLoading(false);
      return false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    isLoading(false);
    leadService.dispose();
    leadTitle.dispose();
    interestLevel.dispose();
    leadValue.dispose();
    pipeline.dispose();
    stage.dispose();
    source.dispose();
    status.dispose();
    category.dispose();
    teamMembers.dispose();
    super.onClose();
  }
}
