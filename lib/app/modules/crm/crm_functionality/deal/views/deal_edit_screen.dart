import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/crm/contact/services/contact_services.dart';
import 'package:crm_flutter/app/data/network/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/controller/stage_controller.dart';
import 'package:crm_flutter/app/data/network/sales/product_service/model/product_model.dart';
import 'package:crm_flutter/app/data/network/system/country/controller/country_controller.dart';
import 'package:crm_flutter/app/data/network/system/currency/model/currency_model.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/controller/contact_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';

import '../../../../../care/utils/validation.dart';
import '../../../../../data/network/crm/contact/medel/contact_medel.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';

class DealEditScreen extends StatefulWidget {
  final DealModel deal;

  const DealEditScreen({super.key, required this.deal});
  @override
  State<DealEditScreen> createState() => _DealCreateScreenState();
}

class _DealCreateScreenState extends State<DealEditScreen> {
  final RxList<String> selectedMembers = <String>[].obs;
  final RxList<Data> selectedProducts = <Data>[].obs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => PipelineController());
    Get.lazyPut(() => StageController());
    Get.lazyPut(() => LeadController());
    Get.lazyPut(() => UsersController());
  }

  Future<void> _pickDate(
    BuildContext context,
    DealController dealController,
  ) async {
    final initialDate = dealController.selectedEndDate.value ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dealController.selectedEndDate.value = picked;
      dealController.endDateController.text = DateFormat(
        'dd-MM-yyyy',
      ).format(picked);
    }
  }

  String? _getCurrencyValue(DealController dealController) {
    if (dealController.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (dealController.currencies.isNotEmpty) {
      final currencyExists = dealController.currencies.firstWhereOrNull(
        (c) => c.id == widget.deal.currency,
      );
      if (currencyExists != null) {
        return currencyExists.id;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return dealController.currencies.first.id;
      }
    }
  }

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final DealController dealController = Get.find<DealController>();
    final PipelineController pipelineController =
        Get.find<PipelineController>();
    final StageController stageController = Get.find<StageController>();
    final UsersController usersController = Get.find<UsersController>();
    final ProductsServicesController productsController = Get.put(ProductsServicesController());
    final ContactController contactController = Get.put(ContactController());

    return Scaffold(
      appBar: AppBar(title: Text("Edit Deal"), leading: CrmBackButton()),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Lead Title
                    CrmTextField(
                      title: 'Deal Title',
                      controller: dealController.dealTitle,
                      hintText: 'Enter Deal title',
                    ),
                    const SizedBox(height: 16),

                    // Pipeline
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Pipeline",
                        value: dealController.selectedPipelineId.value,
                        items:
                            pipelineController.pipelines.map((pipeline) {
                              return DropdownMenuItem(
                                value: pipeline.id,
                                child: Text(pipeline.pipelineName ?? ''),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            dealController.selectedPipelineId.value = value;
                            stageController.getStagesByPipeline(value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Stage
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Stage",
                        value: dealController.selectedStageId.value,
                        items:
                            stageController.stages
                                .where(
                                  (stage) =>
                                      (stage.stageType).toLowerCase() ==
                                          "deal" &&
                                      stage.isDefault == true,
                                )
                                .map((stage) {
                                  return DropdownMenuItem(
                                    value: stage.id,
                                    child: Text(stage.stageName ?? ''),
                                  );
                                })
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            dealController.selectedStageId.value = value;
                          }
                        },
                        hintText: "Select stage",
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Deal Value
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => CrmDropdownField<String>(
                              title: 'Currency',
                              value: _getCurrencyValue(dealController),
                              items:
                                  dealController.isLoadingCurrencies.value &&
                                          dealController.currenciesLoaded.value
                                      ? [
                                        DropdownMenuItem(
                                          value: dealController.currency.value,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 16,
                                                width: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                              SizedBox(width: 8),
                                              Text('Loading currencies...'),
                                            ],
                                          ),
                                        ),
                                      ]
                                      : dealController.currencies.isNotEmpty
                                      ? dealController.currencies
                                          .map(
                                            (currency) => DropdownMenuItem(
                                              value: currency.id,
                                              child: Text(
                                                '${currency.currencyCode} (${currency.currencyIcon})',
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
                                    !(dealController
                                            .isLoadingCurrencies
                                            .value &&
                                        dealController
                                            .currenciesLoaded
                                            .value)) {
                                  dealController.updateCurrencyDetails(value);
                                }
                              },

                              isRequired: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: CrmTextField(
                            title: 'Deal Value',
                            controller: dealController.dealValue,
                            hintText: 'Enter Deal value',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),


                    // Source
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Source",
                        value: dealController.selectedSource.value,
                        items:
                            dealController.sourceOptions.isEmpty
                                ? [
                                  DropdownMenuItem(
                                    value: '',
                                    child: Text('No sources available'),
                                  ),
                                ]
                                : dealController.sourceOptions.map((source) {
                                  return DropdownMenuItem(
                                    value: source['id'],
                                    child: Text(source['name'] ?? ''),
                                  );
                                }).toList(),
                        onChanged:
                            dealController.sourceOptions.isEmpty
                                ? (_) {}
                                : (value) {
                                  if (value != null) {
                                    dealController.selectedSource.value = value;
                                  }
                                },
                        hintText: "Select source",
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Category",
                        value: dealController.selectedCategory.value,
                        items:
                            dealController.categoryOptions.isEmpty
                                ? [
                                  DropdownMenuItem(
                                    value: '',
                                    child: Text('No categories available'),
                                  ),
                                ]
                                : dealController.categoryOptions.map((
                                  category,
                                ) {
                                  return DropdownMenuItem(
                                    value: category['id'],
                                    child: Text(category['name'] ?? ''),
                                  );
                                }).toList(),
                        onChanged:
                            dealController.categoryOptions.isEmpty
                                ? (_) {}
                                : (value) {
                                  if (value != null) {
                                    dealController.selectedCategory.value =
                                        value;
                                  }
                                },
                        hintText: "Select category",
                      ),
                    ),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () => _pickDate(context, dealController),
                      child: AbsorbPointer(
                        child: CrmTextField(
                          controller: dealController.endDateController,
                          title: 'Expected Close  Date',
                          isRequired: true,
                          suffixIcon: const Icon(Icons.calendar_today),
                          validator:
                              (value) =>
                                  requiredValidator(value, 'Date is required'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Team Members",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Obx(
                                () =>
                                    selectedMembers.isEmpty
                                        ? Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.person_outline,
                                                size: 32,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "No team members selected",
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        : Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children:
                                                selectedMembers.map((memberId) {
                                                  final user = usersController
                                                      .getUserById(memberId);
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Get
                                                          .theme
                                                          .primaryColor
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      border: Border.all(
                                                        color: Get
                                                            .theme
                                                            .primaryColor
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Chip(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      avatar: CircleAvatar(
                                                        backgroundColor:
                                                            Get
                                                                .theme
                                                                .primaryColor,
                                                        child: Text(
                                                          (user?.username
                                                                      .substring(
                                                                        0,
                                                                        1,
                                                                      ) ??
                                                                  'U')
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      label: Text(
                                                        user?.username ??
                                                            memberId,
                                                        style: TextStyle(
                                                          color: Get
                                                              .theme
                                                              .primaryColor
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                      deleteIconColor:
                                                          Get
                                                              .theme
                                                              .primaryColor,
                                                      onDeleted: () {
                                                        selectedMembers.remove(
                                                          memberId,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                          ),
                                        ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton.icon(
                                icon: Icon(Icons.person_add, size: 18),
                                label: Text("Add Team Member"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Get.theme.primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  _showTeamMemberSelection(
                                    context,
                                    usersController,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

              /// Product Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Products",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(
                              () => selectedProducts.isEmpty
                              ? Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "No products selected",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: selectedProducts.map((product) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Get.theme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Get.theme.primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Chip(
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    avatar: CircleAvatar(
                                      backgroundColor: Get.theme.primaryColor,
                                      child: Icon(
                                        Icons.shopping_bag,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    label: Text(
                                      product.name ?? "Product ${product.id}",
                                      style: TextStyle(
                                        color: Get.theme.primaryColor.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    deleteIconColor: Get.theme.primaryColor,
                                    onDeleted: () {
                                      selectedProducts.remove(product);
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: Icon(Icons.add_shopping_cart, size: 18),
                          label: Text("Add Product"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Get.theme.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            _showProductSelection(context, productsController, selectedProducts);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Select Existing',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Obx(
                          () => Switch(
                            value: dealController.isSelectFromExisting.value,
                            onChanged: (newValue) {
                              dealController.isSelectFromExisting.value =
                                  newValue;
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Create New',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Obx(
                      () =>
                          dealController.isSelectFromExisting.value
                              ? _buildContactDetailField(
                                dealController: dealController,
                                contactController: contactController,
                              )
                              : _buildCompanyAndContactDropdowns(
                                dealController: dealController,
                                contactController: contactController,
                              ),
                    ),

                    const SizedBox(height: 24),

                    // Create Button
                    Obx(
                      () => CrmButton(
                        width: Get.width - 40,
                        title:
                            dealController.isLoading.value
                                ? "Updating..."
                                : "Update Deal",
                        onTap: () {
                          _updateDeal(dealController);
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  void _showTeamMemberSelection(
    BuildContext context,
    UsersController usersController,
  ) {
    // Create a search controller and filtered users list
    final searchController = TextEditingController();
    final RxList<User> filteredUsers = RxList<User>([...usersController.users]);

    // Function to filter users based on search text
    void filterUsers(String query) {
      if (query.isEmpty) {
        filteredUsers.value = [...usersController.users];
      } else {
        filteredUsers.value =
            usersController.users
                .where(
                  (user) =>
                      user.username.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      user.email.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Select Team Members",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Search bar
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterUsers,
                    decoration: InputDecoration(
                      hintText: "Search members...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Get.theme.primaryColor.withOpacity(0.7),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),

                Divider(height: 1),

                // Members list
                Obx(
                  () => Flexible(
                    child:
                        filteredUsers.isEmpty
                            ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "No members found",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            )
                            : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                final user = filteredUsers[index];

                                return Obx(() {
                                  final isSelected = selectedMembers.contains(
                                    user.id,
                                  );

                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? Get.theme.primaryColor
                                                  .withOpacity(0.1)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? Get.theme.primaryColor
                                                    .withOpacity(0.5)
                                                : Colors.grey.shade300,
                                        width: isSelected ? 1.5 : 1,
                                      ),
                                    ),
                                    child: ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            isSelected
                                                ? Get.theme.primaryColor
                                                : Colors.grey.shade300,
                                        child: Text(
                                          user.username
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        user.username,
                                        style: TextStyle(
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                      subtitle: Text(
                                        user.email,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      trailing:
                                          isSelected
                                              ? Icon(
                                                Icons.check_circle,
                                                color: Get.theme.primaryColor,
                                              )
                                              : Icon(
                                                Icons.circle_outlined,
                                                color: Colors.grey.shade400,
                                              ),
                                      onTap: () {
                                        if (isSelected) {
                                          selectedMembers.remove(user.id);
                                        } else {
                                          // Prevent duplicates
                                          if (!selectedMembers.contains(
                                            user.id,
                                          )) {
                                            selectedMembers.add(user.id);
                                          }
                                        }
                                      },
                                    ),
                                  );
                                });
                              },
                            ),
                  ),
                ),

                Divider(height: 1),

                // Actions
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          "DONE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showProductSelection(
      BuildContext context,
      ProductsServicesController productsController,
      RxList<Data> selectedProducts, // product IDs
      ) {
    final searchController = TextEditingController();
    final RxList<Data> filteredProducts = RxList<Data>([...productsController.items]);

    // Function to filter products
    void filterProducts(String query) {
      if (query.isEmpty) {
        filteredProducts.value = [...productsController.items];
      } else {
        filteredProducts.value = productsController.items
            .where(
              (product) =>
          product.name!.toLowerCase().contains(query.toLowerCase())
        )
            .toList();
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Select Products",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Search bar
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterProducts,
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Get.theme.primaryColor.withOpacity(0.7),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),

                Divider(height: 1),

                // Products list
                Obx(
                      () => Flexible(
                    child: filteredProducts.isEmpty
                        ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No products found",
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return Obx(() {
                          final isSelected = selectedProducts.contains(product);

                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Get.theme.primaryColor.withOpacity(0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Get.theme.primaryColor.withOpacity(0.5)
                                    : Colors.grey.shade300,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: isSelected
                                    ? Get.theme.primaryColor
                                    : Colors.grey.shade300,
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                              title: Text(
                                product.name ?? '',
                                style: TextStyle(
                                  fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              subtitle: Text(
                                "Stock: ${product.stockQuantity}",
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: isSelected
                                  ? Icon(Icons.check_circle,
                                  color: Get.theme.primaryColor)
                                  : Icon(Icons.circle_outlined,
                                  color: Colors.grey.shade400),
                              onTap: () {
                                if (isSelected) {
                                  selectedProducts.remove(product);
                                } else {
                                  if (!selectedProducts.contains(product)) {
                                    selectedProducts.add(product);
                                  }
                                }
                              },
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),

                Divider(height: 1),

                // Actions
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        child: Text(
                          "DONE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _createContact(DealController dealController) async {
    try {
      final ContactService _contactService = ContactService();
      // Create the contact model with only required fields
      final user = await SecureStorage.getUserData();
      final newContact = ContactModel(
        firstName: dealController.firstName.text.trim(),
        lastName: dealController.lastName.text.trim(),
        contactOwner: user?.id ?? "",
        email:
            dealController.email.text.trim().isNotEmpty
                ? dealController.email.text.trim()
                : null,
        phoneCode: dealController.selectedCountryCode.value!.phoneCode,
        phone:
            dealController.phoneNumber.text.trim().isNotEmpty
                ? dealController.phoneNumber.text.trim()
                : null,
        address:
            dealController.address.text.trim().isNotEmpty
                ? dealController.address.text.trim()
                : null,
      );

      dealController.isLoading.value = true;

      // Call the service to add the contact
      final ContactModel? success = await _contactService.addContact(
        newContact,
      );
      print("[DEBUG]=> success ${success!.toJson()}");
      dealController.selectedContact.value = success!.id!;

      if (success != null) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Contact created successfully',
          contentType: ContentType.success,
        );
        // Close the screen
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to create contact',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'An unexpected error occurred: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      dealController.isLoading.value = false;
    }
  }

  Future<void> _updateDeal(DealController dealController) async {

    try {
      if (dealController.isSelectFromExisting.value) {
        await _createContact(dealController);
        if (dealController.selectedContact.isEmpty) {
          return;
        }
      }
      final user = await SecureStorage.getUserData();
      final userId = user?.id ?? "";

      final newDeal = DealModel(
        category: dealController.selectedCategory.value,
        closedDate: dealController.selectedEndDate.value,
        companyId: dealController.selectedCompany.isEmpty ? null : dealController.selectedCompany.value,
        contactId: dealController.selectedContact.isEmpty ? null : dealController.selectedContact.value,
        currency: dealController.currency.value,
        dealTitle: dealController.dealTitle.text,
        dealMembers:
        selectedMembers
            .map((element) => DealMember(memberId: element))
            .toList(),
        pipeline: dealController.selectedPipelineId.value,
        products: selectedProducts.map((element) => Data(
          id: element.id,
          relatedId: element.relatedId,
          name: element.name,
          currency: element.currency,
          buyingPrice: element.buyingPrice,
          sellingPrice: element.sellingPrice,
          profitMargin: element.profitMargin,
          profitPercentage: element.profitPercentage,
          category: element.category,
          sku: element.sku,
          hsnSac: element.hsnSac,
          description: element.description,
          taxName: element.taxName,
          taxPercentage: element.taxPercentage,
          image: element.image,
          stockQuantity: element.stockQuantity,
          minStockLevel: element.minStockLevel,
          maxStockLevel: element.maxStockLevel,
          reorderQuantity: element.reorderQuantity,
          stockStatus: element.stockStatus,
          lastStockUpdate: element.lastStockUpdate,
          totalInvestment: element.totalInvestment,
          potentialRevenue: element.potentialRevenue,
          potentialProfit: element.potentialProfit,
          clientId: element.clientId,
          createdBy: element.createdBy,
          updatedBy: element.updatedBy,
          createdAt: element.createdAt,
          updatedAt: element.updatedAt,
          key: element.key,
        )).toList(),
        source: dealController.selectedSource.value,
        stage: dealController.selectedStageId.value,
        value: int.tryParse(dealController.dealValue.text) ?? 0,
        status: widget.deal.status,
        files: widget.deal.files,
        clientId: userId,
      );
      print("[DEBUG]=> data ${newDeal.toJson()}");

      final success = await dealController.updateDeal(widget.deal.id!,newDeal);

      if (success) {
        print("[DEBUG]=> success");
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Deal updated successfully',
          contentType: ContentType.success,
        );
        Get.back();
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update deal',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {

    }
  }

  Widget _buildCompanyAndContactDropdowns({
    required DealController dealController,
    required ContactController contactController,
  }) {
    return Column(
      children: [
        Obx(
          () => CrmDropdownField<String>(
            title: "Company Name",
            value: dealController.selectedCompany.value,
            items:
                dealController.companies.map((company) {
                  return DropdownMenuItem(
                    value: company.id,
                    child: Text(company.companyName ?? ''),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                dealController.selectedCompany.value = value;

                // Check selected contact
                final selectedContact = contactController.contacts
                    .firstWhereOrNull(
                      (c) => c.id == dealController.selectedContact.value,
                    );

                // If selected contact's company is different, clear contact
                if (selectedContact != null &&
                    selectedContact.companyId != value) {
                  dealController.selectedContact.value = '';
                }
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => CrmDropdownField<String>(
            title: "Contact Name",
            value: dealController.selectedContact.value,
            items:
                contactController.contacts.map((contact) {
                  return DropdownMenuItem(
                    value: contact.id,
                    child: Text(
                      '${contact.firstName} ${contact.lastName} (${contact.companyId ?? 'No Company'})',
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                dealController.selectedContact.value = value;

                // Find contact object
                final contact = contactController.contacts.firstWhereOrNull(
                  (c) => c.id == value,
                );

                if (contact != null) {
                  if (contact.companyId != null &&
                      contact.companyId!.isNotEmpty) {
                    // If contact has a company and selectedCompany is different, update company
                    if (dealController.selectedCompany.value !=
                        contact.companyId) {
                      dealController.selectedCompany.value = contact.companyId!;
                    }
                  } else {
                    // If contact has no company, clear company selection
                    dealController.selectedCompany.value = '';
                  }
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactDetailField({
    required DealController dealController,
    required ContactController contactController,
  }) {
    final CountryController countryController = Get.put(CountryController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CrmTextField(
          title: "First Name",
          controller: dealController.firstName,
          hintText: "Enter first name",
        ),
        const SizedBox(height: 12),
        CrmTextField(
          title: "Last Name",
          controller: dealController.lastName,
          hintText: "Enter last name",
        ),
        const SizedBox(height: 12),
        CrmTextField(
          title: "Email",
          controller: dealController.email,
          hintText: "Enter email",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Obx(
              () => Expanded(
                flex: 2, // smaller space for dropdown
                child: CrmDropdownField<CountryModel>(
                  title: 'Code',
                  isRequired: true,
                  value: dealController.selectedCountryCode.value,
                  items:
                      countryController.countryModel
                          .map(
                            (country) => DropdownMenuItem<CountryModel>(
                              value: country,
                              child: Text(country.phoneCode),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      dealController.selectedCountryCode.value = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: CrmTextField(
                controller: dealController.phoneNumber,
                title: 'Contact',
                isRequired: true,
                keyboardType: TextInputType.phone,
                validator: (value) => phoneValidation(value),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        CrmTextField(
          title: "Address",
          controller: dealController.address,
          hintText: "Enter address",
          maxLines: 2,
        ),
      ],
    );
  }
}
