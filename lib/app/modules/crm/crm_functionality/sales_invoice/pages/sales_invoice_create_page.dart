import 'package:crm_flutter/app/data/network/sales_invoice/controller/sales_invoice_controller.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_item_model.dart';
import 'package:crm_flutter/app/data/network/system/currency/model/currency_model.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/sales_invoice/controller/sales_invoice_create_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';
import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../data/network/sales/product_service/service/product_service.dart';
import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
import '../../../../../data/network/system/currency/service/currency_service.dart';

class SalesInvoiceCreatePage extends StatefulWidget {
  final SalesInvoice? salesInvoice;
  final String dealId;
  final bool isFromEdit;

  const SalesInvoiceCreatePage({
    Key? key,
    required this.dealId,
    this.isFromEdit = false,
    this.salesInvoice,
  }) : super(key: key);

  @override
  State<SalesInvoiceCreatePage> createState() => _SalesInvoiceCreatePageState();
}

class _SalesInvoiceCreatePageState extends State<SalesInvoiceCreatePage> {
  final SalesInvoiceCreateController createController = Get.put(
    SalesInvoiceCreateController(),
  );

  void _updateCurrencyDetails(String currencyId) {
    // First check if we have currencies from API
    if (createController.currencies.isNotEmpty) {
      final selectedCurrency = createController.currencies.firstWhereOrNull(
        (c) => c.id == currencyId,
      );
      if (selectedCurrency != null) {
        setState(() {
          createController.currency.value = currencyId;
          createController.currencyCode.value = selectedCurrency.currencyCode;
          createController.currencyIcon.value = selectedCurrency.currencyIcon;
        });
        return;
      }
    }

    // Fallback to static currencies if API currencies not available
    final staticCurrencyDetails = {
      'AHNTpSNJHMypuNF6iPcMLrz': {'code': 'INR', 'icon': '₹'},
      'BHNTpSNJHMypuNF6iPcMLr2': {'code': 'USD', 'icon': '\$'},
      'CHNTpSNJHMypuNF6iPcMLr3': {'code': 'EUR', 'icon': '€'},
    };

    final details = staticCurrencyDetails[currencyId];
    if (details != null) {
      setState(() {
        createController.currency.value = currencyId;
        createController.currencyCode.value = details['code'] ?? '';
        createController.currencyIcon.value = details['icon'] ?? '';
      });
    }
  }

  // Check if the current currency exists in the dropdown items
  String? _getCurrencyValue() {
    if (createController.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (createController.currencies.isNotEmpty) {
      bool currencyExists = createController.currencies.any(
        (c) => c.id == createController.currency.value,
      );
      if (currencyExists) {
        return createController.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return createController.currencies.first.id;
      }
    }

    // If using static currencies, check if current currency exists in static list
    final staticCurrencies = [
      'AHNTpSNJHMypuNF6iPcMLrz',
      'BHNTpSNJHMypuNF6iPcMLr2',
      'CHNTpSNJHMypuNF6iPcMLr3',
    ];
    if (staticCurrencies.contains(createController.currency.value)) {
      return createController.currency.value;
    } else {
      // Return default static currency if current currency doesn't exist
      return 'AHNTpSNJHMypuNF6iPcMLrz';
    }
  }

  void _addProductItem() {
    setState(() {
      createController.selectedProducts.add(null);
      createController.quantityControllers.add(
        TextEditingController(text: '1'),
      );
      createController.unitPriceControllers.add(
        TextEditingController(text: '0'),
      );
      createController.itemDiscountControllers.add(
        TextEditingController(text: '0'),
      );
      createController.itemGstControllers.add(TextEditingController(text: '0'));
      createController.itemDiscountTypes.add('percentage');
    });
  }

  double _calculateItemSubtotal(int index) {
    final quantity =
        int.tryParse(createController.quantityControllers[index].text) ?? 0;
    final unitPrice =
        double.tryParse(createController.unitPriceControllers[index].text) ?? 0;
    return quantity * unitPrice;
  }

  double _calculateItemDiscount(int index) {
    final subtotal = _calculateItemSubtotal(index);
    final discount =
        double.tryParse(createController.itemDiscountControllers[index].text) ??
        0;

    if (createController.itemDiscountTypes[index] == 'percentage') {
      return subtotal * discount / 100;
    } else {
      return discount;
    }
  }

  double _calculateItemGst(int index) {
    if (!createController.isGstEnabled.value) return 0;

    final subtotal = _calculateItemSubtotal(index);
    final discount = _calculateItemDiscount(index);
    final gstRate =
        double.tryParse(createController.itemGstControllers[index].text) ?? 0;

    return (subtotal - discount) * gstRate / 100;
  }

  double _calculateItemTotal(int index) {
    final subtotal = _calculateItemSubtotal(index);
    final discount = _calculateItemDiscount(index);
    final gst = _calculateItemGst(index);

    return subtotal - discount + gst;
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    for (int i = 0; i < createController.selectedProducts.length; i++) {
      subtotal += _calculateItemSubtotal(i);
    }
    return subtotal;
  }

  double _calculateTotalDiscount() {
    double totalDiscount = 0;
    for (int i = 0; i < createController.selectedProducts.length; i++) {
      totalDiscount += _calculateItemDiscount(i);
    }
    return totalDiscount +
        (double.tryParse(createController.discountController.text) ?? 0);
  }

  double _calculateTotalGst() {
    if (!createController.isGstEnabled.value) return 0;

    double totalGst = 0;
    for (int i = 0; i < createController.selectedProducts.length; i++) {
      totalGst += _calculateItemGst(i);
    }
    return totalGst;
  }

  double _calculateTotal() {
    return _calculateSubtotal() -
        _calculateTotalDiscount() +
        _calculateTotalGst();
  }

  bool _validateStockQuantity(Data product, int requestedQuantity) {
    return requestedQuantity <= product.stockQuantity!;
    ;
  }

  Widget _buildCustomerField() {
    return Obx(() {
      if (createController.isLoadingCustomers.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrmDropdownField<String>(
            title: 'Customer',
            value:
                createController.selectedCustomerId.value.isNotEmpty
                    ? createController.selectedCustomerId.value
                    : null,
            items:
                createController.customers
                    .map(
                      (customer) => DropdownMenuItem(
                        value: customer.id,
                        child: Text('${customer.name} (${customer.contact})'),
                      ),
                    )
                    .toList(),
            onChanged: (customerId) {
              if (customerId != null) {
                createController.selectedCustomerId.value = customerId;

                final selectedCustomer = createController.customers.firstWhere(
                  (c) => c.id == customerId,
                  orElse:
                      () => SalesCustomer(
                        id: '',
                        name: '',
                        contact: '',
                        phonecode: '',
                        clientId: '',
                        createdBy: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                );

                // Enable GST if customer has tax number
                createController.isGstEnabled.value =
                    selectedCustomer.taxNumber?.isNotEmpty ?? false;
                createController.gstinController.text =
                    selectedCustomer.taxNumber ?? '';
              }
            },
            isRequired: true,
          ),
          if (createController.selectedCustomerId.value.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Contact: ${createController.customers.firstWhere((c) => c.id == createController.selectedCustomerId.value).contact}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      );
    });
  }

  Widget _buildGstField(int index) {
    if (!createController.isGstEnabled.value) return const SizedBox.shrink();

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
                  createController.itemGstControllers[index].text,
                ),
                items:
                    createController.gstRates
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
                      createController.itemGstControllers[index].text =
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
          'GST Amount: ${createController.currencyIcon.value}${_calculateItemGst(index).toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProductField(int index) {
    if (createController.isLoadingProducts.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final stockProduct = createController.products.where(
      (p0) => p0!.stockQuantity! > 0,
    );

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CrmDropdownField<Data>(
                  title: 'Product ${index + 1}',
                  value:
                      index < createController.selectedProducts.length
                          ? createController.selectedProducts[index]
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
                        if (index >= createController.selectedProducts.length) {
                          createController.selectedProducts.add(product);
                        } else {
                          createController.selectedProducts[index] = product;
                        }
                        createController.unitPriceControllers[index].text =
                            product.sellingPrice.toString();

                        // Reset quantity if current quantity exceeds stock
                        final currentQty =
                            int.tryParse(
                              createController.quantityControllers[index].text,
                            ) ??
                            0;
                        if (currentQty > product.stockQuantity) {
                          createController.quantityControllers[index].text =
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
              if (createController.selectedProducts.length > 1)
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => createController.removeProductItem(index),
                  color: Colors.red,
                ),
            ],
          ),
          if (index < createController.selectedProducts.length &&
              createController.selectedProducts[index] != null) ...[
            const SizedBox(height: 8),
            Text(
              'Available Stock: ${createController.selectedProducts[index]!.stockQuantity}',
              style: TextStyle(
                color:
                    createController.selectedProducts[index]!.stockQuantity! <
                            10
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
                  controller: createController.unitPriceControllers[index],
                  title: 'Unit Price (${createController.currencyIcon.value})',
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
                  controller: createController.itemDiscountControllers[index],
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
                  value: createController.itemDiscountTypes[index],
                  items: const [
                    DropdownMenuItem(
                      value: 'percentage',
                      child: Text('Percentage'),
                    ),
                    DropdownMenuItem(
                      value: 'fixed',
                      child: Text('Fixed Amount'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(
                        () => createController.itemDiscountTypes[index] = value,
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
                'Subtotal: ${createController.currencyIcon.value}${_calculateItemSubtotal(index).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12),
              ),
              if (_calculateItemDiscount(index) > 0)
                Text(
                  'Discount: -${createController.currencyIcon.value}${_calculateItemDiscount(index).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
              if (createController.isGstEnabled.value &&
                  _calculateItemGst(index) > 0)
                Text(
                  'GST: ${createController.currencyIcon.value}${_calculateItemGst(index).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
              const SizedBox(height: 4),
              Text(
                'Item Total: ${createController.currencyIcon.value}${_calculateItemTotal(index).toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityField(int index) {
    return CrmTextField(
      controller: createController.quantityControllers[index],
      title: 'Quantity',
      hintText: 'Enter quantity',
      keyboardType: TextInputType.number,
      isRequired: true,
      onChanged: (value) {
        setState(() {
          if (createController.selectedProducts[index] != null) {
            final quantity = int.tryParse(value) ?? 0;
            if (quantity >
                createController.selectedProducts[index]!.stockQuantity!) {
              CrmSnackBar.showAwesomeSnackbar(
                title: 'Warning',
                message:
                    'Available stock: ${createController.selectedProducts[index]!.stockQuantity}',
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
        if (createController.selectedProducts[index] != null &&
            quantity >
                createController.selectedProducts[index]!.stockQuantity!) {
          return 'Insufficient stock (Available: ${createController.selectedProducts[index]!.stockQuantity})';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SalesInvoiceController>();
    if (widget.isFromEdit && widget.salesInvoice != null) {
      final invoice = widget.salesInvoice!;
      print('Edit Invoice: ${invoice.toJson()}');
      // Customer
      createController.selectedCustomerId.value = invoice.customer ?? '';

      // Currency
      createController.getCurrencyById(invoice.currency!);

      // createController.currencyIcon.value = invoice.currencyIcon!;
      // createController.currencyCode.value = invoice.currencyCode!;

      // GST Enabled

      createController.isGstEnabled.value = (invoice.tax ?? 0) > 0;

      // if (invoice.items.isNotEmpty) {
      //   createController.selectedProducts.assignAll(
      //     invoice.items.map((e) => e.productId).toList(),
      //   );
      // }

      // Products
      createController.selectedProducts.assignAll(
        invoice.items
            .map(
              (e) => Data(
                name: e.name,
                id: e.productId,
                stockQuantity: e.quantity,
              ),
            )
            .toList(),
      );
      // createController.getProductsByIds(
      //   invoice.items.map((e) => e.productId).toList(),
      // );
      // final products = invoice.items.map((e) => e.productId).toList();
      // createController.selectedProducts.assignAll(products);

      // Quantity Controllers
      createController.quantityControllers.assignAll(
        invoice.items.map(
          (e) => TextEditingController(text: e.quantity.toString()),
        ),
      );

      // Unit Price Controllers
      createController.unitPriceControllers.assignAll(
        invoice.items.map(
          (e) => TextEditingController(text: e.unitPrice.toString()),
        ),
      );

      // Item Discount Controllers
      createController.itemDiscountControllers.assignAll(
        invoice.items.map(
          (e) => TextEditingController(text: e.discount.toString()),
        ),
      );

      // Item Discount Types
      createController.itemDiscountTypes.assignAll(
        invoice.items.map((e) => e.discountType ?? 'percentage'),
      );

      // Item GST Controllers
      createController.itemGstControllers.assignAll(
        invoice.items.map((e) => TextEditingController(text: e.tax.toString())),
      );

      // GST Controller
      createController.gstinController.text = invoice.gstin?.toString() ?? '0';

      // Payment status
      createController.paymentStatus.value = invoice.paymentStatus ?? '';

      // Subtotal, Discount, Total
      // createController.subtotalController.text = invoice.subTotal?.toString() ?? '0';
      // createController.discountController.text = invoice.discount?.toString() ?? '0';
      // createController.totalController.text = invoice.total?.toString() ?? '0';
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          // // Refresh the invoice list when popping back
          // if (mounted) {
          //   await controller.fetchInvoicesForDeal(widget.dealId);
          // }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Invoice'),
          leading: Hero(
            tag: 'back_button_create',
            child: const CrmBackButton(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: createController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCustomerField(),

                const SizedBox(height: 16),
                CrmTextField(
                  controller: createController.gstinController,
                  title: 'GSTIN',
                  hintText: 'Customer GST number',
                  readOnly: true,
                  // Make field non-editable
                  enabled: false, // Visually show it's disabled
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Stack(
                    children: [
                      CrmDropdownField<String>(
                        title: 'Currency',
                        value: _getCurrencyValue(),
                        enabled: widget.isFromEdit ? false : true,
                        items:
                            createController.isLoadingCurrencies.value &&
                                    createController.currenciesLoaded.value
                                ? [
                                  DropdownMenuItem(
                                    value: createController.currency.value,
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
                                : createController.currencies.isNotEmpty
                                ? createController.currencies
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
                              !(createController.isLoadingCurrencies.value &&
                                  createController.currenciesLoaded.value)) {
                            _updateCurrencyDetails(value);
                          }
                        },
                        onMenuOpened: () {
                          // Load currencies if they haven't been loaded yet or if we're not currently loading
                          if (!createController.isLoadingCurrencies.value) {
                            createController.loadCurrencies();
                          }
                        },
                        isRequired: true,
                      ),
                      // Don't show loading indicator at all - it causes confusion
                      // when static values are shown with a loading indicator
                    ],
                  ),
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
                      value: createController.isGstEnabled.value,
                      onChanged: (value) {
                        setState(() {
                          createController.isGstEnabled.value = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...createController.selectedProducts.asMap().entries.map((
                  entry,
                ) {
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
                        title: 'Issue Date',
                        date: createController.issueDate.value,
                        onChanged: (date) {
                          if (date != null) {
                            setState(
                              () => createController.issueDate.value = date,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField(
                        title: 'Due Date',
                        date: createController.dueDate.value,
                        onChanged: (date) {
                          if (date != null) {
                            setState(
                              () => createController.dueDate.value = date,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CrmDropdownField<String>(
                  title: 'Payment Status',
                  value: createController.paymentStatus.value,
                  items: const [
                    DropdownMenuItem(value: 'unpaid', child: Text('Unpaid')),
                    DropdownMenuItem(value: 'paid', child: Text('Paid')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(
                        () => createController.paymentStatus.value = value,
                      );
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
                        'Invoice Summary',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:'),
                          Text(
                            '${createController.currencyIcon.value}${_calculateSubtotal().toStringAsFixed(2)}',
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
                              '-${createController.currencyIcon.value}${_calculateTotalDiscount().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (createController.isGstEnabled.value &&
                          _calculateTotalGst() > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total GST:'),
                            Text(
                              '${createController.currencyIcon.value}${_calculateTotalGst().toStringAsFixed(2)}',
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
                            '${createController.currencyIcon.value}${_calculateTotal().toStringAsFixed(2)}',
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
                        widget.isFromEdit
                            ? controller.isLoading.value
                                ? 'Updating...'
                                : 'Update Invoice'
                            : controller.isLoading.value
                            ? 'Creating...'
                            : 'Create Invoice',
                    onTap: () {
                      controller.isLoading.value = true;
                      widget.isFromEdit
                          ? _updateInvoice(widget.salesInvoice!.id!)
                          : _createInvoice();
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

  Future<void> _createInvoice() async {
    if (createController.formKey.currentState?.validate() ?? false) {
      if (createController.selectedCustomerId.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Please select a customer',
          contentType: ContentType.failure,
        );
        return;
      }

      // Validate all products are selected
      for (int i = 0; i < createController.selectedProducts.length; i++) {
        if (createController.selectedProducts[i] == null) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message: 'Please select product_service ${i + 1}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      // Validate stock quantities
      for (int i = 0; i < createController.selectedProducts.length; i++) {
        final quantity = int.parse(
          createController.quantityControllers[i].text,
        );
        if (!_validateStockQuantity(
          createController.selectedProducts[i]!,
          quantity,
        )) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message:
                'Insufficient stock for ${createController.selectedProducts[i]!.name}. Available: ${createController.selectedProducts[i]!.stockQuantity}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      final controller = Get.find<SalesInvoiceController>();
      final subtotal = _calculateSubtotal();
      final total = _calculateTotal();

      final items = List.generate(createController.selectedProducts.length, (
        i,
      ) {
        return SalesInvoiceItem(
          total: total,
          amount: _calculateItemTotal(i),
          hsnSac: createController.selectedProducts[i]!.hsnSac!,
          discount: double.parse(
            createController.itemDiscountControllers[i].text,
          ),
          quantity: int.parse(createController.quantityControllers[i].text),
          subtotal: _calculateItemSubtotal(i),
          productId: createController.selectedProducts[i]!.id!,
          taxAmount: _calculateItemGst(i),
          unitPrice: double.parse(
            createController.unitPriceControllers[i].text,
          ),
          discountType: createController.itemDiscountTypes[i],
          discountAmount: _calculateItemDiscount(i),
          taxName: "",
          tax:
              createController.isGstEnabled.value
                  ? double.parse(createController.itemGstControllers[i].text)
                  : 0,
        );
      });

      final data = SalesInvoice(
        customer: createController.selectedCustomerId.value,
        issueDate: createController.issueDate.value,
        dueDate: createController.dueDate.value,
        discount: _calculateTotalDiscount(),
        tax: _calculateTotalGst(),
        subtotal: _calculateSubtotal(),
        total: _calculateTotal(),
        paymentStatus: createController.paymentStatus.value,
        currency: createController.currency.value,
        gstin:
            createController.isGstEnabled.value
                ? createController.gstinController.text
                : '',
        section: 'sales-invoice',
        currencyCode: createController.currencyCode.value,
        currencyIcon: createController.currencyIcon.value,
        items: items,
      );

      try {
        final success = await controller.createInvoice(data, widget.dealId);
        if (success) {
          // Refresh invoices list
          // await controller.fetchInvoicesForDeal(widget.dealId);

          Get.back();
        }
      } catch (e) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to create invoice: ${e.toString()}',
          contentType: ContentType.failure,
        );
      }
    }
  }

  Future<void> _updateInvoice(String invoiceId) async {
    if (createController.formKey.currentState?.validate() ?? false) {
      if (createController.selectedCustomerId.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Please select a customer',
          contentType: ContentType.failure,
        );
        return;
      }

      // Validate all products are selected
      for (int i = 0; i < createController.selectedProducts.length; i++) {
        if (createController.selectedProducts[i] == null) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message: 'Please select product_service ${i + 1}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      // Validate stock quantities
      for (int i = 0; i < createController.selectedProducts.length; i++) {
        final quantity = int.parse(
          createController.quantityControllers[i].text,
        );
        if (!_validateStockQuantity(
          createController.selectedProducts[i]!,
          quantity,
        )) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message:
                'Insufficient stock for ${createController.selectedProducts[i]!.name}. Available: ${createController.selectedProducts[i]!.stockQuantity}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      final controller = Get.find<SalesInvoiceController>();
      final subtotal = _calculateSubtotal();
      final total = _calculateTotal();

      final items = List.generate(createController.selectedProducts.length, (
        i,
      ) {
        return SalesInvoiceItem(
          total: total,
          // amount: _calculateItemTotal(i),
          amount: 10,
          // hsnSac: createController.selectedProducts[i]!.hsnSac!,
          hsnSac: "",
          discount: double.parse(
            createController.itemDiscountControllers[i].text,
          ),
          quantity: int.parse(createController.quantityControllers[i].text),
          subtotal: _calculateItemSubtotal(i),
          productId: createController.selectedProducts[i]!.id!,
          taxAmount: _calculateItemGst(i),
          unitPrice: double.parse(
            createController.unitPriceControllers[i].text,
          ),
          discountType: createController.itemDiscountTypes[i],
          discountAmount: _calculateItemDiscount(i),
          taxName: "",
          tax:
              createController.isGstEnabled.value
                  ? double.parse(createController.itemGstControllers[i].text)
                  : 0,
        );
      });

      final data = SalesInvoice(
        id: invoiceId, // Add this if your model supports it
        customer: createController.selectedCustomerId.value,
        issueDate: createController.issueDate.value,
        dueDate: createController.dueDate.value,
        discount: _calculateTotalDiscount(),
        tax: _calculateTotalGst(),
        subtotal: subtotal,
        total: total,
        paymentStatus: createController.paymentStatus.value,
        currency: createController.currency.value,
        gstin:
            createController.isGstEnabled.value
                ? createController.gstinController.text
                : '',
        section: 'sales-invoice',
        currencyCode: createController.currencyCode.value,
        currencyIcon: createController.currencyIcon.value,
        items: items,
        amount: 10,
      );

      try {
        // Convert SalesInvoice to Map<String, dynamic>
        final invoiceMap = data.toJson();

        final success = await controller.updateInvoice(invoiceId, invoiceMap);
        // Get.back();

        if (success) {
          // Optionally refresh the invoices list if needed
          // await controller.fetchInvoicesForDeal(widget.dealId);
          Get.back();
        }
      } catch (e) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update invoice: ${e.toString()}',
          contentType: ContentType.failure,
        );
      }
    }
  }
}
