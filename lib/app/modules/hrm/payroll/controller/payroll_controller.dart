import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/payroll/salary/salary_model.dart';
import '../../../../data/network/hrm/payroll/salary/salary_service.dart';
import '../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../data/network/system/currency/service/currency_service.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../employee/controllers/employee_controller.dart';



class PayrollController extends PaginatedController<PayslipData> {
  final PayslipService _service = PayslipService();
  final _currencyService = CurrencyService();


  final String url = UrlRes.salary;
  var error = ''.obs;

  // final TextEditingController payslipTypeController = TextEditingController();
  // final TextEditingController currencyController = TextEditingController();
  // final TextEditingController currencyCodeController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController netSalaryController = TextEditingController();
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();

  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  // --- EMPLOYEE ---
  final RxList<EmployeeData> employees = <EmployeeData>[].obs;
  final EmployeeController employeeController = Get.put(EmployeeController());
  var selectedEmployee = Rxn<EmployeeData>();



  List<String> payslipType = ["Weekly","Monthly","Bi-Weekly","Annual"];
  var selectedPayslipType = Rxn<String>();

  List<String> status = ["paid","unpaid"];
  var selectedStatus = Rxn<String>();

  var currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  var currencyCode = 'INR'.obs;
  var currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;


  // var selectedStatus = "Pending".obs;

  @override
  Future<List<PayslipData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchPayslips(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    _loadEmployees();
    _loadBackground();
  }

  void _loadBackground(){
    loadCurrencies();
    loadControllers();
  }

  void resetForm() {
    salaryController.clear();
    netSalaryController.clear();
    bankAccountController.clear();
    paymentDateController.clear();
    selectedEmployee.value = null;
    if (employeeController.items.isNotEmpty && selectedEmployee.value == null) {
      selectedEmployee.value = employeeController.items.first;
      loadControllers();
    }
  }

  void _loadEmployees() async {
    try {
      await employeeController.loadInitial(); // fetches branches
      employees.assignAll(employeeController.items);
    } catch (e) {
      print("Load branches error: $e");
    }
  }

  Future<void> getEmployeeById(String id) async {
    try {
      final employee = await employeeController.getEmployeeById(id);
      if (employee != null) {
        selectedEmployee.value = employee;
      }
    } catch (e) {
      print("Get employee error: $e");
    }

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

  void loadControllers() {
    paymentDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    salaryController.text = '0.00';
    netSalaryController.text = '0.00';
    // selectedEmployee.value = employeeController.items.first;
    selectedPayslipType.value = payslipType.first;
    selectedStatus.value = status.first;
  }


  /// Get single payslip by ID
  Future<PayslipData?> getPayslipById(String id) async {
    try {
      final existingSlip = items.firstWhereOrNull((item) => item.id == id);
      if (existingSlip != null) {
        return existingSlip;
      } else {
        final payslip = await _service.getPayslipById(id);
        if (payslip != null) {
          items.add(payslip);
          items.refresh();
        }
      }
    } catch (e) {
      print("Get payslip error: $e");
    }
    return null;
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      paymentDateController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
      selectedDate.value = pickedDate;
    }
  }

  // --- CRUD METHODS ---
  Future<bool> createPayslip(PayslipData payslip) async {
    try {
      final success = await _service.createPayslip(payslip);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create payslip error: $e");
      return false;
    }
  }

  Future<bool> updatePayslip(
      String id,
      PayslipData updatedPayslip,
      ) async {
    try {
      final success = await _service.updatePayslip(id, updatedPayslip);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedPayslip;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update payslip error: $e");
      return false;
    }
  }

  Future<bool> deletePayslip(String id) async {
    try {
      final success = await _service.deletePayslip(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete payslip error: $e");
      return false;
    }
  }
}
