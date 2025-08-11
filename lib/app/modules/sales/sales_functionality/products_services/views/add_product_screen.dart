import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductsServicesController controller = Get.find();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController buyingPriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController taxNameController = TextEditingController();
  final TextEditingController taxPercentageController = TextEditingController();

  // Add other fields you want here...

  bool isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final newProduct = Data(
      name: nameController.text.trim(),
      buyingPrice: int.tryParse(buyingPriceController.text.trim()) ?? 0,
      sellingPrice: int.tryParse(sellingPriceController.text.trim()) ?? 0,
      sku: skuController.text.trim(),
      description: descriptionController.text.trim(),
      taxName: taxNameController.text.trim(),
      taxPercentage: int.tryParse(taxPercentageController.text.trim()) ?? 0,
      // Set other fields or default values as needed
      stockQuantity: 0,
      minStockLevel: 0,
      maxStockLevel: 0,
      reorderQuantity: 0,
      stockStatus: "in_stock",
      category: "Au0rpRzrYJBqnoFuHiOu3ES",
      // You can add currency, category etc if needed here
    );

    bool success = await controller.createProduct(newProduct);
    print("[DEBUG]=> $success");
    setState(() {
      isLoading = false;
    });

    if (success) {
      Get.back();
      Get.snackbar(
        'Success',
        'Product added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to add product_service',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    buyingPriceController.dispose();
    sellingPriceController.dispose();
    skuController.dispose();
    descriptionController.dispose();
    taxNameController.dispose();
    taxPercentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CrmTextField(
                controller: nameController,
                title: 'Product Name',
                isRequired: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Please enter product_service name'
                            : null,
              ),
              CrmTextField(
                controller: buyingPriceController,
                title: 'Buying Price',
                keyboardType: TextInputType.number,
                isRequired: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Please enter buying price'
                            : null,
              ),
              CrmTextField(
                controller: sellingPriceController,
                title: 'Selling Price',
                keyboardType: TextInputType.number,
                isRequired: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Please enter selling price'
                            : null,
              ),
              CrmTextField(
                controller: skuController,
                title: 'SKU',
                isRequired: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Please enter SKU' : null,
              ),
              CrmTextField(
                controller: descriptionController,
                title: 'Description',
                maxLines: 3,
              ),
              CrmTextField(controller: taxNameController, title: 'Tax Name'),
              CrmTextField(
                controller: taxPercentageController,
                title: 'Tax Percentage',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Add Product'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
