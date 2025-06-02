import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/service/contact_service.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  Future<List> getLeaves() async =>
      await ContactService.getContacts();
}
