import 'package:crm_flutter/app/data/models/deal_model.dart';
import 'package:crm_flutter/app/data/service/deal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DealController extends GetxController {
  final RxBool isLoading = false.obs;
  final List<DealModel> deal = <DealModel>[].obs;
  final DealService dealService = DealService();

  final TextEditingController dealTitle = TextEditingController();
  final TextEditingController dealValue = TextEditingController();
  final TextEditingController pipeline = TextEditingController();
  final TextEditingController stage = TextEditingController();
  final TextEditingController closeDate = TextEditingController();
  final TextEditingController source = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController products = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDeals();
  }

  Future<List> getDeals() async {
    final data = await dealService.getDeals();
    deal.assignAll(data.map((e) => DealModel.fromJson(e)).toList());
    print("data : $data");
    return data;
  }

  Future<bool> deleteDeal(String id) async {
    bool isDelete = await dealService.deleteDeal(id);
    (isDelete) => getDeals();
    return (isDelete == true) ? true : false;
  }

  @override
  void onClose() {
    isLoading(false);
    dealService.dispose();
    dealTitle.dispose();
    dealValue.dispose();
    pipeline.dispose();
    stage.dispose();
    closeDate.dispose();
    source.dispose();
    status.dispose();
    products.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
    companyName.dispose();
    address.dispose();
    super.onClose();
  }
}
