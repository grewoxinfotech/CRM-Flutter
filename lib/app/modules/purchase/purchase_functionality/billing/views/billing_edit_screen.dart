import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/network/purchase/billing/model/billing_model.dart';
import '../../../../../data/network/purchase/vendor/model/vendor_model.dart';
import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/billing_controller.dart';
import '../controllers/add_bill_controller.dart';

class BillingEditPage extends StatefulWidget {
  final BillingData billingData;

  const BillingEditPage({Key? key, required this.billingData})
    : super(key: key);

  @override
  State<BillingEditPage> createState() => _BillingEditPageState();
}

class _BillingEditPageState extends State<BillingEditPage> {
  final bilController = Get.put(BillCreateController());

  @override
  void initState() {
    super.initState();
    _loadBillingData();
  }

  // Future<void> _loadBillingData() async {
  //   // Vendor
  //   bilController.selectedVendorId.value = widget.billingData.vendor!;
  //
  //   // Load products first
  //   await bilController
  //       .loadProducts(); // Make sure this fetches `bilController.products`
  //
  //   // Products
  //   bilController.selectedProducts.value =
  //       widget.billingData.items!
  //           .map(
  //             (e) => bilController.products.firstWhereOrNull(
  //               (p) => p!.id == e.productId,
  //             ),
  //           )
  //           .toList();
  //   bilController.quantityControllers =
  //       widget.billingData.items!
  //           .map((e) => TextEditingController(text: e.quantity.toString()))
  //           .toList();
  //   bilController.unitPriceControllers =
  //       widget.billingData.items!
  //           .map((e) => TextEditingController(text: e.unitPrice.toString()))
  //           .toList();
  //   bilController.itemDiscountControllers =
  //       widget.billingData.items!
  //           .map((e) => TextEditingController(text: e.discount.toString()))
  //           .toList();
  //   bilController.itemDiscountTypes.value =
  //       widget.billingData.items!.map((e) => e.discountType!).toList();
  //   bilController.itemGstControllers =
  //       widget.billingData.items!
  //           .map((e) => TextEditingController(text: e.taxAmount.toString()))
  //           .toList();
  //
  //   // Currency
  //   bilController.currency.value = widget.billingData.currency!;
  //   if (widget.billingData.currency != null) {
  //     final selectedCurrency = bilController.currencies.firstWhereOrNull(
  //       (c) => c.id == widget.billingData.currency,
  //     );
  //     if (selectedCurrency != null) {
  //       bilController.currencyCode.value = selectedCurrency.currencyCode;
  //       bilController.currencyIcon.value = selectedCurrency.currencyIcon;
  //     }
  //   }
  //
  //   // Other fields
  //   bilController.billDate.value = DateTime.parse(widget.billingData.billDate!);
  //   bilController.paymentStatus.value = widget.billingData.status!;
  //   bilController.isGstEnabled.value = widget.billingData.tax! > 0;
  // }

  Future<void> _loadBillingData() async {
    bilController.selectedVendorId.value = widget.billingData.vendor!;

    // 1️⃣ Load products first and wait for them
    await bilController.loadProducts();

    // 2️⃣ After products are loaded, map selectedProducts
    final loadedProducts =
        widget.billingData.items!
            .map(
              (e) => bilController.products.firstWhereOrNull(
                (p) => p!.id?.toLowerCase() == e.productId?.toLowerCase(),
              ),
            )
            .toList();
    print(
      "[DEBUG] Loaded Products: ${loadedProducts.map((e) => e?.id).join(", ")}",
    );

    // 3️⃣ Initialize controllers for quantities, prices, discount, GST
    bilController.quantityControllers =
        widget.billingData.items!
            .map(
              (e) =>
                  TextEditingController(text: e.quantity!.toInt().toString()),
            )
            .toList();

    bilController.unitPriceControllers =
        widget.billingData.items!
            .map((e) => TextEditingController(text: e.unitPrice.toString()))
            .toList();

    bilController.itemDiscountControllers =
        widget.billingData.items!
            .map((e) => TextEditingController(text: e.discount.toString()))
            .toList();

    bilController.itemDiscountTypes.value =
        widget.billingData.items!.map((e) => e.discountType!).toList();

    bilController.itemGstControllers =
        widget.billingData.items!
            .map((e) => TextEditingController(text: e.taxAmount.toString()))
            .toList();

    // 4️⃣ Only now update the observable list and trigger UI
    bilController.selectedProducts.value = loadedProducts;

    // 5️⃣ Other fields
    bilController.currency.value = widget.billingData.currency!;
    bilController.billDate.value = DateTime.parse(widget.billingData.billDate!);
    bilController.paymentStatus.value = widget.billingData.status!;
    bilController.isGstEnabled.value = widget.billingData.tax! > 0;

    if (widget.billingData.currency != null) {
      final selectedCurrency = bilController.currencies.firstWhereOrNull(
        (c) => c.id == widget.billingData.currency,
      );
      if (selectedCurrency != null) {
        bilController.currencyCode.value = selectedCurrency.currencyCode;
        bilController.currencyIcon.value = selectedCurrency.currencyIcon;
      }
    }

    // Force rebuild so UI updates immediately
    setState(() {});
  }

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

  Widget _buildBillSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bill Summary',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
          if (bilController.isGstEnabled.value && _calculateTotalGst() > 0) ...[
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${bilController.currencyIcon.value}${_calculateTotal().toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // You can reuse all the methods (_buildVendorField, _buildProductField, etc.) from create screen

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BillingController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bill'),
        leading: const CrmBackButton(),
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
              // Currency Dropdown
              Obx(() {
                return CrmDropdownField<String>(
                  title: 'Currency',
                  value: bilController.currency.value,
                  items:
                      bilController.currencies
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(
                                '${c.currencyName} (${c.currencyIcon})',
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => bilController.currency.value = value);
                    }
                  },
                );
              }),
              const SizedBox(height: 16),
              // GST Switch
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Enable GST',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Obx(
                    () => Switch(
                      value: bilController.isGstEnabled.value,
                      onChanged: (val) {
                        setState(() => bilController.isGstEnabled.value = val);
                      },
                    ),
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
              _buildDateField(
                title: 'Bill Date',
                date: bilController.billDate.value,
                onChanged: (date) {
                  if (date != null) {
                    setState(() => bilController.billDate.value = date);
                  }
                },
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
                  if (value != null)
                    setState(() => bilController.paymentStatus.value = value);
                },
              ),
              const SizedBox(height: 16),
              _buildBillSummary(),
              const SizedBox(height: 24),
              Obx(
                () => CrmButton(
                  width: Get.width - 40,
                  title:
                      controller.isLoading.value
                          ? 'Updating...'
                          : 'Update Bill',
                  onTap: _updateBill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateBill() async {
    final controller = Get.find<BillingController>();
    controller.isLoading.value = true;

    if (bilController.formKey.currentState?.validate() ?? false) {
      // Create updated items list
      final items = List.generate(bilController.selectedProducts.length, (i) {
        return BillingItem(
          productId: bilController.selectedProducts[i]!.id!,
          quantity: double.parse(bilController.quantityControllers[i].text),
          unitPrice: double.parse(bilController.unitPriceControllers[i].text),
          discount: double.parse(bilController.itemDiscountControllers[i].text),
          discountType: bilController.itemDiscountTypes[i],
          discountAmount: _calculateItemDiscount(i),
          taxAmount: _calculateItemGst(i),
          amount: _calculateItemTotal(i),
          hsnSac: bilController.selectedProducts[i]!.hsnSac!,
          taxName: '',
        );
      });

      final data = BillingData(
        id: widget.billingData.id,
        vendor: bilController.selectedVendorId.value,
        amount: _calculateTotal(),
        billNumber: widget.billingData.billNumber,
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
        final success = await controller.updateBill(
          widget.billingData.id!,
          data,
        );
        if (success) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Success',
            message: 'Bill updated successfully!',
            contentType: ContentType.success,
          );
          Get.back();
        }
      } catch (e) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update bill: $e',
          contentType: ContentType.failure,
        );
      } finally {
        controller.isLoading.value = false;
      }
    }
  }
}
