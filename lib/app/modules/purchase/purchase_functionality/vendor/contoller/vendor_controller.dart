import 'package:get/get.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import '../../../../../care/constants/url_res.dart';
import '../../../../../data/database/storage/secure_storage_service.dart';
import '../../../../../data/network/purchase/vendor/model/vendor_model.dart';
import '../../../../../data/network/purchase/vendor/service/vendor_service.dart';


class VendorController extends PaginatedController<VendorData> {
  final VendorService _service = VendorService();
  final String url = UrlRes.vendors;
  var error = ''.obs;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<VendorData>> fetchItems(int page) async {
    try {
      final message = await _service.fetchVendors(page: page);
      return message?.data ?? [];
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  Future<VendorData?> getVendorById(String id) async {
    try {
      final existingVendor = items.firstWhereOrNull((item) => item.id == id);
      if (existingVendor != null) {
        return existingVendor;
      } else {
        // fetch from service if not found in current items
        final message = await _service.fetchVendors(id: id);
        final vendor = message?.data?.first;
        if (vendor != null) {
          items.add(vendor);
          items.refresh();
        }
        return vendor;
      }
    } catch (e) {
      print("Get vendor error: $e");
      return null;
    }
  }

  // --- CRUD METHODS ---
  Future<bool> createVendor(VendorData vendor) async {
    try {
      final success = await _service.createVendor(vendor);
      if (success) {
        await loadInitial(); // reload the list
      }
      return success;
    } catch (e) {
      print("Create vendor error: $e");
      return false;
    }
  }

  Future<bool> updateVendor(String id, VendorData updatedVendor) async {
    try {
      final success = await _service.updateVendor(id, updatedVendor);
      if (success) {
        final index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedVendor;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update vendor error: $e");
      return false;
    }
  }

  Future<bool> deleteVendor(String id) async {
    try {
      final success = await _service.deleteVendor(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
        items.refresh();
      }
      return success;
    } catch (e) {
      print("Delete vendor error: $e");
      return false;
    }
  }
}
