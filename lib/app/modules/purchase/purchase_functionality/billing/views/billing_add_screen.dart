import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/purchase/billing/model/billing_model.dart';
import 'package:crm_flutter/app/data/network/purchase/vendor/model/vendor_model.dart';
import 'package:crm_flutter/app/data/network/purchase/vendor/service/vendor_service.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/billing/controllers/add_bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../data/network/sales/product_service/service/product_service.dart';
import '../../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../../data/network/system/currency/service/currency_service.dart';
import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/billing_controller.dart';

class BillingCreatePage extends StatefulWidget {
  const BillingCreatePage({Key? key}) : super(key: key);

  @override
  State<BillingCreatePage> createState() => _BillingCreatePageState();
}

class _BillingCreatePageState extends State<BillingCreatePage> {
  final bilController = Get.put(BillCreateController());

  Widget _buildVendorField() {
    return Obx(() {
      if (bilController.isLoadingVendors.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrmDropdownField<String>(
            title: 'Vendors',
            value:
                bilController.selectedVendorId.value.isNotEmpty
                    ? bilController.selectedVendorId.value
                    : null,
            items:
                bilController.vendors
                    .map(
                      (vendor) => DropdownMenuItem(
                        value: vendor.id,
                        child: Text('${vendor.name} (${vendor.contact})'),
                      ),
                    )
                    .toList(),
            onChanged: (vendorId) {
              if (vendorId != null) {
                bilController.selectedVendorId.value = vendorId;

                // Find selected vendor
                final selectedVendor = bilController.vendors.firstWhere(
                  (v) => v.id == vendorId,
                  orElse:
                      () => VendorData(
                        id: '',
                        name: '',
                        contact: '',
                        phonecode: '',
                        clientId: '',
                        createdBy: '',
                        createdAt: DateTime.now().toIso8601String(),
                        updatedAt: DateTime.now().toIso8601String(),
                      ),
                );

                // Update GST info
                bilController.isGstEnabled.value =
                    selectedVendor.taxNumber?.isNotEmpty ?? false;
                bilController.gstinController.text =
                    selectedVendor.taxNumber ?? '';
              }
            },
            isRequired: true,
          ),
          if (bilController.selectedVendorId.value.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Contact: ${bilController.vendors.firstWhere((c) => c.id == bilController.selectedVendorId.value).contact}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      );
    });
  }

  void _addProductItem() {
    setState(() {
      bilController.selectedProducts.add(null);
      bilController.quantityControllers.add(TextEditingController(text: '1'));
      bilController.unitPriceControllers.add(TextEditingController(text: '0'));
      bilController.itemDiscountControllers.add(
        TextEditingController(text: '0'),
      );
      bilController.itemGstControllers.add(TextEditingController(text: '0'));
      bilController.itemDiscountTypes.add('percentage');
    });
  }

  String? _getCurrencyValue() {
    if (bilController.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (bilController.currencies.isNotEmpty) {
      bool currencyExists = bilController.currencies.any(
        (c) => c.id == bilController.currency.value,
      );
      if (currencyExists) {
        return bilController.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return bilController.currencies.first.id;
      }
    }
  }

  void _updateCurrencyDetails(String currencyId) {
    // First check if we have currencies from API
    if (bilController.currencies.isNotEmpty) {
      final selectedCurrency = bilController.currencies.firstWhereOrNull(
        (c) => c.id == currencyId,
      );
      if (selectedCurrency != null) {
        setState(() {
          bilController.currency.value = currencyId;
          bilController.currencyCode.value = selectedCurrency.currencyCode;
          bilController.currencyIcon.value = selectedCurrency.currencyIcon;
        });
        return;
      }
    }
  }

  void _removeProductItem(int index) {
    if (bilController.selectedProducts.length > 1) {
      setState(() {
        bilController.selectedProducts.removeAt(index);
        bilController.quantityControllers[index].dispose();
        bilController.quantityControllers.removeAt(index);
        bilController.unitPriceControllers[index].dispose();
        bilController.unitPriceControllers.removeAt(index);
        bilController.itemDiscountControllers[index].dispose();
        bilController.itemDiscountControllers.removeAt(index);
        bilController.itemGstControllers[index].dispose();
        bilController.itemGstControllers.removeAt(index);
        bilController.itemDiscountTypes.removeAt(index);
      });
    }
  }

  int roundFigure(double num) {
    return num >= 0 ? (num + 0.5).floor() : (num - 0.5).ceil();
  }

  Widget _buildProductField(int index) {
    if (bilController.isLoadingProducts.value) {
      return const Center(child: CircularProgressIndicator());
    }
    final stockProduct = bilController.products.where(
      (p0) => p0!.stockQuantity! > 0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CrmDropdownField<Data>(
                title: 'Product ${index + 1}',
                value:
                    index < bilController.selectedProducts.length
                        ? bilController.selectedProducts[index]
                        : null,
                items:
                    stockProduct
                        .map(
                          (product) => DropdownMenuItem<Data>(
                            value: product,
                            child: Text(
                              '${product!.name} (Stock: ${product.stockQuantity})',
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (product) {
                  if (product != null) {
                    setState(() {
                      if (index >= bilController.selectedProducts.length) {
                        bilController.selectedProducts.add(product);
                      } else {
                        bilController.selectedProducts[index] = product;
                      }
                      bilController.unitPriceControllers[index].text =
                          product.sellingPrice.toString();

                      // Reset quantity if current quantity exceeds stock
                      final currentQty =
                          int.tryParse(
                            bilController.quantityControllers[index].text,
                          ) ??
                          0;
                      if (currentQty > product.stockQuantity) {
                        bilController.quantityControllers[index].text =
                            product.stockQuantity.toString();
                        CrmSnackBar.showAwesomeSnackbar(
                          title: 'Notice',
                          message:
                              'Quantity adjusted to available stock: ${product.stockQuantity}',
                          contentType: ContentType.help,
                        );
                      }
                    });
                  }
                },
                isRequired: true,
              ),
            ),
            if (bilController.selectedProducts.length > 1)
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _removeProductItem(index),
                color: Colors.red,
              ),
          ],
        ),
        if (index < bilController.selectedProducts.length &&
            bilController.selectedProducts[index] != null) ...[
          const SizedBox(height: 8),
          Text(
            'Available Stock: ${(bilController.selectedProducts[index]!.stockQuantity)! - (int.tryParse(bilController.quantityControllers[index].text) ?? 0)}',
            style: TextStyle(
              color:
                  bilController.selectedProducts[index]!.stockQuantity! < 10
                      ? Colors.red
                      : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildQuantityField(index)),
            const SizedBox(width: 16),
            Expanded(
              child: CrmTextField(
                controller: bilController.unitPriceControllers[index],
                title: 'Unit Price (${bilController.currencyIcon.value})',
                hintText: 'Enter unit price',
                keyboardType: TextInputType.number,
                isRequired: true,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter unit price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Price must be greater than 0';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CrmTextField(
                controller: bilController.itemDiscountControllers[index],
                title: 'Discount',
                hintText: 'Enter discount',
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {}),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CrmDropdownField<String>(
                title: 'Discount Type',
                value: bilController.itemDiscountTypes[index],
                items: const [
                  DropdownMenuItem(
                    value: 'percentage',
                    child: Text('Percentage'),
                  ),
                  DropdownMenuItem(value: 'fixed', child: Text('Fixed Amount')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(
                      () => bilController.itemDiscountTypes[index] = value,
                    );
                  }
                },
              ),
            ),
          ],
        ),
        _buildGstField(index),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subtotal: ${bilController.currencyIcon.value}${_calculateItemSubtotal(index).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12),
            ),
            if (_calculateItemDiscount(index) > 0)
              Text(
                'Discount: -${bilController.currencyIcon.value}${_calculateItemDiscount(index).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            if (bilController.isGstEnabled.value &&
                _calculateItemGst(index) > 0)
              Text(
                'GST: ${bilController.currencyIcon.value}${_calculateItemGst(index).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, color: Colors.blue),
              ),
            const SizedBox(height: 4),
            Text(
              'Item Total: ${bilController.currencyIcon.value}${_calculateItemTotal(index).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityField(int index) {
    return CrmTextField(
      controller: bilController.quantityControllers[index],
      title: 'Quantity',
      hintText: 'Enter quantity',
      keyboardType: TextInputType.number,
      isRequired: true,
      onChanged: (value) {
        setState(() {
          if (bilController.selectedProducts[index] != null) {
            final quantity = int.tryParse(value) ?? 0;
            if (quantity >
                bilController.selectedProducts[index]!.stockQuantity!) {
              CrmSnackBar.showAwesomeSnackbar(
                title: 'Warning',
                message:
                    'Available stock: ${bilController.selectedProducts[index]!.stockQuantity}',
                contentType: ContentType.warning,
              );
            }
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter quantity';
        }
        final quantity = int.tryParse(value);
        if (quantity == null) {
          return 'Please enter a valid number';
        }
        if (quantity <= 0) {
          return 'Quantity must be greater than 0';
        }
        if (bilController.selectedProducts[index] != null &&
            quantity > bilController.selectedProducts[index]!.stockQuantity!) {
          return 'Insufficient stock (Available: ${bilController.selectedProducts[index]!.stockQuantity})';
        }
        return null;
      },
    );
  }

  Widget _buildGstField(int index) {
    if (!bilController.isGstEnabled.value) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CrmDropdownField<double>(
                title: 'GST Rate (%)',
                value: double.tryParse(
                  bilController.itemGstControllers[index].text,
                ),
                items:
                    bilController.gstRates
                        .map(
                          (rate) => DropdownMenuItem(
                            value: rate,
                            child: Text('$rate%'),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      bilController.itemGstControllers[index].text =
                          value.toString();
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'GST Amount: ${bilController.currencyIcon.value}${_calculateItemGst(index).toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String title,
    required DateTime date,
    required Function(DateTime?) onChanged,
  }) {
    return CrmTextField(
      title: title,
      controller: TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(date),
      ),
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        onChanged(picked);
      },
    );
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    for (int i = 0; i < bilController.selectedProducts.length; i++) {
      subtotal += _calculateItemSubtotal(i);
    }
    return subtotal;
  }

  double _calculateTotalDiscount() {
    double totalDiscount = 0;
    for (int i = 0; i < bilController.selectedProducts.length; i++) {
      totalDiscount += _calculateItemDiscount(i);
    }
    return totalDiscount +
        (double.tryParse(bilController.discountController.value.text) ?? 0);
  }

  double _calculateTotalGst() {
    if (!bilController.isGstEnabled.value) return 0;

    double totalGst = 0;
    for (int i = 0; i < bilController.selectedProducts.length; i++) {
      totalGst += _calculateItemGst(i);
    }
    return totalGst;
  }

  double _calculateTotal() {
    return _calculateSubtotal() -
        _calculateTotalDiscount() +
        _calculateTotalGst();
  }

  double _calculateItemSubtotal(int index) {
    final quantity =
        int.tryParse(bilController.quantityControllers[index].text) ?? 0;
    final unitPrice =
        double.tryParse(bilController.unitPriceControllers[index].text) ?? 0;
    return quantity * unitPrice;
  }

  double _calculateItemDiscount(int index) {
    final subtotal = _calculateItemSubtotal(index);
    final discount =
        double.tryParse(bilController.itemDiscountControllers[index].text) ?? 0;

    if (bilController.itemDiscountTypes[index] == 'percentage') {
      return subtotal * discount / 100;
    } else {
      return discount;
    }
  }

  bool _validateStockQuantity(Data product, int requestedQuantity) {
    return requestedQuantity <= product.stockQuantity!;
  }

  double _calculateItemGst(int index) {
    if (!bilController.isGstEnabled.value) return 0;

    final subtotal = _calculateItemSubtotal(index);
    final discount = _calculateItemDiscount(index);
    final gstRate =
        double.tryParse(bilController.itemGstControllers[index].text) ?? 0;

    return (subtotal - discount) * gstRate / 100;
  }

  double _calculateItemTotal(int index) {
    final subtotal = _calculateItemSubtotal(index);
    final discount = _calculateItemDiscount(index);
    final gst = _calculateItemGst(index);

    return subtotal - discount + gst;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BillingController>();

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Bill'),
          leading: Hero(
            tag: 'back_button_create',
            child: const CrmBackButton(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: bilController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVendorField(),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Obx(
                      () => CrmDropdownField<String>(
                        title: 'Currency',
                        value: _getCurrencyValue(),
                        items:
                            bilController.isLoadingCurrencies.value &&
                                    bilController.currenciesLoaded.value
                                ? [
                                  DropdownMenuItem(
                                    value: bilController.currency.value,
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
                                : bilController.currencies.isNotEmpty
                                ? bilController.currencies
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
                              !(bilController.isLoadingCurrencies.value &&
                                  bilController.currenciesLoaded.value)) {
                            _updateCurrencyDetails(value);
                          }
                        },
                        onMenuOpened: () {
                          // Load currencies if they haven't been loaded yet or if we're not currently loading
                          if (!bilController.isLoadingCurrencies.value) {
                            bilController.loadCurrencies();
                          }
                        },
                        isRequired: true,
                      ),
                    ),
                    // Don't show loading indicator at all - it causes confusion
                    // when static values are shown with a loading indicator
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Enable GST',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Switch(
                      value: bilController.isGstEnabled.value,
                      onChanged: (value) {
                        setState(() {
                          bilController.isGstEnabled.value = value;
                          if (!value) {
                            bilController.gstinController.clear();
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...bilController.selectedProducts.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Column(
                    children: [
                      _buildProductField(index),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
                ElevatedButton.icon(
                  onPressed: _addProductItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Another Product'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        title: 'Bill Date',
                        date: bilController.billDate.value,
                        onChanged: (date) {
                          if (date != null) {
                            setState(() => bilController.billDate.value = date);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CrmDropdownField<String>(
                  title: 'Payment Status',
                  value: bilController.paymentStatus.value,
                  items: const [
                    DropdownMenuItem(value: 'unpaid', child: Text('Unpaid')),
                    DropdownMenuItem(value: 'paid', child: Text('Paid')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => bilController.paymentStatus.value = value);
                    }
                  },
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Bill Summary',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:'),
                          Text(
                            '${bilController.currencyIcon.value}${_calculateSubtotal().toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      if (_calculateTotalDiscount() > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Discount:'),
                            Text(
                              '-${bilController.currencyIcon.value}${_calculateTotalDiscount().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (bilController.isGstEnabled.value &&
                          _calculateTotalGst() > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total GST:'),
                            Text(
                              '${bilController.currencyIcon.value}${_calculateTotalGst().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total:',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${bilController.currencyIcon.value}${_calculateTotal().toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Obx(
                  () => CrmButton(
                    width: Get.width - 40,
                    title:
                        controller.isLoading.value
                            ? 'Creating...'
                            : 'Create Bill',
                    onTap: () {
                      _createBill();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createBill() async {
    final controller = Get.find<BillingController>();
    controller.isLoading.value = true;
    if (bilController.formKey.currentState?.validate() ?? false) {
      if (bilController.selectedVendorId.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Please select a customer',
          contentType: ContentType.failure,
        );
        return;
      }

      if (bilController.selectedProducts.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Please select a Product',
          contentType: ContentType.failure,
        );
        return;
      }

      // Validate all products are selected
      for (int i = 0; i < bilController.selectedProducts.length; i++) {
        if (bilController.selectedProducts[i] == null) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message: 'Please select product_service ${i + 1}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      // Validate stock quantities
      for (int i = 0; i < bilController.selectedProducts.length; i++) {
        final quantity = int.parse(bilController.quantityControllers[i].text);
        if (!_validateStockQuantity(
          bilController.selectedProducts[i]!,
          quantity,
        )) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message:
                'Insufficient stock for ${bilController.selectedProducts[i]!.name}. Available: ${bilController.selectedProducts.value[i]!.stockQuantity}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      final controller = Get.find<BillingController>();

      final subtotal = _calculateSubtotal();
      final total = _calculateTotal();

      final items = List.generate(bilController.selectedProducts.length, (i) {
        return BillingItem(
          amount: _calculateItemTotal(i),
          hsnSac: bilController.selectedProducts[i]!.hsnSac!,
          discount: double.parse(bilController.itemDiscountControllers[i].text),
          quantity: double.parse(bilController.quantityControllers[i].text),

          productId: bilController.selectedProducts[i]!.id!,
          taxAmount: _calculateItemGst(i),
          unitPrice: double.parse(bilController.unitPriceControllers[i].text),
          discountType: bilController.itemDiscountTypes[i],
          discountAmount: _calculateItemDiscount(i),
          taxName: "",
        );
      });

      //
      final data = BillingData(
        vendor: bilController.selectedVendorId.value,
        amount: total,
        billNumber: "BILL#98",
        billDate: bilController.billDate.value.toIso8601String(),
        tax: _calculateTotalGst(),
        subTotal: _calculateSubtotal(),
        status: bilController.paymentStatus.value,
        overallTaxAmount: 0,
        discount: _calculateTotalDiscount(),
        total: _calculateTotal(),
        billStatus: bilController.paymentStatus.value,
        currency: bilController.currency.value,
        currencyCode: bilController.currencyCode.value,
        currencyIcon: bilController.currencyIcon.value,
        items: items,
      );

      try {
        final success = await controller.createBill(
          data,
          bilController.userId.value,
        );

        if (success) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Success',
            message: 'Invoice created successfully!',
            contentType: ContentType.success,
          );

          Get.back();
        }
      } catch (e) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to create invoice: ${e.toString()}',
          contentType: ContentType.failure,
        );
      } finally {
        controller.isLoading.value = false;
      }
    }
  }
}
