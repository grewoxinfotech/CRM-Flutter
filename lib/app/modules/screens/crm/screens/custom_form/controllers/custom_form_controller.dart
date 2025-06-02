import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_service.dart';
import 'package:get/get.dart';

class CustomFormController extends GetxController {
  CustomFormService customFormService = CustomFormService();
  List<CustomFormModel> customForm = [];

  Future<List> getLeads() async {
    final data = await CustomFormService.getCustomFrom();
    return data;
  }
}
