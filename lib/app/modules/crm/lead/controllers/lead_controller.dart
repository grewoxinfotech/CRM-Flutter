import 'package:crm_flutter/app/data/models/crm/lead/lead_model.dart';
import 'package:crm_flutter/app/data/service/lead_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LeadController extends GetxController {
  final LeadService leadService = LeadService();
  final RxList<LeadModel> lead = <LeadModel>[].obs;

  // Text controllers for Lead fields
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
    getLeads(); // Fetch leads on controller init
  }

  /// 1. Get all leads
  Future<List> getLeads() async {
    final data = await leadService.getLeads();
    lead.assignAll(data.map((e) => LeadModel.fromJson(e)).toList());
    return data;
  }

  /// 2. Add a new lead
  Future<void> addLead() async {}

  /// 3. Edit an existing lead
  Future<void> editLead(String leadId) async {
    // Fetch lead details before editing
    final leadData = await leadService.getLeadById(leadId);
    if (leadData != null) {
      // Navigate to the edit screen with the lead data
      // Get.to(LeadEditScreen(leadData: leadData));
    }
  }

  /// 4. Delete a lead by ID
  Future<bool> deleteLead(String id) async {
    bool isDelete = await leadService.deleteLead(id);
    if (isDelete) {
      await getLeads(); // Refresh the list of leads after deletion
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers when controller is closed
    leadTitle.dispose();
    interestLevel.dispose();
    leadValue.dispose();
    pipeline.dispose();
    stage.dispose();
    source.dispose();
    status.dispose();
    category.dispose();
    teamMembers.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
    companyName.dispose();
    address.dispose();
    super.onClose();
  }
}
