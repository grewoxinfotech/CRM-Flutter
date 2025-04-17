import 'package:crm_flutter/app/data/models/lead_model.dart';
import 'package:crm_flutter/app/data/service/lead_service.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LeadController extends GetxController {
  final LeadService leadService = LeadService();
  final RxList<LeadModel> lead = <LeadModel>[].obs;




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
    getLeads();
  }

  Future<List> getLeads() async {
    final data = await leadService.getLeads();
    lead.assignAll(data.map((e) => LeadModel.fromJson(e)).toList());
    print("data : $data");
    return data;
  }

  Future<void> addLead() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(LeadAddScreen());
  }

  Future<bool> deleteLead(String leadId) async {
    bool isDelete = await leadService.deleteLead(leadId);
    (isDelete) => getLeads();
    return (isDelete == true) ? true : false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
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
