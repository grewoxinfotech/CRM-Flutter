import 'package:crm_flutter/app/data/network/all/crm/company/model/company_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/company/service/company_service.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  CompanyService companyService = CompanyService();
  List<CompanyModel> company = [];

  Future<List<CompanyModel>> getCompany() async {
    final data = await CompanyService.getCompany();
    return data;
  }
}