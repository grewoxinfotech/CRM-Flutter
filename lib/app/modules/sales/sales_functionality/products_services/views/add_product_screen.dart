import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';

class AddProductScreen extends StatelessWidget {
  final controller = Get.find<ProductsServicesController>();

  AddProductScreen({Key? key}) : super(key: key);

  Widget _buildImagePicker() {
    return GetBuilder<ProductsServicesController>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Image',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            controller.selectedImage == null
                ? GestureDetector(
                  onTap: controller.pickImage,
                  child: _imageBox(
                    Icon(
                      Icons.add_a_photo,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                )
                : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(controller.selectedImage!.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: -10,
                      top: -10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.redAccent,
                          size: 24,
                        ),
                        onPressed: controller.removeImage,
                      ),
                    ),
                  ],
                ),
          ],
        );
      },
    );
  }

  Widget _imageBox(Widget child) => Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Get.theme.dividerColor),
    ),
    child: Center(child: child),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CrmTextField(
                  controller: controller.nameController,
                  title: 'Product Name',
                  isRequired: true,
                  validator:
                      (v) => controller.requiredValidator(
                        v,
                        'Please enter product name',
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.buyingPriceController,
                        title: 'Buying Price',
                        keyboardType: TextInputType.number,
                        isRequired: true,
                        validator:
                            (v) => controller.requiredValidator(
                              v,
                              'Please enter buying price',
                            ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.sellingPriceController,
                        title: 'Selling Price',
                        keyboardType: TextInputType.number,
                        isRequired: true,
                        validator:
                            (v) => controller.requiredValidator(
                              v,
                              'Please enter selling price',
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CrmTextField(
                  controller: controller.skuController,
                  title: 'SKU',
                  isRequired: true,
                  validator:
                      (v) =>
                          controller.requiredValidator(v, 'Please enter SKU'),
                ),
                const SizedBox(height: 20),
                CrmTextField(
                  controller: controller.descriptionController,
                  title: 'Description',
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.taxNameController,
                        title: 'Tax Name',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.taxPercentageController,
                        title: 'Tax %',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CrmTextField(
                  controller: controller.hsnSacController,
                  title: 'HSN/SAC Code',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.stockQuantityController,
                        title: 'Stock Quantity',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.minStockLevelController,
                        title: 'Min Stock Level',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.maxStockLevelController,
                        title: 'Max Stock Level',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.reorderQuantityController,
                        title: 'Reorder Quantity',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CrmDropdownField<String>(
                  title: 'Category',
                  value: controller.selectedCategoryId,
                  items:
                      controller.categoryOptions.isEmpty
                          ? [
                            const DropdownMenuItem(
                              value: '',
                              child: Text('No categories available'),
                            ),
                          ]
                          : controller.categoryOptions
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category['id'],
                                  child: Text(category['name'] ?? ''),
                                ),
                              )
                              .toList(),
                  onChanged: (v) => controller.selectedCategoryId = v,
                  isRequired: true,
                  validator:
                      (v) => controller.requiredValidator(
                        v,
                        'Please select category',
                      ),
                ),
                const SizedBox(height: 20),
                CrmDropdownField<String>(
                  title: 'Currency',
                  value: controller.selectedCurrencyCode,
                  items:
                      controller.currencies
                          .map(
                            (cur) => DropdownMenuItem(
                              value: cur['code'],
                              child: Text('${cur['symbol']} (${cur['name']})'),
                            ),
                          )
                          .toList(),
                  onChanged: (v) => controller.selectedCurrencyCode = v,
                  isRequired: true,
                  validator:
                      (v) => controller.requiredValidator(
                        v,
                        'Please select currency',
                      ),
                ),
                const SizedBox(height: 20),
                CrmDropdownField<String>(
                  title: 'Stock Status',
                  value: controller.selectedStockStatus,
                  items:
                      controller.stockStatuses
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.replaceAll('_', ' ')),
                            ),
                          )
                          .toList(),
                  onChanged: (v) => controller.selectedStockStatus = v,
                  isRequired: true,
                  validator:
                      (v) => controller.requiredValidator(
                        v,
                        'Please select stock status',
                      ),
                ),
                const SizedBox(height: 20),
                _buildImagePicker(),
                const SizedBox(height: 20),
                Obx(
                  () =>
                      controller.isLoading.value
                          ? Center(child: const CircularProgressIndicator())
                          : CrmButton(
                            width: Get.width - 40,
                            title: 'Add Product',
                            onTap: controller.submitProduct,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
