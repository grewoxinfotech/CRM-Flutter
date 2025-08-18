import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_model.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';

// class AddEmployeeController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   final salaryController = TextEditingController();
//   final accountHolderController = TextEditingController();
//   final accountNumberController = TextEditingController();
//   final bankNameController = TextEditingController();
//   final ifscController = TextEditingController();
//   final bankLocationController = TextEditingController();
//
//   // Dropdowns
//   final gender = RxnString();
//   final phoneCode = RxnString();
//   final branch = RxnString();
//   final department = RxnString();
//   final designation = RxnString();
//   final currency = RxnString();
//
//   String? selectedCountryCode = '+91';
//   final List<String> countryCodes = ['+91', '+1', '+44', '+61', '+81'];
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     assignInitialData();
//   }
//
//   void assignInitialData(EmployeeModel employee) {
//     firstNameController.text = employee.firstName ?? "";
//     lastNameController.text = employee.lastName ?? "";
//     usernameController.text = employee.username ?? "";
//     emailController.text = employee.email ?? "";
//     passwordController.text = employee.password ?? "";
//     phoneCodeController.text = employee.phoneCode ?? "";
//     phoneController.text = employee.phone ?? "";
//     addressController.text = employee.address ?? "";
//
//     // Dropdowns
//     gender.value = employee.gender ?? "";
//     branch.value = employee.branch ?? "";
//     department.value = employee.department ?? "";
//     designation.value = employee.designation ?? "";
//     currency.value = employee.currency ?? "";
//
//     // Date picker
//     if (employee.joiningDate != null && employee.joiningDate!.isNotEmpty) {
//       try {
//         selectedJoiningDate.value = DateTime.parse(employee.joiningDate!);
//         joiningDateController.text = employee.joiningDate!;
//       } catch (_) {
//         selectedJoiningDate.value = DateTime.now();
//         joiningDateController.text = "";
//       }
//     }
//
//     // Salary
//     salaryController.text = employee.salary?.toString() ?? "";
//
//     // Bank details
//     accountHolderController.text = employee.accountHolder ?? "";
//     accountNumberController.text = employee.accountNumber ?? "";
//     bankNameController.text = employee.bankName ?? "";
//     ifscController.text = employee.ifsc ?? "";
//     bankLocationController.text = employee.bankLocation ?? "";
//   }
//
//   // Date
//   final joiningDate = Rxn<DateTime>();
//
//   Future<void> pickJoiningDate(BuildContext context) async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1990),
//       lastDate: DateTime(2100),
//     );
//     if (date != null) joiningDate.value = date;
//   }
//
//   Future<void> submit() async {
//     if (!formKey.currentState!.validate()) return;
//
//     if (joiningDate.value == null) {
//       Get.snackbar("Error", "Please select Joining Date");
//       return;
//     }
//     if (gender.value == null) {
//       Get.snackbar("Error", "Please select Gender");
//       return;
//     }
//     if (branch.value == null ||
//         department.value == null ||
//         designation.value == null ||
//         currency.value == null) {
//       Get.snackbar("Error", "Please fill all dropdowns");
//       return;
//     }
//
//     final payload = {
//       "firstName": firstNameController.text.trim(),
//       "lastName": lastNameController.text.trim(),
//       "username": usernameController.text.trim(),
//       "email": emailController.text.trim(),
//       "password": passwordController.text.trim(),
//       "phoneCode": selectedCountryCode,
//       "phone": phoneController.text.trim(),
//       "address": addressController.text.trim(),
//       "gender": gender.value,
//       "joiningDate": joiningDate.value?.toIso8601String(),
//       "branch": branch.value,
//       "department": department.value,
//       "designation": designation.value,
//       "currency": currency.value,
//       "salary": double.tryParse(salaryController.text.trim()) ?? 0.0,
//       "accountholder": accountHolderController.text.trim(),
//       "accountnumber": accountNumberController.text.trim(),
//       "bankname": bankNameController.text.trim(),
//       "ifsc": ifscController.text.trim(),
//       "banklocation": bankLocationController.text.trim(),
//     };
//
//     // TODO: call EmployeeService.createEmployee(payload);
//   }
//
//   // Reusable Validators
//   String? requiredValidator(String? v, String? fieldName) =>
//       (v == null || v.trim().isEmpty) ? "$fieldName Required" : null;
//
//   String? emailValidator(String? v) =>
//       (v != null && v.isEmail) ? null : "Enter valid email";
//
//   String? phoneValidator(String? v) {
//     if (v == null || v.isEmpty) return "Required";
//     if (!GetUtils.isNumericOnly(v)) return "Invalid phone";
//     if (v.length < 7 || v.length > 15) return "Phone length invalid";
//     return null;
//   }
//
//   String? salaryValidator(String? v) {
//     if (v == null || v.isEmpty) return "Required";
//     final s = double.tryParse(v);
//     if (s == null || s <= 0) return "Enter valid salary";
//     return null;
//   }
//
//   String? ifscValidator(String? v) {
//     if (v == null || v.isEmpty) return "Required";
//     final regex = RegExp(r'^[A-Za-z]{4}\d{7}$'); // Basic IFSC pattern
//     return regex.hasMatch(v) ? null : "Invalid IFSC code";
//   }
//
//   String? accountNumberValidator(String? v) {
//     if (v == null || v.isEmpty) return "Required";
//     if (!GetUtils.isNumericOnly(v)) return "Account must be numeric";
//     return null;
//   }
// }
class AddEmployeeController extends GetxController {
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
  final currency = RxnString();

  RxBool isLoading = false.obs;

  // Country codes
  String? selectedCountryCode = '+91';
  final List<String> countryCodes = ['+91', '+1', '+44', '+61', '+81'];

  // Date
  final joiningDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    // Example: pass an employee if editing
    assignInitialData(dummyEmployee);
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

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    if (joiningDate.value == null) {
      Get.snackbar("Error", "Please select Joining Date");
      return;
    }

    // final payload = {
    //   "firstName": firstNameController.text.trim(),
    //   "lastName": lastNameController.text.trim(),
    //   "username": usernameController.text.trim(),
    //   "email": emailController.text.trim(),
    //   "password": passwordController.text.trim(),
    //   "phoneCode": phoneCode.value ?? selectedCountryCode,
    //   "phone": phoneController.text.trim(),
    //   "address": addressController.text.trim(),
    //   "gender": gender.value,
    //   "joiningDate": joiningDate.value?.toIso8601String(),
    //   "branch": branch.value,
    //   "department": department.value,
    //   "designation": designation.value,
    //   "currency": currency.value,
    //   "salary": double.tryParse(salaryController.text.trim()) ?? 0.0,
    //   "accountholder": accountHolderController.text.trim(),
    //   "accountnumber": accountNumberController.text.trim(),
    //   "bankname": bankNameController.text.trim(),
    //   "ifsc": ifscController.text.trim(),
    //   "banklocation": bankLocationController.text.trim(),
    // };

    final employee = EmployeeData(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phoneCode: phoneCode.value ?? selectedCountryCode!,
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      gender: gender.value,
      joiningDate:
          joiningDate
              .value, // already DateTime (if your model expects DateTime)
      branch: branch.value ?? "",
      department: department.value ?? "",
      designation: designation.value ?? "",
      currency: currency.value ?? "",
      salary: salaryController.text.trim() ?? "",
      accountholder: accountHolderController.text.trim(),
      accountnumber: accountNumberController.text.trim(),
      bankname: bankNameController.text.trim(),
      ifsc: ifscController.text.trim(),
      banklocation: bankLocationController.text.trim(),
    );

    try {
      final token = await _service.createEmployee(employee);
      if (token != null) {
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
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Get.back(), // close dialog
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final success = await _service.verifyOtp(
                              otpController.text.trim(),
                              token,
                            );
                            if (success) Get.back();
                          },
                          child: const Text("Submit"),
                        ),
                      ],
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

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEmployeeController());

    return Scaffold(
      appBar: AppBar(title: const Text("Add Employee")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// First & Last name
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      title: "First Name",
                      controller: controller.firstNameController,
                      validator:
                          (value) =>
                              controller.requiredValidator(value, "First Name"),
                      isRequired: true,
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: CrmTextField(
                      title: "Last Name",
                      controller: controller.lastNameController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Username
              CrmTextField(
                title: "Username",
                controller: controller.usernameController,
                validator:
                    (value) => controller.requiredValidator(value, "Username"),
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Email
              CrmTextField(
                title: "Email",
                controller: controller.emailController,
                validator: (value) => emailValidation(value),
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Password
              CrmTextField(
                title: "Password",
                controller: controller.passwordController,
                obscureText: true,
                validator:
                    (value) => controller.requiredValidator(value, "Password"),
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Phone + Code
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CrmDropdownField<String>(
                      title: 'Code',
                      value: controller.selectedCountryCode,
                      items:
                          controller.countryCodes
                              .map(
                                (code) => DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        controller.selectedCountryCode = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: CrmTextField(
                      controller: controller.phoneController,
                      title: 'Contact',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Address
              CrmTextField(
                title: "Address",
                controller: controller.addressController,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Joining Date & Gender
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => InkWell(
                        onTap: () => controller.pickJoiningDate(context),
                        child: CrmTextField(
                          title: "Joining Date",
                          controller: TextEditingController(
                            text:
                                controller.joiningDate.value == null
                                    ? ""
                                    : DateFormat(
                                      "yyyy-MM-dd",
                                    ).format(controller.joiningDate.value!),
                          ),
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: "Gender",
                        value: controller.gender.value,
                        items: const [
                          DropdownMenuItem(value: "male", child: Text("Male")),
                          DropdownMenuItem(
                            value: "female",
                            child: Text("Female"),
                          ),
                          DropdownMenuItem(
                            value: "other",
                            child: Text("Other"),
                          ),
                        ],
                        onChanged: (v) => controller.gender.value = v,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Salary + Currency
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: 'Currency',
                        value: controller.currency.value,
                        items: const [
                          DropdownMenuItem(value: "INR", child: Text("INR")),
                          DropdownMenuItem(value: "USD", child: Text("USD")),
                        ],
                        onChanged: (v) => controller.currency.value = v,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: CrmTextField(
                      controller: controller.salaryController,
                      title: 'Salary',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Bank Info
              CrmTextField(
                title: "Account Holder",
                controller: controller.accountHolderController,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "Account Number",
                controller: controller.accountNumberController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "Bank Name",
                controller: controller.bankNameController,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "IFSC Code",
                controller: controller.ifscController,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "Bank Location",
                controller: controller.bankLocationController,
              ),

              const SizedBox(height: 20),
              Obx(
                () => CrmButton(
                  width: double.infinity,
                  title: controller.isLoading.value ? "Submiting..." : "Submit",
                  onTap: () {
                    controller.isLoading.value = true;
                    controller.submit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final dummyEmployee = EmployeeData(
  firstName: "Tejas",
  lastName: "Sojitra",
  username: "grewoxlala",
  email: "tejassojitra075@gmail.com",
  password: "hgdskjgd45",
  phoneCode: "+91",
  phone: "9638634790",
  address: "123 Main Street, Surat, Gujarat",
  gender: "male",
  joiningDate: DateTime.parse("2025-08-26T18:30:00.000Z"), // ✅ DateTime object
  branch: "MWd9r3x14Va3vlVwtgbQYSh",
  department: "aOQii2POUo5IkqvF0nI4z3j",
  designation: "ZDErSEqeRISxyNXoNLDiSPl",
  currency: "q6xe5PwPo74hw2hkumFyBvb",
  salary: "30000", // ✅ double (use 30000 if int)
  accountholder: "Tejas Sojitra",
  accountnumber: "32313",
  bankname: "Jessamine Cain",
  ifsc: "21312321",
  banklocation: "Mumbai Branch",
);
