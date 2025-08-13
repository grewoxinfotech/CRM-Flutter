import 'package:crm_flutter/app/data/network/sales_invoice/controller/sales_invoice_controller.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_item_model.dart';
import 'package:crm_flutter/app/data/network/system/currency/model/currency_model.dart';
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
  final String dealId;

  const SalesInvoiceCreatePage({Key? key, required this.dealId})
    : super(key: key);

  @override
  State<SalesInvoiceCreatePage> createState() => _SalesInvoiceCreatePageState();
}

class _SalesInvoiceCreatePageState extends State<SalesInvoiceCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _productService = ProductsServicesService();
  final _customerService = SalesCustomerService();
  final _currencyService = CurrencyService();

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

  List<Data?> _products = [];
  List<Data?> _selectedProducts = [];
  bool _isLoadingProducts = false;

  List<CurrencyModel> _currencies = [];
  bool _isLoadingCurrencies = false;
  bool _currenciesLoaded = false;

  // Standard GST rates for reference
  final List<double> _gstRates = [0, 5, 12, 18, 28];

  @override
  void initState() {
    super.initState();
    _initializeControllers();

    // Load data in the background without blocking UI
    _loadDataInBackground();
  }

  void _loadDataInBackground() {
    // Start loading data in parallel without waiting
    _loadProducts();
    _loadCustomers();

    // Don't load currencies immediately - will load when dropdown is opened
    // This improves initial page load time
  }

  Future<void> _loadCurrencies() async {
    // Prevent multiple simultaneous API calls
    if (_isLoadingCurrencies) return;

    // Set loading flag
    setState(() => _isLoadingCurrencies = true);

    try {
      final currencies = await _currencyService.getCurrencies();
      if (mounted) {
        setState(() {
          _currencies = currencies;
          _currenciesLoaded = true;

          // Update currency details if we have currencies in the list
          if (currencies.isNotEmpty) {
            final selectedCurrency = currencies.firstWhereOrNull(
              (c) => c.id == _currency,
            );
            if (selectedCurrency != null) {
              _currencyCode = selectedCurrency.currencyCode;
              _currencyIcon = selectedCurrency.currencyIcon;
            } else {
              // If the selected currency is not found, use the first available currency
              _currency = currencies.first.id;
              _currencyCode = currencies.first.currencyCode;
              _currencyIcon = currencies.first.currencyIcon;
            }
          }
        });
      }
    } catch (e) {
      // Only show error if we're not in initial loading
      if (mounted && _currenciesLoaded) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to load currencies: ${e.toString()}',
          contentType: ContentType.failure,
        );
      }
    } finally {
      // Clear loading flag if component is still mounted
      if (mounted) {
        setState(() => _isLoadingCurrencies = false);
      }
    }
  }

  void _updateCurrencyDetails(String currencyId) {
    // First check if we have currencies from API
    if (_currencies.isNotEmpty) {
      final selectedCurrency = _currencies.firstWhereOrNull(
        (c) => c.id == currencyId,
      );
      if (selectedCurrency != null) {
        setState(() {
          _currency = currencyId;
          _currencyCode = selectedCurrency.currencyCode;
          _currencyIcon = selectedCurrency.currencyIcon;
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
        _currency = currencyId;
        _currencyCode = details['code'] ?? '';
        _currencyIcon = details['icon'] ?? '';
      });
    }
  }

  // Check if the current currency exists in the dropdown items
  String? _getCurrencyValue() {
    if (_isLoadingCurrencies) return null;

    // If using API currencies, check if current currency exists in the list
    if (_currencies.isNotEmpty) {
      bool currencyExists = _currencies.any((c) => c.id == _currency);
      if (currencyExists) {
        return _currency;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return _currencies.first.id;
      }
    }

    // If using static currencies, check if current currency exists in static list
    final staticCurrencies = [
      'AHNTpSNJHMypuNF6iPcMLrz',
      'BHNTpSNJHMypuNF6iPcMLr2',
      'CHNTpSNJHMypuNF6iPcMLr3',
    ];
    if (staticCurrencies.contains(_currency)) {
      return _currency;
    } else {
      // Return default static currency if current currency doesn't exist
      return 'AHNTpSNJHMypuNF6iPcMLrz';
    }
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoadingProducts = true);
    try {
      final products = await _productService.getProducts();
      setState(() {
        _products = products;
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

  Future<void> _loadCustomers() async {
    setState(() => _isLoadingCustomers = true);
    try {
      final customers = await _customerService.getSalesCustomers();
      setState(() {
        _customers = customers;
        // Set first customer as default if available
        if (customers.isNotEmpty) {
          _selectedCustomerId = customers.first.id;
          // Enable GST if customer has tax number
          _isGstEnabled = customers.first.taxNumber?.isNotEmpty ?? false;
          _gstinController.text = customers.first.taxNumber ?? '';
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

  void _initializeControllers() {
    _gstinController = TextEditingController();
    _quantityControllers = [TextEditingController(text: '1')];
    _unitPriceControllers = [TextEditingController(text: '0')];
    _itemDiscountControllers = [TextEditingController(text: '0')];
    _itemGstControllers = [TextEditingController(text: '0')];
    _taxController = TextEditingController(text: '0');
    _discountController = TextEditingController(text: '0');
    _additionalNotesController = TextEditingController();
    _issueDate = DateTime.now();
    _dueDate = DateTime.now().add(const Duration(days: 7));
    _paymentStatus = 'unpaid';

    // Default currency (will be updated from API when loaded)
    _currency = 'AHNTpSNJHMypuNF6iPcMLrz';
    _currencyCode = 'INR';
    _currencyIcon = '₹';

    _itemDiscountTypes = ['percentage'];
    _selectedProducts = [];
    _selectedCustomerId = '';
  }

  void _addProductItem() {
    setState(() {
      _selectedProducts.add(null);
      _quantityControllers.add(TextEditingController(text: '1'));
      _unitPriceControllers.add(TextEditingController(text: '0'));
      _itemDiscountControllers.add(TextEditingController(text: '0'));
      _itemGstControllers.add(TextEditingController(text: '0'));
      _itemDiscountTypes.add('percentage');
    });
  }

  void _removeProductItem(int index) {
    if (_selectedProducts.length > 1) {
      setState(() {
        _selectedProducts.removeAt(index);
        _quantityControllers[index].dispose();
        _quantityControllers.removeAt(index);
        _unitPriceControllers[index].dispose();
        _unitPriceControllers.removeAt(index);
        _itemDiscountControllers[index].dispose();
        _itemDiscountControllers.removeAt(index);
        _itemGstControllers[index].dispose();
        _itemGstControllers.removeAt(index);
        _itemDiscountTypes.removeAt(index);
      });
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
    if (!_isGstEnabled) return 0;

    double totalGst = 0;
    for (int i = 0; i < _selectedProducts.length; i++) {
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
              child: CrmDropdownField<Data>(
                title: 'Product ${index + 1}',
                value:
                    index < _selectedProducts.length
                        ? _selectedProducts[index]
                        : null,
                items:
                    _products
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
                  _selectedProducts[index]!.stockQuantity! < 10
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
            if (quantity > _selectedProducts[index]!.stockQuantity!) {
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
            quantity > _selectedProducts[index]!.stockQuantity!) {
          return 'Insufficient stock (Available: ${_selectedProducts[index]!.stockQuantity})';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SalesInvoiceController>();

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          // Refresh the invoice list when popping back
          if (mounted) {
            await controller.fetchInvoicesForDeal(widget.dealId);
          }
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
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    readOnly: true,
                    // Make field non-editable
                    enabled: false, // Visually show it's disabled
                  ),
                ],
                const SizedBox(height: 16),
                Stack(
                  children: [
                    CrmDropdownField<String>(
                      title: 'Currency',
                      value: _getCurrencyValue(),
                      items:
                          _isLoadingCurrencies && _currenciesLoaded
                              ? [
                                DropdownMenuItem(
                                  value: _currency,
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
                              : _currencies.isNotEmpty
                              ? _currencies
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
                            !(_isLoadingCurrencies && _currenciesLoaded)) {
                          _updateCurrencyDetails(value);
                        }
                      },
                      onMenuOpened: () {
                        // Load currencies if they haven't been loaded yet or if we're not currently loading
                        if (!_isLoadingCurrencies) {
                          _loadCurrencies();
                        }
                      },
                      isRequired: true,
                    ),
                    // Don't show loading indicator at all - it causes confusion
                    // when static values are shown with a loading indicator
                  ],
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
                            ? 'Creating...'
                            : 'Create Invoice',
                    onTap: () {
                      controller.isLoading.value = true;
                      _createInvoice();
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
            message: 'Please select product_service ${i + 1}',
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

      final items = List.generate(_selectedProducts.length, (i) {
        return SalesInvoiceItem(
          total: total,
          amount: _calculateItemTotal(i),
          hsnSac: _selectedProducts[i]!.hsnSac!,
          discount: double.parse(_itemDiscountControllers[i].text),
          quantity: int.parse(_quantityControllers[i].text),
          subtotal: _calculateItemSubtotal(i),
          productId: _selectedProducts[i]!.id!,
          taxAmount: _calculateItemGst(i),
          unitPrice: double.parse(_unitPriceControllers[i].text),
          discountType: _itemDiscountTypes[i],
          discountAmount: _calculateItemDiscount(i),
          taxName: "",
          tax: _isGstEnabled ? double.parse(_itemGstControllers[i].text) : 0,
        );
      });

      // final items = List.generate(
      //   _selectedProducts.length,
      //   (i) => {
      //     'product_id': _selectedProducts[i]!.id,
      //     'quantity': int.parse(_quantityControllers[i].text),
      //     'unit_price': double.parse(_unitPriceControllers[i].text),
      //     'tax': _isGstEnabled ? double.parse(_itemGstControllers[i].text) : 0,
      //     'tax_amount': _calculateItemGst(i),
      //     'discount': double.parse(_itemDiscountControllers[i].text),
      //     'discount_type': _itemDiscountTypes[i],
      //     'discount_amount': _calculateItemDiscount(i),
      //     'hsn_sac': _selectedProducts[i]!.hsnSac,
      //     'amount': _calculateItemTotal(i),
      //     'subtotal': _calculateItemSubtotal(i),
      //     'tax_name': "",
      //   },
      // );

      final data = SalesInvoice(
        customer: _selectedCustomerId,
        issueDate: _issueDate,
        dueDate: _dueDate,
        discount: _calculateTotalDiscount(),
        tax: _calculateTotalGst(),
        subtotal: _calculateSubtotal(),
        total: _calculateTotal(),
        paymentStatus: _paymentStatus,
        currency: _currency,
        gstin: _isGstEnabled ? _gstinController.text : '',
        section: 'sales-invoice',
        currencyCode: _currencyCode,
        currencyIcon: _currencyIcon,
        items: items,
      );

      // final data = {
      //   'customer': _selectedCustomerId,
      //   'gstin': _isGstEnabled ? _gstinController.text : '',
      //   'section': 'sales-invoice',
      //   'issueDate': DateFormat('yyyy-MM-dd').format(_issueDate),
      //   'dueDate': DateFormat('yyyy-MM-dd').format(_dueDate),
      //   'currency': _currency,
      //   'currency_code': _currencyCode,
      //   'currency_icon': _currencyIcon,
      //   'items': items,
      //   'subtotal': _calculateSubtotal(),
      //   'tax': _calculateTotalGst(),
      //   'discount': _calculateTotalDiscount(),
      //   'total': _calculateTotal(),
      //   'payment_status': _paymentStatus,
      // };

      try {
        final success = await controller.createInvoice(data, widget.dealId);
        if (success) {
          // Refresh invoices list
          await controller.fetchInvoicesForDeal(widget.dealId);

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
}
