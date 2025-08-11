import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/controller/stage_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/controller/contact_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LeadEditScreen extends StatefulWidget {
  final String leadId;
  final LeadModel? initialData;
  
  LeadEditScreen({
    required this.leadId,
    this.initialData, 
  });

  @override
  State<LeadEditScreen> createState() => _LeadEditScreenState();
}

class _LeadEditScreenState extends State<LeadEditScreen> {
  late LeadModel currentLead;
  bool isLoading = true;
  final RxList<String> selectedMembers = <String>[].obs;

  @override
  void initState() {
    super.initState();
    // Load the lead data immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialData != null) {
        // Use the initial data if available
        _setLeadData(widget.initialData!);
      } else {
        // Otherwise fetch from API
        _loadLeadData();
      }
    });
  }

  // New method to set data from passed lead model
  void _setLeadData(LeadModel lead) {
    final leadController = Get.find<LeadController>();
    final pipelineController = Get.find<PipelineController>();
    final stageController = Get.find<StageController>();
    
    try {
      setState(() {
        isLoading = true;
      });
      
      currentLead = lead;
      
      // Set the form values with null safety
      leadController.leadTitleController.text = lead.leadTitle ?? '';
      leadController.leadValueController.text = lead.leadValue?.toString() ?? '0';
      
      // Set dropdown values with null safety
      leadController.selectedPipelineId.value = lead.pipeline ?? '';
      leadController.selectedStageId.value = lead.leadStage ?? '';
      leadController.selectedSource.value = lead.source ?? '';
      leadController.selectedCategory.value = lead.category ?? '';
      leadController.selectedStatus.value = lead.status ?? 'active';
      leadController.selectedInterestLevel.value = lead.interestLevel ?? 'medium';
      
      // Set team members with null safety and prevent duplicates
      if (lead.leadMembers != null && lead.leadMembers!.leadMembers != null) {
        // Create a Set to ensure uniqueness
        final uniqueMembers = Set<String>.from(lead.leadMembers!.leadMembers!);
        selectedMembers.value = uniqueMembers.toList();
      } else {
        selectedMembers.value = [];
      }
      
      // Ensure we have pipelines and stages loaded
      if (pipelineController.pipelines.isEmpty) {
        pipelineController.getPipelines();
      }
      
      if (stageController.stages.isEmpty) {
        stageController.getStages();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to set lead data: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadLeadData() async {
    final leadController = Get.find<LeadController>();
    final pipelineController = Get.find<PipelineController>();
    final stageController = Get.find<StageController>();
    
    setState(() {
      isLoading = true;
    });
    
    try {
      // Get the current lead
      final lead = await leadController.getLeadById(widget.leadId);
      
      if (lead != null) {
        _setLeadData(lead);
      } else {
        // Handle case when lead is not found
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Lead not found',
          contentType: ContentType.failure,
        );
        Get.back(); // Return to previous screen
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load lead data: ${e.toString()}',
        contentType: ContentType.failure,
      );
      // Return to previous screen on error
      Get.back();
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final LeadController leadController = Get.find<LeadController>();
    final PipelineController pipelineController = Get.find<PipelineController>();
    final StageController stageController = Get.find<StageController>();
    final ContactController contactController = Get.find<ContactController>();
    final UsersController usersController = Get.find<UsersController>();

    return WillPopScope(
      onWillPop: () async {
        // Refresh data before popping
        await leadController.refreshData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Edit Lead"), leading: CrmBackButton()),
        body: isLoading 
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
                  value: leadController.selectedPipelineId.value?.isEmpty ?? true ? null : leadController.selectedPipelineId.value,
                  items: pipelineController.pipelines.map((pipeline) {
                    return DropdownMenuItem(
                      value: pipeline.id,
                      child: Text(pipeline.pipelineName ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      leadController.selectedPipelineId.value = value;
                      
                      // When pipeline changes, update available stages
                      stageController.getStagesByPipeline(value);
                      
                      // Reset stage selection
                      leadController.selectedStageId.value = null;
                    }
                  },
                  hintText: "Select pipeline",
                ),
              ),
              const SizedBox(height: 16),
                  
              // Stage
              Obx(
                () => CrmDropdownField<String>(
                  title: "Stage",
                  value: leadController.selectedStageId.value?.isEmpty ?? true ? null : leadController.selectedStageId.value,
                  items: stageController.stages.map((stage) {
                    return DropdownMenuItem(
                      value: stage.id,
                      child: Text(stage.stageName ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      leadController.selectedStageId.value = value;
                    }
                  },
                  hintText: "Select stage",
                ),
              ),
              const SizedBox(height: 16),
                  
              // Lead Value
              Row(
                children: [
                  // Currency selection (if needed)
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        currentLead.currency ?? 'INR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Lead Value
                  Expanded(
                    flex: 4,
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
                  value: leadController.selectedInterestLevel.value?.isEmpty ?? true ? null : leadController.selectedInterestLevel.value,
                  items: ['low', 'medium', 'high'].map((level) {
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
                  value: leadController.selectedSource.value?.isEmpty ?? true ? null : leadController.selectedSource.value,
                  items: leadController.sourceOptions.isEmpty 
                      ? [DropdownMenuItem(value: '', child: Text('No sources available'))]
                      : leadController.sourceOptions.map((source) {
                          return DropdownMenuItem(
                            value: source['id'],
                            child: Text(source['name'] ?? ''),
                          );
                        }).toList(),
                  onChanged: leadController.sourceOptions.isEmpty 
                      ? (_) {} // Empty function when no options
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
                  value: leadController.selectedCategory.value?.isEmpty ?? true ? null : leadController.selectedCategory.value,
                  items: leadController.categoryOptions.isEmpty 
                      ? [DropdownMenuItem(value: '', child: Text('No categories available'))]
                      : leadController.categoryOptions.map((category) {
                          return DropdownMenuItem(
                            value: category['id'],
                            child: Text(category['name'] ?? ''),
                          );
                        }).toList(),
                  onChanged: leadController.categoryOptions.isEmpty 
                      ? (_) {} // Empty function when no options
                      : (value) {
                          if (value != null) {
                            leadController.selectedCategory.value = value;
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
                  value: leadController.selectedStatus.value?.isEmpty ?? true ? null : leadController.selectedStatus.value,
                  items: leadController.statusOptions.isEmpty 
                      ? [DropdownMenuItem(value: '', child: Text('No statuses available'))]
                      : leadController.statusOptions.map((status) {
                          return DropdownMenuItem(
                            value: status['id'],
                            child: Text((status['name'] ?? '').capitalizeFirst!),
                          );
                        }).toList(),
                  onChanged: leadController.statusOptions.isEmpty 
                      ? (_) {} // Empty function when no options
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
                        Obx(() => selectedMembers.isEmpty
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
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: selectedMembers.map((memberId) {
                                    final user = usersController.getUserById(memberId);
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Get.theme.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Get.theme.primaryColor.withOpacity(0.3)),
                                      ),
                                      child: Chip(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        avatar: CircleAvatar(
                                          backgroundColor: Get.theme.primaryColor,
                                          child: Text(
                                            (user?.username.substring(0, 1) ?? 'U').toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        label: Text(
                                          user?.username ?? memberId,
                                          style: TextStyle(
                                            color: Get.theme.primaryColor.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        deleteIconColor: Get.theme.primaryColor,
                                        onDeleted: () {
                                          selectedMembers.remove(memberId);
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
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
                            _showTeamMemberSelection(context, usersController);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                  
              const SizedBox(height: 24),
                  
              // Update Button
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Obx(
                () => CrmButton(
                  width: Get.width - 40,
                        title: leadController.isUpdating.value ? "Updating..." : "Update Lead",
                        onTap: leadController.isUpdating.value ? null : () => _updateLead(leadController),
                        backgroundColor: Get.theme.primaryColor,
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.primaryColor.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        height: 50,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTeamMemberSelection(BuildContext context, UsersController usersController) {
    // Create a search controller and filtered users list
    final searchController = TextEditingController();
    final RxList<User> filteredUsers = RxList<User>([...usersController.users]);
    
    // Function to filter users based on search text
    void filterUsers(String query) {
      if (query.isEmpty) {
        filteredUsers.value = [...usersController.users];
      } else {
        filteredUsers.value = usersController.users
            .where((user) => 
                user.username.toLowerCase().contains(query.toLowerCase()) ||
                user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    }
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
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
                      prefixIcon: Icon(Icons.search, color: Get.theme.primaryColor.withOpacity(0.7)),
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
                Obx(() => Flexible(
                  child: filteredUsers.isEmpty 
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
                          final isSelected = selectedMembers.contains(user.id);
                          
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: isSelected ? Get.theme.primaryColor.withOpacity(0.1) : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? Get.theme.primaryColor.withOpacity(0.5) : Colors.grey.shade300,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              leading: CircleAvatar(
                                backgroundColor: isSelected ? Get.theme.primaryColor : Colors.grey.shade300,
                                child: Text(
                                  user.username.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                user.username,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              subtitle: Text(
                                user.email,
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: isSelected 
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
                                  if (!selectedMembers.contains(user.id)) {
                                    selectedMembers.add(user.id);
                                  }
                                }
                              },
                            ),
                          );
                        });
                      },
                    ),
                )),
                
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

  Future<void> _updateLead(LeadController leadController) async {
    // Show loading indicator from bottom
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Updating Lead',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Please wait...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    
    try {
      // Show loading state
      leadController.isUpdating(true);
      
      // Create updated lead model
      final updatedLead = LeadModel(
        id: widget.leadId,
        leadTitle: leadController.leadTitleController.text,
        pipeline: leadController.selectedPipelineId.value,
        leadStage: leadController.selectedStageId.value,
        leadValue: int.tryParse(leadController.leadValueController.text) ?? 0,
        source: leadController.selectedSource.value,
        category: leadController.selectedCategory.value,
        status: leadController.selectedStatus.value,
        interestLevel: leadController.selectedInterestLevel.value,
        // Team members
        leadMembers: LeadMembers(leadMembers: selectedMembers.value),
        // Preserve other fields from current lead
        contactId: currentLead.contactId,
        companyId: currentLead.companyId,
        clientId: currentLead.clientId,
        currency: currentLead.currency,
        files: currentLead.files,
        createdAt: currentLead.createdAt,
        createdBy: currentLead.createdBy,
        updatedAt: DateTime.now().toIso8601String(),
        updatedBy: currentLead.updatedBy,
        inquiryId: currentLead.inquiryId,
      );
      
    
      
      final success = await leadController.updateLead(widget.leadId, updatedLead);
      
      // Close the loading bottom sheet
      if (Navigator.canPop(Get.context!)) {
        Navigator.pop(Get.context!);
      }
      
      if (success) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Lead updated successfully',
          contentType: ContentType.success,
        );
        
        // Update the lead in the controller's list directly to avoid extra API call
        final index = leadController.leads.indexWhere((lead) => lead.id == widget.leadId);
        if (index != -1) {
          leadController.leads[index] = updatedLead;
        }
        
        Get.back(result: updatedLead); // Return to previous screen with updated data
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update lead. Please check your connection and try again.',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      // Close the loading bottom sheet
      if (Navigator.canPop(Get.context!)) {
        Navigator.pop(Get.context!);
      }
      
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update lead: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      // Reset loading state
      leadController.isUpdating(false);
    }
  }
}
