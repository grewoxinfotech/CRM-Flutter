import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_model.dart';
import 'package:crm_flutter/app/data/network/hrm/payroll/salary/salary_model.dart';
import 'package:crm_flutter/app/modules/hrm/employee/controllers/employee_controller.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controller/payroll_controller.dart';

class AddPayrollScreen extends StatelessWidget {
  final PayslipData? payslipData;
  final bool isFromEdit;
  final PayrollController payrollController = Get.put(PayrollController());

  final _formKey = GlobalKey<FormState>();

  AddPayrollScreen({super.key, this.payslipData, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  String? _getCurrencyValue() {
    if (payrollController.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (payrollController.currencies.isNotEmpty) {
      bool currencyExists = payrollController.currencies.any(
        (c) => c.id == payrollController.currency.value,
      );
      if (currencyExists) {
        return payrollController.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return payrollController.currencies.first.id;
      }
    }
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (payrollController.selectedEmployee.value == null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Please select an employee",
        contentType: ContentType.failure,
      );
      return;
    }

    final payroll = PayslipData(
      employeeId: payrollController.selectedEmployee.value?.id,
      payslipType: payrollController.selectedPayslipType.value,
      currency: payrollController.currency.value,
      currencyCode: payrollController.currencyCode.value,
      salary: payrollController.salaryController.text,
      netSalary: int.tryParse(payrollController.netSalaryController.text) ?? 0,
      bankAccount: payrollController.bankAccountController.text,
      paymentDate: payrollController.paymentDateController.text,
      status: payrollController.selectedStatus.value,
    );

    payrollController.isLoading.value = true;
    final success = await payrollController.createPayslip(payroll);
    payrollController.isLoading.value = false;

    if (success) Get.back();

    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Payroll added successfully" : "Failed to add payroll",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  Future<void> update() async {
    if (!_formKey.currentState!.validate()) return;

    if (payrollController.selectedEmployee.value == null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Please select an employee",
        contentType: ContentType.failure,
      );
      return;
    }

    final payroll = PayslipData(
      employeeId: payrollController.selectedEmployee.value?.id,
      payslipType: payrollController.selectedPayslipType.value,
      currency: payrollController.currency.value,
      currencyCode: payrollController.currencyCode.value,
      salary: payrollController.salaryController.text,
      netSalary: int.tryParse(payrollController.netSalaryController.text) ?? 0,
      bankAccount: payrollController.bankAccountController.text,
      paymentDate: payrollController.selectedDate.value?.toIso8601String(),
      status: payrollController.selectedStatus.value,
    );

    payrollController.isLoading.value = true;
    final success = await payrollController.updatePayslip(payslipData!.id!,payroll);
    payrollController.isLoading.value = false;

    if (success) {

      Get.back();
      payrollController.loadInitial();
    }

    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Payroll added successfully" : "Failed to add payroll",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && payslipData != null) {
      payrollController.getEmployeeById(payslipData!.employeeId!);
      payrollController.selectedPayslipType.value = payslipData!.payslipType;
      payrollController.selectedStatus.value = payslipData!.status;
      payrollController.salaryController.text = payslipData!.salary.toString();
      payrollController.netSalaryController.text =
          payslipData!.netSalary.toString();
      payrollController.bankAccountController.text = payslipData!.bankAccount!;
      if (payslipData!.paymentDate != null) {
        final date = DateTime.tryParse(payslipData!.paymentDate!);
        if (date != null) {
          payrollController.selectedDate.value = date;
          payrollController.paymentDateController.text = DateFormat(
            'dd-MM-yyyy',
          ).format(date);
        }
      }
      payrollController.currency.value = payslipData!.currency!;
      payrollController.selectedStatus.value = payslipData!.status!;
    }
    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Payroll' : 'Add Payroll')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Employee Dropdown
              Obx(
                () => CrmDropdownField<EmployeeData>(
                  title: 'Select Employee',
                  isRequired: true,
                  value: payrollController.selectedEmployee.value,
                  items:
                      payrollController.employeeController.items.map((element) {
                        return DropdownMenuItem<EmployeeData>(
                          value: element,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${element.firstName} ${element.lastName}"),
                              const SizedBox(width: 8),
                              Text(element.designation ?? ''),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged:
                      (value) =>
                          payrollController.selectedEmployee.value = value,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: 'Payslip Type',
                        isRequired: true,

                        value: payrollController.selectedPayslipType.value,
                        items:
                            payrollController.payslipType.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                        onChanged:
                            (value) =>
                                payrollController.selectedPayslipType.value =
                                    value,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: 'Status',
                        isRequired: true,

                        value: payrollController.selectedStatus.value,
                        items:
                            payrollController.status.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                        onChanged:
                            (value) =>
                                payrollController.selectedStatus.value = value,
                      ),
                    ),
                  ),
                ],
              ),

              Obx(
                () => CrmDropdownField<String>(
                  title: 'Currency',
                  value: _getCurrencyValue(),
                  items:
                      payrollController.isLoadingCurrencies.value &&
                              payrollController.currenciesLoaded.value
                          ? [
                            DropdownMenuItem(
                              value: payrollController.currency.value,
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
                          : payrollController.currencies.isNotEmpty
                          ? payrollController.currencies
                              .map(
                                (currency) => DropdownMenuItem(
                                  value: currency.id,
                                  child: Text(
                                    '${currency.currencyName} (${currency.currencyIcon})',
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
                        !(payrollController.isLoadingCurrencies.value &&
                            payrollController.currenciesLoaded.value)) {
                      payrollController.updateCurrencyDetails(value);
                    }
                  },
                  onMenuOpened: () {
                    // Load currencies if they haven't been loaded yet or if we're not currently loading
                    if (!payrollController.isLoadingCurrencies.value) {
                      payrollController.loadCurrencies();
                    }
                  },
                  isRequired: true,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: payrollController.salaryController,
                      title: 'Salary',

                      isRequired: true,
                      keyboardType: TextInputType.number,
                      validator: (value) => requiredValidator(value, 'Salary'),
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: CrmTextField(
                      controller: payrollController.netSalaryController,
                      title: 'Net Salary',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      validator:
                          (value) => requiredValidator(value, 'Net Salary'),
                    ),
                  ),
                ],
              ),

              // CrmTextField(
              //   controller: payrollController.currencyController,
              //   title: 'Currency',
              //   isRequired: true,
              //   validator: (value) => requiredValidator(value, 'Currency'),
              // ),
              // CrmTextField(
              //   controller: payrollController.currencyCodeController,
              //   title: 'Currency Code',
              //   isRequired: true,
              //   validator: (value) => requiredValidator(value, 'Currency Code'),
              // ),
              CrmTextField(
                controller: payrollController.bankAccountController,
                title: 'Bank Account',
                isRequired: true,
                validator: (value) => requiredValidator(value, 'Bank Account'),
              ),

              GestureDetector(
                onTap: () => payrollController.pickDate(context),
                child: AbsorbPointer(
                  child: CrmTextField(
                    controller: payrollController.paymentDateController,
                    title: 'Payment Date',
                    isRequired: true,
                    validator:
                        (value) => requiredValidator(value, 'Payment Date'),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Obx(
                () =>
                    payrollController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          onTap: isFromEdit ? update : submit,

                          title:
                              isFromEdit
                                  ? payrollController.isLoading.value
                                      ? 'Updating Payroll...'
                                      : 'Update Payroll'
                                  : payrollController.isLoading.value
                                  ? 'Creating Payroll...'
                                  : 'Create Payroll',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
