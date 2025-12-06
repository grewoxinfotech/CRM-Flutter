import 'dart:io';
import 'package:crm_flutter/app/data/network/sales/product_service/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';

class AddProductScreen extends StatelessWidget {
  Data? product;
  final bool isFromEdit;
  final controller = Get.find<ProductsServicesController>();

  AddProductScreen({Key? key, this.isFromEdit = false, this.product})
    : super(key: key);

  Widget _buildImagePicker() {
    return GetBuilder<ProductsServicesController>(
      builder: (_) {
        Widget imageWidget;

        if (controller.selectedImage != null) {
          // New image picked locally
          imageWidget = ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(controller.selectedImage!.path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        } else if (isFromEdit &&
            product?.image != null &&
            product!.image!.isNotEmpty) {
          // Existing image from server (URL)
          imageWidget = ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product!.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => _imageBox(
                    const Icon(Icons.broken_image, color: Colors.grey),
                  ),
            ),
          );
        } else {
          // No image
          imageWidget = GestureDetector(
            onTap: controller.pickImage,
            child: _imageBox(
              Icon(Icons.add_a_photo, color: Get.theme.colorScheme.primary),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Image',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                imageWidget,
                if (controller.selectedImage != null ||
                    (isFromEdit &&
                        product?.image != null &&
                        product!.image!.isNotEmpty))
                  Positioned(
                    right: -10,
                    top: -10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      onPressed: () {
                        controller.removeImage();
                        if (isFromEdit) {
                          product?.image =
                              ''; // or null, depending on your model
                        }
                        (Get.context as Element)
                            .markNeedsBuild(); // or call setState if using StatefulWidget
                      },
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

  String? _getCurrencyValue() {
    if (controller.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (controller.currencies.isNotEmpty) {
      bool currencyExists = controller.currencies.any(
        (c) => c.id == controller.currency.value,
      );
      if (currencyExists) {
        return controller.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return controller.currencies.first.id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && product != null) {
      controller.nameController.text = product!.name!;
      controller.buyingPriceController.text = product!.buyingPrice!.toString();
      controller.sellingPriceController.text =
          product!.sellingPrice!.toString();
      controller.skuController.text = product?.sku.toString() ?? '';
      controller.descriptionController.text = product!.description!;
      controller.taxNameController.text = product!.taxName!;
      controller.taxPercentageController.text =
          product!.taxPercentage!.toString();
      controller.hsnSacController.text = product!.hsnSac!;
      controller.stockQuantityController.text =
          product!.stockQuantity!.toString();
      controller.minStockLevelController.text =
          product!.minStockLevel!.toString();
      controller.maxStockLevelController.text =
          product!.maxStockLevel!.toString();
      controller.reorderQuantityController.text =
          product!.reorderQuantity!.toString();
      controller.selectedCategoryId = product!.category!;
      controller.currency.value = product!.currency!;
      controller.selectedStockStatus = product!.stockStatus!;
      // if (product!.image != null) {
      //   controller.selectedImage = XFile(product!.image!);
      // }
    }
    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Product' : 'Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,

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

                Obx(
                  () => CrmDropdownField<String>(
                    title: 'Currency',
                    value: _getCurrencyValue(),
                    items:
                        controller.isLoadingCurrencies.value &&
                                controller.currenciesLoaded.value
                            ? [
                              DropdownMenuItem(
                                value: controller.currency.value,
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
                            : controller.currencies.isNotEmpty
                            ? controller.currencies
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
                          !(controller.isLoadingCurrencies.value &&
                              controller.currenciesLoaded.value)) {
                        controller.updateCurrencyDetails(value);
                      }
                    },
                    onMenuOpened: () {
                      // Load currencies if they haven't been loaded yet or if we're not currently loading
                      if (!controller.isLoadingCurrencies.value) {
                        controller.loadCurrencies();
                      }
                    },
                    isRequired: true,
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
                            title:
                                isFromEdit ? 'Update Product ' : 'Add Product',
                            onTap: () {
                              isFromEdit
                                  ? controller.submitProductUpdate(product!.id!)
                                  : controller.submitProduct();
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
}
