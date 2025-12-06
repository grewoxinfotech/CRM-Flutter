import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_model.dart';
import 'package:crm_flutter/app/modules/hrm/branch/controllers/branch_controller.dart';
import 'package:crm_flutter/app/modules/hrm/department/controllers/department_controller.dart';
import 'package:crm_flutter/app/modules/hrm/designation/controllers/designation_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/system/country/controller/country_controller.dart';
import '../../../../data/network/system/country/model/country_model.dart';

import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../controllers/add_employee_controller.dart';

class AddEmployeeScreen extends StatelessWidget {
  final EmployeeData? employeeData;
  final bool isFromEdit;

  const AddEmployeeScreen({
    super.key,
    this.employeeData,
    this.isFromEdit = false,
  });

  String? _getCurrencyValue(AddEmployeeController controller) {
    if (controller.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (controller.currencies.isNotEmpty) {
      bool currencyExists = controller.currencies.any(
        (c) => c.id == controller.currency.value,
      );
      if (currencyExists) {
        return controller.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return controller.currencies.first.id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEmployeeController());
    final countryController = Get.put(CountryController());
    final branchController = Get.put(BranchController());
    final designationController = Get.put(DesignationController());
    final departmentController = Get.put(DepartmentController());

    if (isFromEdit && employeeData != null) {
      // Text controllers
      controller.firstNameController.text = employeeData!.firstName ?? '';
      controller.lastNameController.text = employeeData!.lastName ?? '';
      controller.usernameController.text = employeeData!.username ?? '';
      controller.emailController.text = employeeData!.email ?? '';
      controller.passwordController.text = employeeData!.password ?? '';
      controller.phoneController.text = employeeData!.phone ?? '';
      controller.addressController.text = employeeData!.address ?? '';
      controller.salaryController.text = employeeData!.salary?.toString() ?? '';
      controller.accountHolderController.text =
          employeeData!.accountholder ?? '';
      controller.accountNumberController.text =
          employeeData!.accountnumber ?? '';
      controller.bankNameController.text = employeeData!.bankname ?? '';
      controller.ifscController.text = employeeData!.ifsc ?? '';
      controller.bankLocationController.text = employeeData!.banklocation ?? '';
      // print("=> password ${employeeData!.password}");

      // Reactive fields
      controller.joiningDate.value = employeeData!.joiningDate;
      controller.gender.value = employeeData!.gender;

      // 🔹 Branch (only if exists in list)
      if (employeeData!.branch != null &&
          branchController.items.any((b) => b.id == employeeData!.branch)) {
        controller.branch.value = employeeData!.branch;
      }

      // 🔹 Designation (check validity)
      if (employeeData!.designation != null &&
          designationController.items.any(
            (d) => d.id == employeeData!.designation,
          )) {
        controller.designation.value = employeeData!.designation;
      }

      // 🔹 Department (check validity)
      if (employeeData!.department != null &&
          departmentController.items.any(
            (d) => d.id == employeeData!.department,
          )) {
        controller.department.value = employeeData!.department;
      }

      // 🔹 Currency (check validity)
      if (employeeData!.currency != null &&
          controller.currencies.any((c) => c.id == employeeData!.currency)) {
        controller.currency.value = employeeData!.currency!;
      }

      // 🔹 Phone Code (safe fallback to India)
      if (employeeData!.phoneCode != null) {
        final match = countryController.countryModel.firstWhereOrNull(
          (c) => c.phoneCode == employeeData!.phoneCode,
        );
        if (match != null) {
          controller.selectedCountryCode.value = match;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isFromEdit ? "Edit Employee" : "Add Employee"),
      ),
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
                      hintText: "First Name",
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
                      hintText: "Last Name",
                      controller: controller.lastNameController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Username
              CrmTextField(
                title: "Username",
                hintText: "Username",
                controller: controller.usernameController,
                validator:
                    (value) => controller.requiredValidator(value, "Username"),
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Email
              CrmTextField(
                title: "Email",
                hintText: "Enter Email",
                controller: controller.emailController,
                validator: (value) => emailValidation(value),
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Password
              CrmTextField(
                title: "Password",
                hintText: "Enter Password",
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
                  Obx(() {
                    final countries = countryController.countryModel;

                    if (countries.isEmpty) {
                      return const Expanded(
                        flex: 2,
                        child: Text("No countries available"),
                      );
                    }

                    // Pick safe default
                    final defaultIndia = countries.firstWhereOrNull(
                      (c) => (c.countryName).toLowerCase() == "india",
                    );

                    final selected =
                        controller.selectedCountryCode.value ??
                        defaultIndia ??
                        countries.first;

                    return Expanded(
                      flex: 2,
                      child: CrmDropdownField<CountryModel>(
                        title: 'Code',
                        isRequired: true,
                        value: selected,
                        items:
                            countries
                                .map(
                                  (country) => DropdownMenuItem<CountryModel>(
                                    value: country,
                                    child: Text(country.phoneCode),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.selectedCountryCode.value = value;
                        },
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: CrmTextField(
                      controller: controller.phoneController,
                      title: 'Contact',
                      hintText: 'Enter Contact',
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      validator: (value) => phoneValidation(value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Address
              CrmTextField(
                title: "Address",
                hintText: "Enter Address",
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
                          hintText: "Select Joining Date",

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
                        hintText: "Select Gender",
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

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: 'Currency',
                        value: _getCurrencyValue(controller),
                        items:
                            controller.isLoadingCurrencies.value &&
                                    controller.currenciesLoaded.value
                                ? [
                                  DropdownMenuItem(
                                    value: controller.currency.value,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text('Loading currencies...'),
                                      ],
                                    ),
                                  ),
                                ]
                                : controller.currencies.isNotEmpty
                                ? controller.currencies
                                    .map(
                                      (currency) => DropdownMenuItem(
                                        value: currency.id,
                                        child: Text(
                                          '${currency.currencyCode} (${currency.currencyIcon})',
                                        ),
                                      ),
                                    )
                                    .toList()
                                : [
                                  DropdownMenuItem(
                                    value: 'AHNTpSNJHMypuNF6iPcMLrz',
                                    child: Text('INR (₹)'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'BHNTpSNJHMypuNF6iPcMLr2',
                                    child: Text('USD (\$)'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'CHNTpSNJHMypuNF6iPcMLr3',
                                    child: Text('EUR (€)'),
                                  ),
                                ],
                        onChanged: (value) {
                          // Don't process changes during loading
                          if (value != null &&
                              !(controller.isLoadingCurrencies.value &&
                                  controller.currenciesLoaded.value)) {
                            controller.updateCurrencyDetails(value);
                          }
                        },

                        isRequired: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CrmTextField(
                      title: 'Salary',
                      controller: controller.salaryController,
                      hintText: 'Enter Salary',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),
              Obx(() {
                //   if (controller.isLoading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                // If no branches loaded yet
                if (branchController.items.isEmpty) {
                  return const Text("No branches available");
                }

                return CrmDropdownField<String>(
                  title: 'Branch',
                  hintText: 'Select Branch',
                  value:
                      controller.branch.value ??
                      branchController.items.first.id,
                  items:
                      branchController.items
                          .map(
                            (branch) => DropdownMenuItem<String>(
                              value: branch.id!,
                              child: Text(branch.branchName ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (branchId) {
                    controller.branch.value = branchId!;
                  },
                );
              }),

              SizedBox(height: AppSpacing.medium),
              Obx(() {
                // if (controller.isLoading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                final designationItems =
                    designationController.items
                        .where((d) => d.branch == controller.branch.value)
                        .toList();

                if (designationItems.isEmpty) {
                  return const Text("No Designation available");
                }

                final currentValue = controller.designation.value;
                final safeValue =
                    designationItems.any((d) => d.id == currentValue)
                        ? currentValue
                        : designationItems.first.id;

                return CrmDropdownField<String>(
                  title: 'Designation',
                  hintText: 'Select Designation',
                  value: safeValue,
                  items:
                      designationItems
                          .map(
                            (designation) => DropdownMenuItem<String>(
                              value: designation.id!,
                              child: Text(designation.designationName ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (designationId) {
                    controller.designation.value = designationId!;
                  },
                );
              }),

              SizedBox(height: AppSpacing.medium),
              Obx(() {
                // if (controller.isLoading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                final departmentItems =
                    departmentController.items
                        .where((d) => d.branch == controller.branch.value)
                        .toList();

                if (departmentItems.isEmpty) {
                  return const Text("No Department available");
                }

                final currentValue = controller.department.value;
                final safeValue =
                    departmentItems.any((d) => d.id == currentValue)
                        ? currentValue
                        : departmentItems.first.id;

                return CrmDropdownField<String>(
                  title: 'Department',
                  hintText: 'Select Department',
                  value: safeValue,
                  items:
                      departmentItems
                          .map(
                            (department) => DropdownMenuItem<String>(
                              value: department.id!,
                              child: Text(department.departmentName ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (departmentId) {
                    controller.department.value = departmentId!;
                  },
                );
              }),

              SizedBox(height: AppSpacing.medium),

              /// Bank Info
              CrmTextField(
                title: "Account Holder",
                hintText: "Account Holder",
                controller: controller.accountHolderController,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "Account Number",
                hintText: "Account Number",
                controller: controller.accountNumberController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "Bank Name",
                hintText: "Bank Name",
                controller: controller.bankNameController,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "IFSC Code",
                hintText: "IFSC Code",
                controller: controller.ifscController,
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                title: "Bank Location",
                hintText: "Bank Location",
                controller: controller.bankLocationController,
              ),

              const SizedBox(height: 20),
              Obx(
                () => CrmButton(
                  width: double.infinity,
                  title:
                      isFromEdit
                          ? controller.isLoading.value
                              ? "Updating..."
                              : "Update"
                          : controller.isLoading.value
                          ? "Submitting..."
                          : "Submit",
                  onTap: () {
                    controller.isLoading.value = true;
                    isFromEdit ? controller.editEmployee(employeeData!.id!):
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
