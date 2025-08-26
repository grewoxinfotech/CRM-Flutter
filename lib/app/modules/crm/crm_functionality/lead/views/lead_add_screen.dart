import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/controller/stage_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/controller/contact_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../../../data/network/user/all_users/model/all_users_model.dart';

class LeadCreateScreen extends StatefulWidget {
  @override
  State<LeadCreateScreen> createState() => _LeadCreateScreenState();
}

class _LeadCreateScreenState extends State<LeadCreateScreen> {
  final RxList<String> selectedMembers = <String>[].obs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final pipelineController = Get.find<PipelineController>();
    final stageController = Get.find<StageController>();

    // Load pipelines and stages initially
    if (pipelineController.pipelines.isEmpty) {
      pipelineController.getPipelines();
    }
    if (stageController.stages.isEmpty) {
      stageController.getStages();
    }
  }

  String? _getCurrencyValue(LeadController leadController) {
    if (leadController.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (leadController.currencies.isNotEmpty) {
      bool currencyExists = leadController.currencies.any(
        (c) => c.id == leadController.currency.value,
      );
      if (currencyExists) {
        return leadController.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return leadController.currencies.first.id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final LeadController leadController = Get.find<LeadController>();
    final PipelineController pipelineController =
        Get.find<PipelineController>();
    final StageController stageController = Get.find<StageController>();
    final UsersController usersController = Get.find<UsersController>();

    return Scaffold(
      appBar: AppBar(title: Text("Create Lead"), leading: CrmBackButton()),
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
                      title: 'Lead Title',
                      controller: leadController.leadTitleController,
                      hintText: 'Enter lead title',
                    ),
                    const SizedBox(height: 16),

                    // Pipeline
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Pipeline",
                        value:
                            leadController.selectedPipelineId.value != null
                                ? null
                                : leadController.selectedPipelineId.value,
                        items:
                            pipelineController.pipelines.map((pipeline) {
                              return DropdownMenuItem(
                                value: pipeline.id,
                                child: Text(pipeline.pipelineName ?? ''),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            leadController.selectedPipelineId.value = value;
                            stageController.getStagesByPipeline(value);
                            leadController.selectedStageId.value = '';
                          }
                        },
                        hintText: "Select pipeline",
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Stage
                    // Obx(
                    //   () => CrmDropdownField<String>(
                    //     title: "Stage",
                    //     value:
                    //         leadController.selectedStageId.value != null
                    //             ? null
                    //             : leadController.selectedStageId.value,
                    //     items:
                    //         stageController.stages.map((stage) {
                    //           return DropdownMenuItem(
                    //             value: stage.id,
                    //             child: Text(stage.stageName ?? ''),
                    //           );
                    //         }).toList(),
                    //     onChanged: (value) {
                    //       if (value != null) {
                    //         leadController.selectedStageId.value = value;
                    //       }
                    //     },
                    //     hintText: "Select stage",
                    //   ),
                    // ),
                    // const SizedBox(height: 16),

                    // Lead Value
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => CrmDropdownField<String>(
                              title: 'Currency',
                              value: _getCurrencyValue(leadController),
                              items:
                                  leadController.isLoadingCurrencies.value &&
                                          leadController.currenciesLoaded.value
                                      ? [
                                        DropdownMenuItem(
                                          value: leadController.currency.value,
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
                                      : leadController.currencies.isNotEmpty
                                      ? leadController.currencies
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
                                    !(leadController
                                            .isLoadingCurrencies
                                            .value &&
                                        leadController
                                            .currenciesLoaded
                                            .value)) {
                                  leadController.updateCurrencyDetails(value);
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
                            title: 'Lead Value',
                            controller: leadController.leadValueController,
                            hintText: 'Enter lead value',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Interest Level
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Interest Level",
                        value:
                            leadController.selectedInterestLevel.value != null
                                ? null
                                : leadController.selectedInterestLevel.value,
                        items:
                            ['low', 'medium', 'high'].map((level) {
                              return DropdownMenuItem(
                                value: level,
                                child: Text(level.capitalizeFirst!),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            leadController.selectedInterestLevel.value = value;
                          }
                        },
                        hintText: "Select interest level",
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Source
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Source",
                        value:
                            leadController.selectedSource.value != null
                                ? null
                                : leadController.selectedSource.value,
                        items:
                            leadController.sourceOptions.isEmpty
                                ? [
                                  DropdownMenuItem(
                                    value: '',
                                    child: Text('No sources available'),
                                  ),
                                ]
                                : leadController.sourceOptions.map((source) {
                                  return DropdownMenuItem(
                                    value: source['id'],
                                    child: Text(source['name'] ?? ''),
                                  );
                                }).toList(),
                        onChanged:
                            leadController.sourceOptions.isEmpty
                                ? (_) {}
                                : (value) {
                                  if (value != null) {
                                    leadController.selectedSource.value = value;
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
                        value:
                            leadController.selectedCategory.value != null
                                ? null
                                : leadController.selectedCategory.value,
                        items:
                            leadController.categoryOptions.isEmpty
                                ? [
                                  DropdownMenuItem(
                                    value: '',
                                    child: Text('No categories available'),
                                  ),
                                ]
                                : leadController.categoryOptions.map((
                                  category,
                                ) {
                                  return DropdownMenuItem(
                                    value: category['id'],
                                    child: Text(category['name'] ?? ''),
                                  );
                                }).toList(),
                        onChanged:
                            leadController.categoryOptions.isEmpty
                                ? (_) {}
                                : (value) {
                                  if (value != null) {
                                    leadController.selectedCategory.value =
                                        value;
                                  }
                                },
                        hintText: "Select category",
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status
                    Obx(
                      () => CrmDropdownField<String>(
                        title: "Status",
                        value:
                            leadController.selectedStatus.value != null
                                ? null
                                : leadController.selectedStatus.value,
                        items:
                            leadController.statusOptions.isEmpty
                                ? [
                                  DropdownMenuItem(
                                    value: '',
                                    child: Text('No statuses available'),
                                  ),
                                ]
                                : leadController.statusOptions.map((status) {
                                  return DropdownMenuItem(
                                    value: status['id'],
                                    child: Text(
                                      (status['name'] ?? '').capitalizeFirst!,
                                    ),
                                  );
                                }).toList(),
                        onChanged:
                            leadController.statusOptions.isEmpty
                                ? (_) {}
                                : (value) {
                                  if (value != null) {
                                    leadController.selectedStatus.value = value;
                                  }
                                },
                        hintText: "Select status",
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Team Members
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
                        const SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Obx(
                                () =>
                                    selectedMembers.isEmpty
                                        ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: Text(
                                              "No team members selected",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        )
                                        : Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children:
                                              selectedMembers.map((memberId) {
                                                final user = usersController
                                                    .getUserById(memberId);
                                                return Chip(
                                                  label: Text(
                                                    user?.username ?? memberId,
                                                  ),
                                                  onDeleted:
                                                      () => selectedMembers
                                                          .remove(memberId),
                                                );
                                              }).toList(),
                                        ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                icon: Icon(Icons.person_add, size: 18),
                                label: Text("Add Team Member"),
                                onPressed:
                                    () => _showTeamMemberSelection(
                                      context,
                                      usersController,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Create Button
                    Obx(
                      () => CrmButton(
                        width: Get.width - 40,
                        title:
                            leadController.isCreating.value
                                ? "Creating..."
                                : "Create Lead",
                        onTap:
                            leadController.isCreating.value
                                ? null
                                : () => _createLead(leadController),
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

  Future<void> _createLead(LeadController leadController) async {
    leadController.isCreating(true);
    try {
      final newLead = LeadModel(
        id: '', // API will generate
        leadTitle: leadController.leadTitleController.text,
        pipeline: leadController.selectedPipelineId.value,
        leadStage: "GZOYta4ks95wESjnnBQXr4Y",
        leadValue: int.tryParse(leadController.leadValueController.text) ?? 0,
        source: leadController.selectedSource.value,
        category: leadController.selectedCategory.value,
        status: leadController.selectedStatus.value,
        interestLevel: leadController.selectedInterestLevel.value,
        leadMembers: LeadMembers(leadMembers: selectedMembers.value),
        currency: leadController.currency.value,
      );
      print("[DEBUG]=> data ${newLead.toJson()}");
      final success = await leadController.createLead(newLead);

      if (success) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Lead created successfully',
          contentType: ContentType.success,
        );
        Get.back(result: newLead);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to create lead',
          contentType: ContentType.failure,
        );
      }
    } finally {
      leadController.isCreating(false);
    }
  }
}
