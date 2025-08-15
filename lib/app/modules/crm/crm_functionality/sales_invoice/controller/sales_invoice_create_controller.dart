import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../data/network/sales/product_service/service/product_service.dart';
import '../../../../../data/network/sales_customer/model/sales_customer_model.dart';
import '../../../../../data/network/sales_customer/service/sales_customer_service.dart';
import '../../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../../data/network/system/currency/service/currency_service.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SalesInvoiceCreateController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final _productService = ProductsServicesService();
  final _customerService = SalesCustomerService();
  final _currencyService = CurrencyService();

  // State variables
  var selectedCustomerId = ''.obs;
  var customers = <SalesCustomer>[].obs;
  var isLoadingCustomers = false.obs;

  late TextEditingController gstinController;
  late List<TextEditingController> quantityControllers;
  late List<TextEditingController> unitPriceControllers;
  late List<TextEditingController> itemDiscountControllers;
  late List<TextEditingController> itemGstControllers;
  late TextEditingController taxController;
  late TextEditingController discountController;
  late TextEditingController additionalNotesController;

  var issueDate = DateTime.now().obs;
  var dueDate = DateTime.now().add(const Duration(days: 7)).obs;
  var paymentStatus = 'unpaid'.obs;

  var currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  var currencyCode = 'INR'.obs;
  var currencyIcon = '₹'.obs;

  var itemDiscountTypes = ['percentage'].obs;
  var isGstEnabled = false.obs;

  var products = <Data?>[].obs;
  var selectedProducts = <Data?>[].obs;
  var isLoadingProducts = false.obs;

  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;

  final List<double> gstRates = [0, 5, 12, 18, 28];

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _loadDataInBackground();
  }

  void _initializeControllers() {
    gstinController = TextEditingController();
    quantityControllers = [TextEditingController(text: '1')];
    unitPriceControllers = [TextEditingController(text: '0')];
    itemDiscountControllers = [TextEditingController(text: '0')];
    itemGstControllers = [TextEditingController(text: '0')];
    taxController = TextEditingController(text: '0');
    discountController = TextEditingController(text: '0');
    additionalNotesController = TextEditingController();
  }

  void _loadDataInBackground() {
    _loadProducts();
    _loadCustomers();
    loadCurrencies();
  }

  Future<void> loadCurrencies() async {
    if (isLoadingCurrencies.value) return;
    isLoadingCurrencies.value = true;

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

  Future<void> _loadProducts() async {
    isLoadingProducts.value = true;
    try {
      final productList = await _productService.getProducts();
      products.assignAll(productList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load products: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoadingProducts.value = false;
    }
  }

  Future<void> _loadCustomers() async {
    isLoadingCustomers.value = true;
    try {
      final customerList = await _customerService.getSalesCustomers();
      customers.assignAll(customerList);

      if (customerList.isNotEmpty) {
        selectedCustomerId.value = customerList.first.id;
        isGstEnabled.value = customerList.first.taxNumber?.isNotEmpty ?? false;
        gstinController.text = customerList.first.taxNumber ?? '';
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load customers: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoadingCustomers.value = false;
    }
  }

  void removeProductItem(int index) {
    if (selectedProducts.length > 1) {
      selectedProducts.removeAt(index);

      quantityControllers[index].dispose();
      quantityControllers.removeAt(index);

      unitPriceControllers[index].dispose();
      unitPriceControllers.removeAt(index);

      itemDiscountControllers[index].dispose();
      itemDiscountControllers.removeAt(index);

      itemGstControllers[index].dispose();
      itemGstControllers.removeAt(index);

      itemDiscountTypes.removeAt(index);
    }
  }

  void initializeControllers() {
    // Text controllers
    gstinController = TextEditingController();
    quantityControllers = [TextEditingController(text: '1')];
    unitPriceControllers = [TextEditingController(text: '0')];
    itemDiscountControllers = [TextEditingController(text: '0')];
    itemGstControllers = [TextEditingController(text: '0')];
    taxController = TextEditingController(text: '0');
    discountController = TextEditingController(text: '0');
    additionalNotesController = TextEditingController();

    // Reactive variables
    issueDate.value = DateTime.now();
    dueDate.value = DateTime.now().add(const Duration(days: 7));
    paymentStatus.value = 'unpaid';

    // Default currency (will be updated from API when loaded)
    currency.value = 'AHNTpSNJHMypuNF6iPcMLrz';
    currencyCode.value = 'INR';
    currencyIcon.value = '₹';

    // Defaults for products & customers
    itemDiscountTypes.assignAll(['percentage']);
    selectedProducts.clear();
    selectedCustomerId.value = '';
  }
}
