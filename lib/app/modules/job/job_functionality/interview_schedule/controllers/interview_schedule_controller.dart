import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/database/storage/secure_storage_service.dart';
import '../../../../../data/network/job/interview_schedule/interview_schedule_model.dart';
import '../../../../../data/network/job/interview_schedule/interview_schedule_service.dart';
import '../../../../../data/network/job/job_applications/job_application_model.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../users/controllers/users_controller.dart';
import '../../job_applications/controllers/job_application_controller.dart';
import '../../job_list/controllers/job_list_controller.dart';

class InterviewScheduleController extends GetxController {
  final InterviewScheduleService _service = InterviewScheduleService();
  final String url = UrlRes.interviewSchedules;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  /// Controllers for form fields
  final TextEditingController commentForInterviewerController = TextEditingController();
  final TextEditingController commentForCandidateController = TextEditingController();

  final RxList<JobData> jobPositions = <JobData>[].obs;
  final JobListController jobListController = Get.put(JobListController());
  final Rxn<JobData> selectedJobPosition = Rxn<JobData>();

  final RxList<JobApplicationData> jobApplications = <JobApplicationData>[].obs;
  final jobApplicationController = Get.put(JobApplicationController());
  final Rxn<JobApplicationData> selectedJobApplication = Rxn<JobApplicationData>();

  final RxList<User> managers = <User>[].obs;
  final UsersController usersController = Get.put(UsersController());
  Rxn<User> selectedManager = Rxn<User>();

  final List<String> interviewRoundList = ["technical","hr","culture fit","final"];
  final RxList<String> selectedInterviewRound = <String>[].obs;

  final List<String> interviewType = ['online', 'offline'];
  final RxString selectedInterviewType = ''.obs;

  final TextEditingController startOnController = TextEditingController();
  final Rxn<DateTime> selectedStart = Rxn<DateTime>();

  final TextEditingController startTimeController = TextEditingController();
  final Rxn<TimeOfDay> selectedStartTime = Rxn<TimeOfDay>();

  /// Reactive list of interview schedules
  final RxList<InterviewScheduleData> items = <InterviewScheduleData>[].obs;

  /// --- Calendar State ---
  final focusedMonth = DateTime.now().obs;
  final selectedDay = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    loadInterviewSchedules();
    loadBackground();
  }

  void loadBackground(){
    loadJobs();
    loadJobApplications();
    loadManagers();
  }

  Future<void> loadJobs() async {
    try {
      await jobListController.loadInitial();
      if (jobListController.items.isNotEmpty) {
        jobPositions.assignAll(
          jobListController.items.map((item) => item).toList(),
        );
      }

      if (jobPositions.isNotEmpty && selectedJobPosition.value == null) {
        selectedJobPosition.value = jobPositions.first;
      }
    } catch (e, stackTrace) {
      print("Error loading jobs: $e");
      print(stackTrace);
    }
  }

  Future<JobData?> getJobById(String id) async {
    try {
      final user = await jobListController.getJobById(id);
      if (user != null && !jobPositions.any((m) => m.id == user.id)) {
        jobPositions.add(user);
      }
      return user;
    } catch (e) {
      print("Error loading manager by ID: $e");
    }
  }

  Future<void> loadJobApplications() async {
    try {
      await jobApplicationController.loadInitial();
      if (jobApplicationController.items.isNotEmpty) {
        jobApplications.assignAll(
          jobApplicationController.items.map((item) => item).toList(),
        );
      }

      if (jobApplications.isNotEmpty && selectedJobApplication.value == null) {
        selectedJobApplication.value = jobApplications.first;
      }
    } catch (e, stackTrace) {
      print("Error loading job Application: $e");
      print(stackTrace);
    }
  }

  Future<JobApplicationData?> getJobApplicationById(String id) async {
    try {
      final user = await jobApplicationController.getJobApplicationById(id);
      if (user != null && !jobApplications.any((m) => m.id == user.id)) {
        jobApplications.add(user);
      }
      return user;
    } catch (e) {
      print("Error loading job Application by ID: $e");
    }
  }

  /// Load all managers for the current client
  Future<void> loadManagers() async {
    try {
      final userData = await SecureStorage.getUserData();
      final clientId = userData?.id;
      if (clientId == null || clientId.isEmpty) {
        print("No client ID found for the current user.");
        return;
      }

      final clientUsers = await usersController.getUsersByClientId(clientId);
      managers.assignAll(clientUsers);

      print("Managers loaded: ${managers.length}");

      if (managers.isNotEmpty && selectedManager.value == null) {
        selectedManager.value = managers.first;
      }
    } catch (e, stackTrace) {
      print("Error loading managers: $e");
      print(stackTrace);
    }
  }

  /// Load a specific manager by ID if not already in the list
  Future<User?> getManagerById(String id) async {
    try {
      final user = await usersController.getUserById(id);
      if (user != null && !managers.any((m) => m.id == user.id)) {
        managers.add(user);
      }
      return user;
    } catch (e) {
      print("Error loading manager by ID: $e");
    }
  }

  /// Fetch all interview schedules
  Future<void> loadInterviewSchedules() async {
    try {
      final response = await _service.fetchInterviewSchedules();
      if (response != null && response.success == true) {
        items.assignAll(response.data ?? []);
      } else {
        errorMessage.value = response?.message ?? "Failed to fetch interview schedules";
      }
    } catch (e) {
      errorMessage.value = "Exception in loadInterviewSchedules: $e";
    }
  }

  /// Reset form
  void resetForm() {
    // if(interviewRoundList.isNotEmpty){
    //   selectedInterviewRound.a = interviewRoundList.first;
    // }
    if(interviewType.isNotEmpty){
      selectedInterviewType.value = interviewType.first;
    }
    startOnController.clear();
    startTimeController.clear();
    commentForInterviewerController.clear();
    commentForCandidateController.clear();
  }

  /// Create interview schedule
  Future<bool> createInterviewSchedule(InterviewScheduleData schedule) async {
    try {
      isLoading.value = true;
      final success = await _service.createInterviewSchedule(schedule);
      if (success) await loadInterviewSchedules();
      isLoading.value = false;
      return success;
    } catch (e) {
      print("Create interview schedule error: $e");
      isLoading.value = false;
      return false;
    }
  }

  /// Update interview schedule
  Future<bool> updateInterviewSchedule(String id, InterviewScheduleData updatedSchedule) async {
    try {
      isLoading.value = true;
      final success = await _service.updateInterviewSchedule(id, updatedSchedule);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedSchedule;
          items.refresh();
        }
      }
      isLoading.value = false;
      return success;
    } catch (e) {
      print("Update interview schedule error: $e");
      isLoading.value = false;
      return false;
    }
  }

  /// Delete interview schedule
  Future<bool> deleteInterviewSchedule(String id) async {
    try {
      final success = await _service.deleteInterviewSchedule(id);
      if (success) items.removeWhere((item) => item.id == id);
      return success;
    } catch (e) {
      print("Delete interview schedule error: $e");
      return false;
    }
  }

  /// Get schedules for a specific day
  List<InterviewScheduleData> getSchedulesForDay(DateTime day) {
    return items.where((event) {
      if (event.startOn == null) return false;
      try {
        final eventDate = DateTime.parse(event.startOn!);
        return DateUtils.isSameDay(eventDate, day);
      } catch (_) {
        return false;
      }
    }).toList();
  }

  /// Get schedules for the focused month
  List<InterviewScheduleData> getSchedulesForFocusedMonth() {
    return items.where((event) {
      if (event.startOn == null) return false;
      try {
        final eventDate = DateTime.parse(event.startOn!);
        return eventDate.year == focusedMonth.value.year &&
            eventDate.month == focusedMonth.value.month;
      } catch (_) {
        return false;
      }
    }).toList();
  }

  /// Build calendar days for the grid
  /// Pass optional callback when tapping an empty day
  List<Widget> buildCalendarDays({Function(DateTime)? onEmptyDayTap}) {
    final firstDayOfMonth = DateTime(focusedMonth.value.year, focusedMonth.value.month, 1);
    final daysInMonth = DateTime(focusedMonth.value.year, focusedMonth.value.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;

    List<Widget> dayWidgets = [];

    // Empty boxes before the first day
    for (int i = 1; i < startingWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Actual days
    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate = DateTime(focusedMonth.value.year, focusedMonth.value.month, day);
      final schedulesForDay = getSchedulesForDay(currentDate);
      final hasEvents = schedulesForDay.isNotEmpty;

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            selectedDay.value = currentDate;
            if (!hasEvents && onEmptyDayTap != null) {
              onEmptyDayTap(currentDate); // Open add interview screen for empty day
            }
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: selectedDay.value != null &&
                  DateUtils.isSameDay(selectedDay.value, currentDate)
                  ? Colors.blueAccent.withOpacity(0.2)
                  : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasEvents ? Colors.blue : Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Text(
                "$day",
                style: TextStyle(
                  fontWeight: hasEvents ? FontWeight.bold : FontWeight.normal,
                  color: hasEvents ? Colors.blue : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }
}
