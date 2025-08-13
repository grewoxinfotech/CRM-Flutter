// import 'dart:io';
// import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../../data/network/sales/product_service/model/product_model.dart';
// import '../../../../../widgets/button/crm_button.dart';
// import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
// import '../../../../../widgets/common/inputs/crm_text_field.dart';
// import '../../../../../widgets/common/messages/crm_snack_bar.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
//
// import '../../../../crm/crm_functionality/lead/controllers/lead_controller.dart';
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final ProductsServicesController controller = Get.find();
//   final _formKey = GlobalKey<FormState>();
//
//   final nameController = TextEditingController();
//   final buyingPriceController = TextEditingController();
//   final sellingPriceController = TextEditingController();
//   final skuController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final taxNameController = TextEditingController();
//   final taxPercentageController = TextEditingController();
//   final hsnSacController = TextEditingController();
//   final stockQuantityController = TextEditingController(text: '0');
//   final minStockLevelController = TextEditingController(text: '0');
//   final maxStockLevelController = TextEditingController(text: '0');
//   final reorderQuantityController = TextEditingController(text: '0');
//
//   final currencies = [
//     {'code': 'q6xe5PwPo74hw2hkumFyBvb', 'symbol': '₹', 'name': 'INR'},
//   ];
//   final stockStatuses = ['in_stock', 'low_stock', 'out_of_stock'];
//
//   String? selectedCategoryId;
//   String? selectedCurrencyCode;
//   String? selectedStockStatus;
//
//   bool isLoading = false;
//   XFile? _selectedImage;
//   final _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Category
//     if (controller.categoryOptions.isNotEmpty) {
//       selectedCategoryId = controller.categoryOptions.first['id'];
//     } else {
//       selectedCategoryId = null; // No category available
//     }
//
//     selectedCurrencyCode = currencies.first['code'];
//     selectedStockStatus = stockStatuses.first;
//   }
//
//   String? requiredValidator(String? value, String message) {
//     if (value == null || value.trim().isEmpty) return message;
//     return null;
//   }
//
//   Future<void> _pickImage() async {
//     final image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 70,
//     );
//     if (image != null) setState(() => _selectedImage = image);
//   }
//
//   void _removeImage() => setState(() => _selectedImage = null);
//
//   bool _validateStockLevels() {
//     final stockQty = int.tryParse(stockQuantityController.text.trim());
//     final minStock = int.tryParse(minStockLevelController.text.trim());
//     final maxStock = int.tryParse(maxStockLevelController.text.trim());
//     final reorderQty = int.tryParse(reorderQuantityController.text.trim());
//
//     if ([stockQty, minStock, maxStock, reorderQty].contains(null)) {
//       _showError("Stock values must be valid numbers.");
//       return false;
//     }
//     if ([stockQty!, minStock!, maxStock!, reorderQty!].any((v) => v < 0)) {
//       _showError("Stock values cannot be negative.");
//       return false;
//     }
//     if (minStock > maxStock) {
//       _showError(
//         "Minimum Stock Level cannot be greater than Maximum Stock Level.",
//       );
//       return false;
//     }
//     if (stockQty > maxStock) {
//       _showError("Stock Quantity cannot be greater than Maximum Stock Level.");
//       return false;
//     }
//     if (reorderQty > maxStock) {
//       _showError(
//         "Reorder Quantity cannot be greater than Maximum Stock Level.",
//       );
//       return false;
//     }
//     return true;
//   }
//
//   void _showError(String message) {
//     CrmSnackBar.showAwesomeSnackbar(
//       title: "Error",
//       message: message,
//       contentType: ContentType.failure,
//     );
//   }
//
//   Future<void> _validateAndSubmit() async {
//     // This will trigger validators and show inline errors
//     if (!_formKey.currentState!.validate()) return;
//
//     // Stock validations
//     if (!_validateStockLevels()) return;
//
//     setState(() => isLoading = true);
//
//     final product = Data(
//       name: nameController.text.trim(),
//       category: selectedCategoryId!,
//       buyingPrice: int.tryParse(buyingPriceController.text) ?? 0,
//       sellingPrice: int.tryParse(sellingPriceController.text) ?? 0,
//       currency: selectedCurrencyCode!,
//       sku: skuController.text.trim(),
//       taxName: taxNameController.text.trim(),
//       taxPercentage: int.tryParse(taxPercentageController.text) ?? 0,
//       hsnSac: hsnSacController.text.trim(),
//       description: descriptionController.text.trim(),
//       stockQuantity: int.tryParse(stockQuantityController.text) ?? 0,
//       minStockLevel: int.tryParse(minStockLevelController.text) ?? 0,
//       maxStockLevel: int.tryParse(maxStockLevelController.text) ?? 0,
//       reorderQuantity: int.tryParse(reorderQuantityController.text) ?? 0,
//       stockStatus: selectedStockStatus!,
//       createdBy: 'grewox',
//       image: _selectedImage?.path,
//     );
//
//     final success = await controller.createProduct(product);
//     setState(() => isLoading = false);
//
//     CrmSnackBar.showAwesomeSnackbar(
//       title: success ? "Success" : "Error",
//       message:
//           success
//               ? "Product added successfully"
//               : "Failed to add product service",
//       contentType: success ? ContentType.success : ContentType.failure,
//     );
//     if (success) Get.back();
//   }
//
//   Widget _buildImagePicker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Product Image',
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//         ),
//         const SizedBox(height: 8),
//         _selectedImage == null
//             ? GestureDetector(
//               onTap: _pickImage,
//               child: _imageBox(
//                 Icon(Icons.add_a_photo, color: Get.theme.colorScheme.primary),
//               ),
//             )
//             : Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.file(
//                     File(_selectedImage!.path),
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   right: -10,
//                   top: -10,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.cancel,
//                       color: Colors.redAccent,
//                       size: 24,
//                     ),
//                     onPressed: _removeImage,
//                   ),
//                 ),
//               ],
//             ),
//       ],
//     );
//   }
//
//   Widget _imageBox(Widget child) => Container(
//     width: 100,
//     height: 100,
//     decoration: BoxDecoration(
//       color: Get.theme.colorScheme.surface,
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: Get.theme.dividerColor),
//     ),
//     child: Center(child: child),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CrmTextField(
//                   controller: nameController,
//                   title: 'Product Name',
//                   isRequired: true,
//                   validator:
//                       (v) => requiredValidator(v, 'Please enter product name'),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CrmTextField(
//                         controller: buyingPriceController,
//                         title: 'Buying Price',
//                         keyboardType: TextInputType.number,
//                         isRequired: true,
//                         validator:
//                             (v) => requiredValidator(
//                               v,
//                               'Please enter buying price',
//                             ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CrmTextField(
//                         controller: sellingPriceController,
//                         title: 'Selling Price',
//                         keyboardType: TextInputType.number,
//                         isRequired: true,
//                         validator:
//                             (v) => requiredValidator(
//                               v,
//                               'Please enter selling price',
//                             ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 CrmTextField(
//                   controller: skuController,
//                   title: 'SKU',
//                   isRequired: true,
//                   validator: (v) => requiredValidator(v, 'Please enter SKU'),
//                 ),
//                 SizedBox(height: 20),
//                 CrmTextField(
//                   controller: descriptionController,
//                   title: 'Description',
//                   maxLines: 3,
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CrmTextField(
//                         controller: taxNameController,
//                         title: 'Tax Name',
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CrmTextField(
//                         controller: taxPercentageController,
//                         title: 'Tax %',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 CrmTextField(
//                   controller: hsnSacController,
//                   title: 'HSN/SAC Code',
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CrmTextField(
//                         controller: stockQuantityController,
//                         title: 'Stock Quantity',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CrmTextField(
//                         controller: minStockLevelController,
//                         title: 'Min Stock Level',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CrmTextField(
//                         controller: maxStockLevelController,
//                         title: 'Max Stock Level',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CrmTextField(
//                         controller: reorderQuantityController,
//                         title: 'Reorder Quantity',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 CrmDropdownField<String>(
//                   title: 'Category',
//                   value: selectedCategoryId,
//                   items:
//                       controller.categoryOptions.isEmpty
//                           ? [
//                             const DropdownMenuItem(
//                               value: '',
//                               child: Text('No categories available'),
//                             ),
//                           ]
//                           : controller.categoryOptions.map((category) {
//                             return DropdownMenuItem(
//                               value: category['id'], // access via map key
//                               child: Text(category['name'] ?? ''),
//                             );
//                           }).toList(),
//                   onChanged: (v) => setState(() => selectedCategoryId = v),
//                   isRequired: true,
//                   validator:
//                       (v) => requiredValidator(v, 'Please select category'),
//                 ),
//                 SizedBox(height: 20),
//                 CrmDropdownField<String>(
//                   title: 'Currency',
//                   value: selectedCurrencyCode,
//                   items:
//                       currencies
//                           .map(
//                             (cur) => DropdownMenuItem(
//                               value: cur['code'],
//                               child: Text('${cur['symbol']} (${cur['name']})'),
//                             ),
//                           )
//                           .toList(),
//                   onChanged: (v) => setState(() => selectedCurrencyCode = v),
//                   isRequired: true,
//                   validator:
//                       (v) => requiredValidator(v, 'Please select currency'),
//                 ),
//                 SizedBox(height: 20),
//                 CrmDropdownField<String>(
//                   title: 'Stock Status',
//                   value: selectedStockStatus,
//                   items:
//                       stockStatuses
//                           .map(
//                             (s) => DropdownMenuItem(
//                               value: s,
//                               child: Text(s.replaceAll('_', ' ')),
//                             ),
//                           )
//                           .toList(),
//                   onChanged: (v) => setState(() => selectedStockStatus = v),
//                   isRequired: true,
//                   validator:
//                       (v) => requiredValidator(v, 'Please select stock status'),
//                 ),
//                 SizedBox(height: 20),
//                 _buildImagePicker(),
//                 SizedBox(height: 20),
//                 isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : CrmButton(
//                       width: Get.width - 40,
//                       title: 'Add Product',
//                       onTap: _validateAndSubmit,
//                     ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       //  body: Padding(
//       //   padding: const EdgeInsets.all(16),
//       //   child: Form(
//       //     key: _formKey,
//       //     child: ListView.separated(
//       //       itemCount: formFields.length,
//       //       itemBuilder: (context, index) => formFields[index],
//       //       separatorBuilder: (context, index) => const SizedBox(height: 20),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

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
