import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/service/lead_service.dart';
import 'package:get/get.dart';

/// Controller for managing lead in the CRM system
class LeadController extends GetxController {
  LeadService leadService = LeadService();
  List<LeadModel> leads = [];

  Future<List<LeadModel>> getLeads() async => await LeadService.getLeads();
}

//   RxBool isLoading = false.obs;
//   List<LeadModel> leads = [];
//
//   // all service
//   final LeadService leadService = LeadService();
//
//   // final StageService stageService = StageService();
//   final LabelService labelService = LabelService();
//   final AllUserService allUserService = AllUserService();
//   final RolesService rolesService = RolesService();
//
//   // State Variables
//   final RxList<StageModel> stages = <StageModel>[].obs;
//   final RxList<LabelModel> labels = <LabelModel>[].obs;
//
//   // final RxList<AllUserModel> allUsers = <AllUserModel>[].obs;
//   // final RxList<RolesModel> roless = <RolesModel>[].obs;
//
//   // Form Controllers
//   final leadTitleController = TextEditingController();
//   final leadValueController = TextEditingController();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final companyController = TextEditingController();
//   final addressController = TextEditingController();
//
//   // Dropdown Selections
//   final selectedPipeline = ''.obs;
//   final selectedPipelineId = ''.obs;
//   final selectedSource = ''.obs;
//   final selectedCategory = ''.obs;
//   final selectedInterestLevel = ''.obs;
//   final selectedStage = ''.obs;
//   final selectedStageId = ''.obs;
//   final selectedStatus = ''.obs;
//
//   // Dropdown Options - Show names in UI
//   List<String> get sourceOptions =>
//       labelService.getSources(labels).map((e) => e.name).toList();
//
//   List<String> get categoryOptions =>
//       labelService.getCategories(labels).map((e) => e.name).toList();
//
//   List<String> get statusOptions =>
//       labelService.getStatuses(labels).map((e) => e.name).toList();
//
//   final List<String> interestLevelOptions = ['high', 'medium', 'low'];
//
//   // Helper method to get ID from name and type
//   String getLabelId(String name, String type) {
//     final labelList =
//         type == 'source'
//             ? labelService.getSources(labels)
//             : type == 'category'
//             ? labelService.getCategories(labels)
//             : labelService.getStatuses(labels);
//
//     return labelList
//         .firstWhere(
//           (e) => e.name == name,
//           orElse:
//               () => LabelModel(
//                 id: '',
//                 relatedId: '',
//                 labelType: type,
//                 name: '',
//                 color: '',
//                 clientId: '',
//                 createdBy: '',
//                 createdAt: DateTime.now(),
//                 updatedAt: DateTime.now(),
//               ),
//         )
//         .id;
//   }
//
//   @override
//   void onClose() {
//     leadTitleController.dispose();
//     leadValueController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     companyController.dispose();
//     addressController.dispose();
//     super.onClose();
//   }
//
//   Future<void> refreshData() async {
//     await Future.wait([
//       getLeads(),
//       // getPipelines(),
//       // getStages(),
//       getLabels(),
//       getRoles(),
//       getAllUsers(),
//     ]);
//   }
//
//   Future<void> getRoles() async {
//     try {
//       await rolesService.getRoles();
//     } catch (e) {
//       print('Error in getRoles: $e');
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: 'Failed to fetch roles',
//         contentType: ContentType.failure,
//       );
//     } finally {}
//   }
//
//   Future<void> getLabels() async {
//     try {
//       final labelsList = await labelService.getLabels();
//       labels.assignAll(labelsList);
//     } catch (e) {
//       print('Error in getLabels: $e');
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: 'Failed to fetch labels',
//         contentType: ContentType.failure,
//       );
//     } finally {}
//   }
//
//   //
//   // Future<void> getStages() async {
//   //   try {
//   //     final stagesList = await stageService.getStages(stageType: 'lead');
//   //     stages.assignAll(stagesList);
//   //   } catch (e) {
//   //     print('Error in getStages: $e');
//   //   } finally {}
//   // }
//   //
//   // // Get stages for a specific pipeline
//   // List<StageModel> getStagesForPipeline(String pipelineId) {
//   //   if (pipelineId.isEmpty) return [];
//   //   final pipelineStages =
//   //       stages.where((stage) => stage.pipeline == pipelineId).toList();
//   //
//   //   // Sort stages to put default stage first
//   //   pipelineStages.sort((a, b) {
//   //     if (a.isDefault) return -1;
//   //     if (b.isDefault) return 1;
//   //     return 0;
//   //   });
//   //
//   //   return pipelineStages;
//   // }
//   //
//   // // Get default stage for a pipeline
//   // StageModel? getDefaultStageForPipeline(String pipelineId) {
//   //   if (pipelineId.isEmpty) return null;
//   //   return stages.firstWhereOrNull(
//   //     (stage) => stage.pipeline == pipelineId && stage.isDefault,
//   //   );
//   // }
//
//   // Update pipeline selection
//   // void updatePipeline(String? pipelineName, String? pipelineId) {
//   //   if (pipelineName == null || pipelineId == null) {
//   //     selectedPipeline.value = '';
//   //     selectedPipelineId.value = '';
//   //     selectedStage.value = '';
//   //     selectedStageId.value = '';
//   //     return;
//   //   }
//   //
//   //   selectedPipeline.value = pipelineName;
//   //   selectedPipelineId.value = pipelineId;
//   //
//   //   // Always set the default stage for the pipeline
//   //   final defaultStage = getDefaultStageForPipeline(pipelineId);
//   //   if (defaultStage != null) {
//   //     selectedStage.value = defaultStage.stageName;
//   //     selectedStageId.value = defaultStage.id;
//   //   } else {
//   //     // If no default stage found, get the first stage for this pipeline
//   //     final pipelineStages = getStagesForPipeline(pipelineId);
//   //     if (pipelineStages.isNotEmpty) {
//   //       final firstStage = pipelineStages.first;
//   //       selectedStage.value = firstStage.stageName;
//   //       selectedStageId.value = firstStage.id;
//   //     } else {
//   //       selectedStage.value = '';
//   //       selectedStageId.value = '';
//   //     }
//   //   }
//   // }
//
//   Future<void> addLead() async {
//     try {
//       // Collect all form data
//       final Map<String, dynamic> leadData = {
//         'leadTitle': leadTitleController.text,
//         'leadStage': selectedStage.value,
//         'pipeline': selectedPipeline.value,
//         'currency': 'USD',
//         'leadValue': int.tryParse(leadValueController.text) ?? 0,
//         'source': getLabelId(selectedSource.value, 'source'),
//         'category': getLabelId(selectedCategory.value, 'category'),
//         'status': getLabelId(selectedStatus.value, 'status'),
//         'interest_level': 'medium',
//         'client_id': 'default',
//         'created_by': 'default',
//         'firstName': firstNameController.text,
//         'lastName': lastNameController.text,
//         'email': emailController.text,
//         'phone': phoneController.text,
//         'company': companyController.text,
//         'address': addressController.text,
//       };
//
//       // Validate required fields
//       if ((leadData['leadTitle'] as String?)?.isEmpty ?? true) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Validation Error',
//           message: 'Lead title is required',
//           contentType: ContentType.warning,
//         );
//         return;
//       }
//
//       if ((leadData['pipeline'] as String?)?.isEmpty ?? true) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Validation Error',
//           message: 'Pipeline is required',
//           contentType: ContentType.warning,
//         );
//         return;
//       }
//
//       if (leadData['leadValue'] == 0) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Validation Error',
//           message: 'Lead value is required',
//           contentType: ContentType.warning,
//         );
//         return;
//       }
//
//       if ((leadData['source'] as String?)?.isEmpty ?? true) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Validation Error',
//           message: 'Source is required',
//           contentType: ContentType.warning,
//         );
//         return;
//       }
//
//       final response = await leadService.createLead(leadData);
//
//       if (response.statusCode == 200) {
//         // Clear form
//         leadTitleController.clear();
//         leadValueController.clear();
//         firstNameController.clear();
//         lastNameController.clear();
//         emailController.clear();
//         phoneController.clear();
//         companyController.clear();
//         addressController.clear();
//         selectedPipeline.value = '';
//         selectedPipelineId.value = '';
//         selectedSource.value = '';
//         selectedCategory.value = '';
//         selectedInterestLevel.value = '';
//         selectedStage.value = '';
//         selectedStageId.value = '';
//         selectedStatus.value = '';
//
//         // Refresh all data
//         await refreshData();
//         Get.back();
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Success',
//           message: 'Lead created successfully',
//           contentType: ContentType.success,
//         );
//       } else {
//         String errorMessage = 'Failed to create lead';
//         String? serverMessage;
//
//         try {
//           final responseData = jsonDecode(response.body);
//           if (responseData is Map) {
//             serverMessage = responseData['message'] ?? responseData['error'];
//           }
//         } catch (e) {
//           print('Error parsing response: $e');
//         }
//
//         // Handle specific error cases
//         if (response.statusCode == 400) {
//           errorMessage = serverMessage ?? 'Invalid lead data provided';
//         } else if (response.statusCode == 401) {
//           errorMessage = 'Unauthorized. Please login again';
//         } else if (response.statusCode == 403) {
//           errorMessage = 'You do not have permission to create lead';
//         } else if (response.statusCode == 409) {
//           errorMessage = 'A lead with this email already exists';
//         } else if (response.statusCode == 500) {
//           errorMessage = 'Server error. Please try again later';
//         }
//
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Error',
//           message: errorMessage,
//           contentType: ContentType.failure,
//         );
//       }
//     } catch (e) {
//       String errorMessage = 'Failed to create lead';
//
//       // if (e.toString().contains('SocketException')) {
//       //   errorMessage = 'No internet connection. Please check your network';
//       // } else if (e.toString().contains('TimeoutException')) {
//       //   errorMessage = 'Request timed out. Please try again';
//       // } else if (e.toString().contains('FormatException')) {
//       //   errorMessage = 'Invalid data format. Please check your input';
//       // }
//
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: errorMessage,
//         contentType: ContentType.failure,
//       );
//     } finally {}
//   }
//
//   Future<void> editLead(String leadId) async {
//     try {
//       final leadData = await leadService.getLeadById(leadId);
//       if (leadData != null) {
//         leadTitleController.text = leadData['title'] ?? '';
//         selectedPipeline.value = leadData['pipeline'] ?? '';
//         selectedPipelineId.value = leadData['pipeline'] ?? '';
//         leadValueController.text = leadData['value'] ?? '';
//         selectedSource.value = leadData['source'] ?? '';
//         selectedCategory.value = leadData['category'] ?? '';
//         selectedInterestLevel.value = leadData['interestLevel'] ?? '';
//         selectedStage.value = leadData['stage'] ?? '';
//         selectedStageId.value = leadData['stage'] ?? '';
//         selectedStatus.value = leadData['status'] ?? '';
//         firstNameController.text = leadData['firstName'] ?? '';
//         lastNameController.text = leadData['lastName'] ?? '';
//         emailController.text = leadData['email'] ?? '';
//         phoneController.text = leadData['phone'] ?? '';
//         companyController.text = leadData['company'] ?? '';
//         addressController.text = leadData['address'] ?? '';
//       }
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: 'Failed to fetch lead details',
//         contentType: ContentType.failure,
//       );
//     }
//   }
//
//   Future<bool> deleteLead(String id) async {
//     try {
//       final isDeleted = await leadService.deleteLead(id);
//       if (isDeleted) {
//         await getLeads();
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Success',
//           message: 'Lead deleted successfully',
//           contentType: ContentType.success,
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: 'Failed to delete lead',
//         contentType: ContentType.failure,
//       );
//       return false;
//     }
//   }
//
//   Future<void> getAllUsers() async {
//     try {
//       final data = await allUserService.fetchAllUsers();
//     } catch (e) {
//       print('Error in getAllUsers: $e');
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: 'Failed to fetch user: ${e.toString()}',
//         contentType: ContentType.failure,
//       );
//     } finally {}
//   }
//
//   // List<UserModel> getLeadMembers(List<String> memberIds) {
//   //   try {
//   //     if (memberIds.isEmpty) return [];
//   //
//   //     final members =
//   //     allUserService.allUsers
//   //             .where((user) => user.id != null && memberIds.contains(user.id))
//   //             .toList();
//   //
//   //     print('Found ${members.length} members for IDs: $memberIds');
//   //     return members;
//   //   } catch (e) {
//   //     print('Error in getLeadMembers: $e');
//   //     return [];
//   //   }
//   // }
//
//   // get label names for display
//   String getSourceName(String id) {
//     return labelService
//         .getSources(labels)
//         .firstWhere(
//           (e) => e.id == id,
//           orElse:
//               () => LabelModel(
//                 id: '',
//                 relatedId: '',
//                 labelType: 'source',
//                 name: '',
//                 color: '',
//                 clientId: '',
//                 createdBy: '',
//                 createdAt: DateTime.now(),
//                 updatedAt: DateTime.now(),
//               ),
//         )
//         .name;
//   }
//
//   String getCategoryName(String id) {
//     return labelService
//         .getCategories(labels)
//         .firstWhere(
//           (e) => e.id == id,
//           orElse:
//               () => LabelModel(
//                 id: '',
//                 relatedId: '',
//                 labelType: 'category',
//                 name: '',
//                 color: '',
//                 clientId: '',
//                 createdBy: '',
//                 createdAt: DateTime.now(),
//                 updatedAt: DateTime.now(),
//               ),
//         )
//         .name;
//   }
//
//   String getStatusName(String id) {
//     return labelService
//         .getStatuses(labels)
//         .firstWhere(
//           (e) => e.id == id,
//           orElse:
//               () => LabelModel(
//                 id: '',
//                 relatedId: '',
//                 labelType: 'status',
//                 name: '',
//                 color: '',
//                 clientId: '',
//                 createdBy: '',
//                 createdAt: DateTime.now(),
//                 updatedAt: DateTime.now(),
//               ),
//         )
//         .name;
//   }
