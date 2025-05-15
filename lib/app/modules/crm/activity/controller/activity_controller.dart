import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/activity/model/activity_model.dart';
import 'package:crm_flutter/app/data/network/activity/service/activity_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController {
  final ActivityService activityService = ActivityService();
  
  final RxBool isLoading = false.obs;
  final RxList<Activity> activities = <Activity>[].obs;
  final RxString currentRelatedId = ''.obs;

  Future<void> getActivities(String relatedId) async {
    try {
      isLoading.value = true;
      currentRelatedId.value = relatedId;
      
      final response = await activityService.getActivities(relatedId);
      
      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> activitiesData = response['data'];
        activities.assignAll(
          activitiesData.map((json) => Activity.fromJson(json)).toList(),
        );
      } else {
        activities.clear();
        throw Exception(response['message'] ?? 'Failed to load activities');
      }
    } catch (e) {
      activities.clear();
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch activities: $e",
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to refresh current activities
  Future<void> refreshActivities() async {
    if (currentRelatedId.value.isNotEmpty) {
      await getActivities(currentRelatedId.value);
    }
  }

  @override
  void onInit() {
    super.onInit();
    
  }

 
}
