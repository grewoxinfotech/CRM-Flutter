import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/controller/sales_invoice_controller.dart';
import 'package:crm_flutter/app/data/network/product/model/product_model.dart';
import 'package:crm_flutter/app/data/network/product/service/product_service.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';

class SalesInvoiceEditPage extends StatefulWidget {
  final SalesInvoice invoice;
  final String dealId;

  const SalesInvoiceEditPage({
    Key? key,
    required this.invoice,
    required this.dealId,
  }) : super(key: key);

  @override
  State<SalesInvoiceEditPage> createState() => _SalesInvoiceEditPageState();
}

class _SalesInvoiceEditPageState extends State<SalesInvoiceEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _productService = ProductService();
  final _customerService = SalesCustomerService();

  late String _selectedCustomerId;
  late List<SalesCustomer> _customers = [];
  bool _isLoadingCustomers = false;

  late TextEditingController _gstinController;
  late List<TextEditingController> _quantityControllers;
  late List<TextEditingController> _unitPriceControllers;
  late List<TextEditingController> _itemDiscountControllers;
  late List<TextEditingController> _itemGstControllers;
  late TextEditingController _taxController;
  late TextEditingController _discountController;
  late TextEditingController _additionalNotesController;
  late DateTime _issueDate;
  late DateTime _dueDate;
  late String _paymentStatus;
  late String _currency;
  late String _currencyCode;
  late String _currencyIcon;
  late List<String> _itemDiscountTypes;
  bool _isGstEnabled = false;
  
  List<Product> _products = [];
  List<Product?> _selectedProducts = [];
  bool _isLoadingProducts = false;

  final Map<String, Map<String, String>> _currencyDetails = {
    'AHNTpSNJHMypuNF6iPcMLrz': {'code': 'INR', 'icon': '₹'},
    'BHNTpSNJHMypuNF6iPcMLr2': {'code': 'USD', 'icon': '\$'},
    'CHNTpSNJHMypuNF6iPcMLr3': {'code': 'EUR', 'icon': '€'},
  };

  // Standard GST rates for reference
  final List<double> _gstRates = [0, 5, 12, 18, 28];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadProducts();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    setState(() => _isLoadingCustomers = true);
    try {
      final customers = await _customerService.getSalesCustomers();
      setState(() {
        _customers = customers;
        // Set the current customer and check for GST
        if (_selectedCustomerId.isNotEmpty) {
          final selectedCustomer = customers.firstWhere(
            (c) => c.id == _selectedCustomerId,
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
          _isGstEnabled = selectedCustomer.taxNumber?.isNotEmpty ?? false;
          _gstinController.text = selectedCustomer.taxNumber ?? '';
        }
      });
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load customers: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      setState(() => _isLoadingCustomers = false);
    }
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoadingProducts = true);
    try {
      final products = await _productService.getProducts();
      setState(() {
        _products = products;
        // Initialize selected products from invoice items
        _selectedProducts =
            widget.invoice.items.map((item) {
              return products.firstWhere(
                (p) => p.id == item.productId,
            orElse: () => products.first,
          );
            }).toList();
      });
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load products: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      setState(() => _isLoadingProducts = false);
    }
  }

  void _initializeControllers() {
    final items = widget.invoice.items;

    _selectedCustomerId = widget.invoice.customer;
    _gstinController = TextEditingController(text: '');
    _isGstEnabled =
        widget.invoice.tax > 0; // Set initial GST state based on tax value
    _quantityControllers =
        items
            .map(
              (item) => TextEditingController(text: item.quantity.toString()),
            )
            .toList();
    _unitPriceControllers =
        items
            .map(
              (item) => TextEditingController(text: item.unitPrice.toString()),
            )
            .toList();
    _itemDiscountControllers =
        items
            .map(
              (item) => TextEditingController(text: item.discount.toString()),
            )
            .toList();
    _itemGstControllers =
        items
            .map(
              (item) => TextEditingController(text: (item.tax ?? 0).toString()),
            )
            .toList();
    _itemDiscountTypes = items.map((item) => item.discountType).toList();

    _taxController = TextEditingController(text: widget.invoice.tax.toString());
    _discountController = TextEditingController(
      text: widget.invoice.discount.toString(),
    );
    _additionalNotesController = TextEditingController(
      text: widget.invoice.additionalNotes ?? '',
    );
    _issueDate = widget.invoice.issueDate;
    _dueDate = widget.invoice.dueDate;
    _paymentStatus = widget.invoice.paymentStatus.toLowerCase();
    _currency = widget.invoice.currency;

    // Set currency details
    final currencyDetails = _currencyDetails[_currency];
    if (currencyDetails != null) {
      _currencyCode = currencyDetails['code'] ?? '';
      _currencyIcon = currencyDetails['icon'] ?? '';
    } else {
      _currencyCode = 'INR';
      _currencyIcon = '₹';
    }
  }

  void _updateCurrencyDetails(String currencyId) {
    final details = _currencyDetails[currencyId];
    if (details != null) {
      setState(() {
        _currency = currencyId;
        _currencyCode = details['code'] ?? '';
        _currencyIcon = details['icon'] ?? '';
      });
    }
  }

  void _addProductItem() {
    setState(() {
      // Add a default product (first available) instead of null
      _selectedProducts.add(_products.isNotEmpty ? _products.first : null);
      _quantityControllers.add(TextEditingController(text: '1'));
      _unitPriceControllers.add(
        TextEditingController(
          text:
              _products.isNotEmpty
                  ? _products.first.sellingPrice.toString()
                  : '0',
        ),
      );
      _itemDiscountControllers.add(TextEditingController(text: '0'));
      _itemGstControllers.add(TextEditingController(text: '0'));
      _itemDiscountTypes.add('percentage');
    });
  }

  void _removeProductItem(int index) {
    if (_selectedProducts.length > 1) {
      setState(() {
        _selectedProducts.removeAt(index);

        // Dispose controllers to prevent memory leaks
        _quantityControllers[index].dispose();
        _unitPriceControllers[index].dispose();
        _itemDiscountControllers[index].dispose();
        _itemGstControllers[index].dispose();

        // Remove controllers
        _quantityControllers.removeAt(index);
        _unitPriceControllers.removeAt(index);
        _itemDiscountControllers.removeAt(index);
        _itemGstControllers.removeAt(index);
        _itemDiscountTypes.removeAt(index);
      });
    } else {
      // Show message if trying to remove last item
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Notice',
        message: 'Invoice must have at least one item',
        contentType: ContentType.help,
      );
    }
  }

  double _calculateItemSubtotal(int index) {
    final quantity = int.tryParse(_quantityControllers[index].text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceControllers[index].text) ?? 0;
    return quantity * unitPrice;
  }

  double _calculateItemDiscount(int index) {
    final subtotal = _calculateItemSubtotal(index);
    final discount = double.tryParse(_itemDiscountControllers[index].text) ?? 0;

    if (_itemDiscountTypes[index] == 'percentage') {
      return subtotal * discount / 100;
    } else {
      return discount;
    }
  }

  double _calculateItemGst(int index) {
    if (!_isGstEnabled) return 0;

    final subtotal = _calculateItemSubtotal(index);
    final discount = _calculateItemDiscount(index);
    final gstRate = double.tryParse(_itemGstControllers[index].text) ?? 0;

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
    for (int i = 0; i < _selectedProducts.length; i++) {
      subtotal += _calculateItemSubtotal(i);
    }
    return subtotal;
  }

  double _calculateTotalDiscount() {
    double totalDiscount = 0;
    for (int i = 0; i < _selectedProducts.length; i++) {
      totalDiscount += _calculateItemDiscount(i);
    }
    return totalDiscount + (double.tryParse(_discountController.text) ?? 0);
  }

  double _calculateTotalGst() {
    if (!_isGstEnabled) {
      return double.tryParse(_taxController.text) ?? 0;
    }

    double totalGst = 0;
    for (int i = 0; i < _selectedProducts.length; i++) {
      totalGst += _calculateItemGst(i);
    }

    // Update the tax controller with the calculated GST amount
    _taxController.text = totalGst.toStringAsFixed(2);
    return totalGst;
  }

  double _calculateTotal() {
    return _calculateSubtotal() -
        _calculateTotalDiscount() +
        _calculateTotalGst();
  }

  bool _validateStockQuantity(Product product, int requestedQuantity) {
    return requestedQuantity <= product.stockQuantity;
  }

  Widget _buildCustomerField() {
    if (_isLoadingCustomers) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CrmDropdownField<String>(
          title: 'Customer',
          value: _selectedCustomerId.isNotEmpty ? _selectedCustomerId : null,
          items:
              _customers
                  .map(
                    (customer) => DropdownMenuItem(
                      value: customer.id,
                      child: Text('${customer.name} (${customer.contact})'),
                    ),
                  )
                  .toList(),
          onChanged: (customerId) {
            if (customerId != null) {
              setState(() {
                _selectedCustomerId = customerId;
                // Auto-fill GSTIN when customer is selected
                final selectedCustomer = _customers.firstWhere(
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
                _isGstEnabled = selectedCustomer.taxNumber?.isNotEmpty ?? false;
                _gstinController.text = selectedCustomer.taxNumber ?? '';
              });
            }
          },
          isRequired: true,
        ),
        if (_selectedCustomerId.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Contact: ${_customers.firstWhere((c) => c.id == _selectedCustomerId).contact}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }

  Widget _buildProductField(int index) {
    if (_isLoadingProducts) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CrmDropdownField<Product>(
                title: 'Product ${index + 1}',
                value:
                    index < _selectedProducts.length
                        ? _selectedProducts[index]
                        : null,
                items:
                    _products
                        .map(
                          (product) => DropdownMenuItem(
                            value: product,
                            child: Text(
                              '${product.name} (Stock: ${product.stockQuantity})',
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (product) {
                  if (product != null) {
                    setState(() {
                      if (index >= _selectedProducts.length) {
                        _selectedProducts.add(product);
                      } else {
                        _selectedProducts[index] = product;
                      }
                      _unitPriceControllers[index].text =
                          product.sellingPrice.toString();

                      // Reset quantity if current quantity exceeds stock
                      final currentQty =
                          int.tryParse(_quantityControllers[index].text) ?? 0;
                      if (currentQty > product.stockQuantity) {
                        _quantityControllers[index].text =
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
            if (_selectedProducts.length > 1)
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _removeProductItem(index),
                color: Colors.red,
              ),
          ],
        ),
        if (index < _selectedProducts.length &&
            _selectedProducts[index] != null) ...[
          const SizedBox(height: 8),
          Text(
            'Available Stock: ${_selectedProducts[index]!.stockQuantity}',
            style: TextStyle(
              color:
                  _selectedProducts[index]!.stockQuantity < 10
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
                controller: _unitPriceControllers[index],
                title: 'Unit Price ($_currencyIcon)',
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
                controller: _itemDiscountControllers[index],
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
                value: _itemDiscountTypes[index],
                items: const [
                  DropdownMenuItem(
                    value: 'percentage',
                    child: Text('Percentage'),
                  ),
                  DropdownMenuItem(value: 'fixed', child: Text('Fixed Amount')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _itemDiscountTypes[index] = value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildGstField(index),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subtotal: $_currencyIcon${_calculateItemSubtotal(index).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12),
            ),
            if (_calculateItemDiscount(index) > 0)
              Text(
                'Discount: -$_currencyIcon${_calculateItemDiscount(index).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            if (_isGstEnabled && _calculateItemGst(index) > 0)
              Text(
                'GST: $_currencyIcon${_calculateItemGst(index).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, color: Colors.blue),
              ),
            const SizedBox(height: 4),
            Text(
              'Item Total: $_currencyIcon${_calculateItemTotal(index).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityField(int index) {
    return CrmTextField(
      controller: _quantityControllers[index],
      title: 'Quantity',
      hintText: 'Enter quantity',
      keyboardType: TextInputType.number,
      isRequired: true,
      onChanged: (value) {
        setState(() {
          if (_selectedProducts[index] != null) {
            final quantity = int.tryParse(value) ?? 0;
            if (quantity > _selectedProducts[index]!.stockQuantity) {
              CrmSnackBar.showAwesomeSnackbar(
                title: 'Warning',
                message:
                    'Available stock: ${_selectedProducts[index]!.stockQuantity}',
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
        if (_selectedProducts[index] != null &&
            quantity > _selectedProducts[index]!.stockQuantity) {
          return 'Insufficient stock (Available: ${_selectedProducts[index]!.stockQuantity})';
        }
        return null;
      },
    );
  }

  Widget _buildGstField(int index) {
    if (!_isGstEnabled) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CrmDropdownField<double>(
                title: 'GST Rate (%)',
                value: double.tryParse(_itemGstControllers[index].text),
                items:
                    _gstRates
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
                      _itemGstControllers[index].text = value.toString();
              });
            }
          },
              ),
            ),
          ],
        ),
          const SizedBox(height: 8),
          Text(
          'GST Amount: $_currencyIcon${_calculateItemGst(index).toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SalesInvoiceController>();

    return WillPopScope(
      onWillPop: () async {
        await controller.getSalesInvoicesByDealId(widget.dealId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Invoice'),
          leading: Hero(
            tag: 'back_button_${widget.invoice.id}',
            child: const CrmBackButton(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCustomerField(),
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
                      value: _isGstEnabled,
                      onChanged: (value) {
                        setState(() {
                          _isGstEnabled = value;
                          if (!value) {
                            _gstinController.clear();
                          }
                        });
                      },
                    ),
                  ],
                ),
                if (_isGstEnabled) ...[
                  const SizedBox(height: 16),
                  CrmTextField(
                    controller: _gstinController,
                    title: 'GSTIN',
                    hintText: 'Customer GST number',
                    readOnly: true, // Make field non-editable
                    enabled: false, // Visually show it's disabled
                  ),
                ],
                const SizedBox(height: 16),
                CrmDropdownField<String>(
                  title: 'Currency',
                  value: _currency,
                  items:
                      _currencyDetails.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(
                                '${entry.value['code']} (${entry.value['icon']})',
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _updateCurrencyDetails(value);
                    }
                  },
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                ..._selectedProducts.asMap().entries.map((entry) {
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
                        date: _issueDate,
                        onChanged: (date) {
                          if (date != null) {
                            setState(() => _issueDate = date);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField(
                        title: 'Due Date',
                        date: _dueDate,
                        onChanged: (date) {
                          if (date != null) {
                            setState(() => _dueDate = date);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CrmDropdownField<String>(
                  title: 'Payment Status',
                  value: _paymentStatus,
                  items: const [
                    DropdownMenuItem(value: 'unpaid', child: Text('Unpaid')),
                    DropdownMenuItem(value: 'paid', child: Text('Paid')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _paymentStatus = value);
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
                            '$_currencyIcon${_calculateSubtotal().toStringAsFixed(2)}',
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
                              '-$_currencyIcon${_calculateTotalDiscount().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (_isGstEnabled && _calculateTotalGst() > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total GST:'),
                            Text(
                              '$_currencyIcon${_calculateTotalGst().toStringAsFixed(2)}',
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
                            '$_currencyIcon${_calculateTotal().toStringAsFixed(2)}',
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
                            ? 'Updating...'
                            : 'Update Invoice',
                    onTap: controller.isLoading.value ? null : _updateInvoice,
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

  Future<void> _updateInvoice() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedCustomerId.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Please select a customer',
          contentType: ContentType.failure,
        );
        return;
      }

      // Validate all products are selected
      for (int i = 0; i < _selectedProducts.length; i++) {
        if (_selectedProducts[i] == null) {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message: 'Please select product ${i + 1}',
            contentType: ContentType.failure,
          );
          return;
        }
      }

      // Validate stock quantities
      for (int i = 0; i < _selectedProducts.length; i++) {
        final quantity = int.parse(_quantityControllers[i].text);
        if (!_validateStockQuantity(_selectedProducts[i]!, quantity)) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
            message:
                'Insufficient stock for ${_selectedProducts[i]!.name}. Available: ${_selectedProducts[i]!.stockQuantity}',
          contentType: ContentType.failure,
        );
        return;
        }
      }

      final controller = Get.find<SalesInvoiceController>();
      final subtotal = _calculateSubtotal();
      final total = _calculateTotal();

      final items = List.generate(
        _selectedProducts.length,
        (i) => {
          'product_id': _selectedProducts[i]!.id,
          'quantity': int.parse(_quantityControllers[i].text),
          'unit_price': double.parse(_unitPriceControllers[i].text),
          'tax': _isGstEnabled ? double.parse(_itemGstControllers[i].text) : 0,
          'tax_amount': _calculateItemGst(i),
          'discount': double.parse(_itemDiscountControllers[i].text),
          'discount_type': _itemDiscountTypes[i],
          'discount_amount': _calculateItemDiscount(i),
          'hsn_sac': _selectedProducts[i]!.hsnSac,
          'amount': _calculateItemTotal(i),
          'subtotal': _calculateItemSubtotal(i),
        },
      );
      
      final data = {
        'customer': _selectedCustomerId,
        'gstin': _isGstEnabled ? _gstinController.text : '',
        'section': 'sales-invoice',
        'issueDate': DateFormat('yyyy-MM-dd').format(_issueDate),
        'dueDate': DateFormat('yyyy-MM-dd').format(_dueDate),
        'currency': _currency,
        'currencyCode': _currencyCode,
        'currencyIcon': _currencyIcon,
        'items': items,
        'subtotal': _calculateSubtotal(),
        'total_tax': _calculateTotalGst(),
        'total_discount': _calculateTotalDiscount(),
        'total': _calculateTotal(),
        'payment_status': _paymentStatus,
      };

      try {
        final success = await controller.updateSalesInvoice(
          widget.invoice.id,
          data,
        );
        if (success) {
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
