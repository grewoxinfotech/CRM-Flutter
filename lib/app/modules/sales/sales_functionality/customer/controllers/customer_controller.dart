// import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
// import 'package:get/get.dart';
//
// import '../../../../../data/database/storage/secure_storage_service.dart';
// import '../../../../../data/network/sales/customer/service/customer_service.dart';
//
// class CustomerController extends GetxController {
//   final CustomerService _service = CustomerService();
//
//   // State variables
//   var customers = <CustomerData>[].obs;
//   var isLoading = false.obs;
//   var error = ''.obs;
//
//   // Fetch all customers
//   Future<void> getCustomers() async {
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       final userId = (await SecureStorage.getUserData())?.id;
//       if (userId == null) {
//         error.value = "User ID not found. Please log in again.";
//         return;
//       }
//
//       final fetchedCustomers = await _service.getCustomerById(userId);
//       customers.add(fetchedCustomers);
//     } catch (e) {
//       error.value = "Failed to load customers: $e";
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Create new customer
//   Future<bool> createCustomer(Customer customer) async {
//     try {
//       final userId = await SecureStorage.getUserId();
//       if (userId == null) {
//         error.value = "User ID not found.";
//         return false;
//       }
//
//       final success = await _service.createCustomer(userId, customer);
//       if (success) {
//         await getCustomers();
//       }
//       return success;
//     } catch (e) {
//       error.value = "Failed to create customer: $e";
//       return false;
//     }
//   }
//
//   // Update customer
//   Future<bool> updateCustomer(String customerId, Customer customer) async {
//     try {
//       final success = await _service.updateCustomer(customerId, customer);
//       if (success) {
//         await getCustomers();
//       }
//       return success;
//     } catch (e) {
//       error.value = "Failed to update customer: $e";
//       return false;
//     }
//   }
//
//   // Delete customer
//   Future<bool> deleteCustomer(String customerId) async {
//     try {
//       final success = await _service.deleteCustomer(customerId);
//       if (success) {
//         customers.removeWhere((c) => c.id == customerId);
//       }
//       return success;
//     } catch (e) {
//       error.value = "Failed to delete customer: $e";
//       return false;
//     }
//   }
// }
