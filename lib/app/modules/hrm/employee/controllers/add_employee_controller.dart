import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/system/country/controller/country_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/employee/employee_service.dart';
import '../../../../data/network/system/country/model/country_model.dart';
import '../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../data/network/system/currency/service/currency_service.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'employee_controller.dart';

class AddEmployeeController extends GetxController {
  final CurrencyService _currencyService = CurrencyService();
  final formKey = GlobalKey<FormState>();
  final EmployeeService _service = EmployeeService();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();
  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscController = TextEditingController();
  final bankLocationController = TextEditingController();
  final otpController = TextEditingController();
  final joiningDateController = TextEditingController(); // 👈 Missing earlier

  // Dropdowns / Rx
  final gender = RxnString();
  final phoneCode = RxnString();
  final branch = RxnString();
  final department = RxnString();
  final designation = RxnString();

  final CountryController countryController = Get.put(CountryController());
  final EmployeeController employeeController = Get.put(EmployeeController());

  RxString currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  RxString currencyCode = 'INR'.obs;
  RxString currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;

  RxBool isLoading = false.obs;

  // Country codes
  Rxn<CountryModel> selectedCountryCode = Rxn<CountryModel>();

  // Date
  final joiningDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    // Example: pass an employee if editing
    loadCurrencies();
  }

  void resetForm() {
    // 🔹 Clear all text fields
    firstNameController.clear();
    lastNameController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    addressController.clear();
    salaryController.clear();
    accountHolderController.clear();
    accountNumberController.clear();
    bankNameController.clear();
    ifscController.clear();
    bankLocationController.clear();
    otpController.clear();
    joiningDateController.clear();

    // 🔹 Reset dropdowns / Rx values
    gender.value = null;
    phoneCode.value =
        countryController.countryModel
            .firstWhereOrNull(
              (element) => (element.countryName).toLowerCase() == "india",
            )!
            .phoneCode;
    branch.value = null;
    department.value = null;
    designation.value = null;

    // 🔹 Reset currency values
    currency.value = 'AHNTpSNJHMypuNF6iPcMLrz'; // default
    currencyCode.value = 'INR';
    currencyIcon.value = '₹';

    // (Optional) Clear currency list & flags
    currencies.clear();
    isLoadingCurrencies.value = false;
    currenciesLoaded.value = false;
  }

  Future<void> loadCurrencies() async {
    try {
      final currencyList = await _currencyService.getCurrencies();
      currencies.assignAll(currencyList);
      currenciesLoaded.value = true;

      if (currencyList.isNotEmpty) {
        final selectedCurrency = currencyList.firstWhereOrNull(
          (c) => c.id == currency.value,
        );

        if (selectedCurrency != null) {
          currencyCode.value = selectedCurrency.currencyCode;
          currencyIcon.value = selectedCurrency.currencyIcon;
        } else {
          currency.value = currencyList.first.id;
          currencyCode.value = currencyList.first.currencyCode;
          currencyIcon.value = currencyList.first.currencyIcon;
        }
      }
    } catch (e) {
      if (currenciesLoaded.value) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to load currencies: ${e.toString()}',
          contentType: ContentType.failure,
        );
      }
    } finally {
      isLoadingCurrencies.value = false;
    }
  }

  void updateCurrencyDetails(String currencyId) {
    if (currencies.isNotEmpty) {
      final selectedCurrency = currencies.firstWhereOrNull(
        (c) => c.id == currencyId,
      );

      if (selectedCurrency != null) {
        currency.value = currencyId;
        currencyCode.value = selectedCurrency.currencyCode;
        currencyIcon.value = selectedCurrency.currencyIcon;
      }
    }
  }

  /// Assign data to controllers when editing an employee
  void assignInitialData(EmployeeData employee) {
    firstNameController.text = employee.firstName ?? "";
    lastNameController.text = employee.lastName ?? "";
    usernameController.text = employee.username ?? "";
    emailController.text = employee.email ?? "";
    passwordController.text = employee.password ?? "";
    phoneController.text = employee.phone ?? "";
    addressController.text = employee.address ?? "";

    // Dropdowns
    gender.value = employee.gender;
    branch.value = employee.branch;
    department.value = employee.department;
    designation.value = employee.designation;
    currency.value = employee.currency;
    phoneCode.value = employee.phoneCode;

    // Joining date
    if (employee.joiningDate != null) {
      try {
        final parsed = employee.joiningDate!;
        joiningDate.value = parsed;
        joiningDateController.text = DateFormat("yyyy-MM-dd").format(parsed);
      } catch (_) {
        joiningDate.value = null;
        joiningDateController.clear();
      }
    }

    // Salary
    salaryController.text = employee.salary.toString() ?? "";

    // Bank details
    accountHolderController.text = employee.accountholder ?? "";
    accountNumberController.text = employee.accountnumber ?? "";
    bankNameController.text = employee.bankname ?? "";
    ifscController.text = employee.ifsc ?? "";
    bankLocationController.text = employee.banklocation ?? "";
  }

  Future<void> pickJoiningDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      joiningDate.value = date;
      joiningDateController.text = DateFormat("yyyy-MM-dd").format(date);
    }
  }

  Future<void> editEmployee(String employeeId) async {
    if (!formKey.currentState!.validate()) return;

    if (joiningDate.value == null) {
      Get.snackbar("Error", "Please select Joining Date");
      return;
    }

    final employee = EmployeeData(
      id: employeeId, // make sure your model has `id` for update
      accountholder: accountHolderController.text.trim(),
      accountnumber: accountNumberController.text.trim(),
      address: addressController.text.trim(),
      banklocation: bankLocationController.text.trim(),
      bankname: bankNameController.text.trim(),
      branch: branch.value ?? "",
      currency: currency.value ?? "",
      department: department.value ?? "",
      designation: designation.value ?? "",
      email: emailController.text.trim(),
      firstName: firstNameController.text.trim(),
      gender: gender.value,
      ifsc: ifscController.text.trim(),
      joiningDate: joiningDate.value,
      lastName: lastNameController.text.trim(),
      password: passwordController.text.trim(),
      phone: phoneController.text.trim(),
      phoneCode: selectedCountryCode.value?.phoneCode ?? 'INR',
      salary: salaryController.text.trim(),
      username: usernameController.text.trim(),
    );

    try {
      isLoading.value = true;

      final success = await _service.updateEmployee(employeeId, employee);

      isLoading.value = false;

      if (success) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Employee updated successfully',
          contentType: ContentType.success,
        );
        final index = employeeController.items.indexWhere((e) => e.id == employeeId);
        if (index != -1) {
          employeeController.items[index] = employee; // replace with updated employee
          employeeController.items.refresh(); // notify UI
        }

        Get.back(); // close edit screen
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update employee',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Something went wrong: $e',
        contentType: ContentType.failure,
      );
    }
  }


  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    if (joiningDate.value == null) {
      Get.snackbar("Error", "Please select Joining Date");
      return;
    }


    final employee = EmployeeData(
      accountholder: accountHolderController.text.trim() ?? '',
      accountnumber: accountNumberController.text.trim(),
      address: addressController.text.trim(),
      banklocation: bankLocationController.text.trim(),
      bankname: bankNameController.text.trim(),
      branch: branch.value ?? "",
      currency: currency.value ?? "",
      department: department.value ?? "",
      designation: designation.value ?? "",
      email: emailController.text.trim(),
      firstName: firstNameController.text.trim(),
      gender: gender.value,
      ifsc: ifscController.text.trim(),
      joiningDate: joiningDate.value,
      lastName: lastNameController.text.trim(),
      password: passwordController.text.trim(),
      phone: phoneController.text.trim(),
      phoneCode: selectedCountryCode.value?.phoneCode ?? 'INR',
      salary: salaryController.text.trim() ?? "",
      username: usernameController.text.trim(),
    );

    try {
      final token = await _service.createEmployee(employee);
      if (token != null) {
        isLoading.value=false;
        Get.dialog(
          PopScope(
            canPop: false,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Enter OTP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CrmTextField(
                      title: "OTP",
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      controller: otpController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        // limit to 6 digits
                        FilteringTextInputFormatter.digitsOnly,
                        // only numbers
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      ()=> isLoading.value ?
                          Center(child: CircularProgressIndicator())
                          :Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Get.back(), // close dialog
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              isLoading.value = true;
                              final success = await _service.verifyOtp(
                                otpController.text.trim(),
                                token,
                              );
                              if (success) {
                                isLoading.value = false;
                                Get.back();
                                Get.back();
                              }else{
                                Get.back();
                                isLoading.value = false;
                                otpController.clear();
                                CrmSnackBar.showAwesomeSnackbar(
                                  title: 'Error',
                                  message: 'Invalid OTP',
                                  contentType: ContentType.failure,
                                );
                              }
                            },
                            child: const Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        // Get.back();
      }

      print("[DEBUG]=> success : $token");
    } catch (e) {}

    // TODO: call EmployeeService.createEmployee(payload);
  }

  String? requiredValidator(String? v, String? fieldName) =>
      (v == null || v.trim().isEmpty) ? "$fieldName Required" : null;
}
