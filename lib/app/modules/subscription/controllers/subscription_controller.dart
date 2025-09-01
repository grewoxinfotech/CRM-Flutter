import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../care/constants/url_res.dart';
import '../../../data/network/inquiry/inquiry_model.dart';
import '../../../data/network/inquiry/inquiry_service.dart';
import '../../../data/network/subscription/subscription_model.dart';
import '../../../data/network/subscription/subscription_service.dart';



class SubscriptionController extends PaginatedController<SubscriptionData> {
  final SubscriptionService _service = SubscriptionService();
  final InquiryService _inquiryService = InquiryService();
  final String url = UrlRes.subscriptionsAssign;
  var error = ''.obs;

  Rxn<SubscriptionData> currentSubscription = Rxn<SubscriptionData>();

  final formKey = GlobalKey<FormState>();

  // Example text controllers (adjust as per your model fields)
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  Future<List<SubscriptionData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchSubscriptions(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadCurrentSubscription();
  }

  void resetForm() {
    planNameController.clear();
    priceController.clear();
    durationController.clear();
  }

  Future<void> loadCurrentSubscription() async {
    try {
      isLoading.value = true;
      await loadInitial();
      final user = await SecureStorage.getUserData();
      if (user?.clientPlanId != null) {
        final subscription = await getSubscriptionById(user!.clientPlanId!);
        print("subscription By Id: ${subscription?.toJson()}");
        currentSubscription.value = subscription;
      }
    } catch (e) {
      error.value = "Failed to load subscription: $e";
    }finally {
      isLoading.value = false;
    }
  }


  Future<SubscriptionData> getPlanByClientId()async{
    try {
      final user = await SecureStorage.getUserData();
      final userId = user?.id;
      print("userId: $userId");
      print("items: ${items.toJson()}");
      final response = items.firstWhereOrNull((element) => element.clientId == userId,);
      print("response: $response");
      if (response != null) {
        return response;
      }
      return SubscriptionData();
    } catch (e) {
      print("Exception in getPlanByClientId: $e");
      throw Exception("Exception in getPlanByClientId: $e");
    }
  }

  /// Get single subscription by ID
  Future<SubscriptionData?> getSubscriptionById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        print("existing: $existing");
        return existing;
      } else {
        final subscription = await _service.getSubscriptionById(id);
        if (subscription != null) {
          print("subscription Data: $subscription");
          items.add(subscription);
          items.refresh();
          return subscription;
        }
      }
    } catch (e) {
      print("Get subscription error: $e");
    }
    return null;
  }

  Future<bool> createInquiry(InquiryData inquiry) async {
    try {
      final data = InquiryData(
        name: inquiry.name,
        email: inquiry.email,
        phone: inquiry.phone,
        phonecode: inquiry.phonecode,
        subject: inquiry.subject,
        message: inquiry.message,
      );

      final success = await _inquiryService.createInquiry(data);
      if (success) {
        await loadInitial(); // reload paginated list
        resetForm();
      }
      return success;
    } catch (e) {
      print("Create inquiry error: $e");
      return false;
    }
  }

  // --- CRUD METHODS ---
  Future<bool> createSubscription(SubscriptionData subscription) async {
    try {
      final success = await _service.createSubscription(subscription);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create subscription error: $e");
      return false;
    }
  }

  Future<bool> updateSubscription(String id, SubscriptionData updated) async {
    try {
      final success = await _service.updateSubscription(id, updated);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updated;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update subscription error: $e");
      return false;
    }
  }

  Future<bool> deleteSubscription(String id) async {
    try {
      final success = await _service.deleteSubscription(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete subscription error: $e");
      return false;
    }
  }
}
