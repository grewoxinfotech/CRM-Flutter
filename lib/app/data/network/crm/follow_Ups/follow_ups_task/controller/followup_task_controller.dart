import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/model/followup_task_model.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/service/followup_task_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUpTaskController extends GetxController {
  final FollowUpTaskService _service = FollowUpTaskService();
  
  final RxList<FollowUpTaskModel> tasks = <FollowUpTaskModel>[].obs;
  final Rx<FollowUpTaskModel?> selectedTask = Rx<FollowUpTaskModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Form fields
  final RxString selectedPriority = 'medium'.obs;
  final Rx<DateTime?> dueDate = Rx<DateTime?>(null);
  final Rx<DateTime?> reminderDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> reminderTime = Rx<TimeOfDay?>(null);
  final RxString repeatType = 'none'.obs;
  final RxString repeatEndType = 'never'.obs;
  final Rx<DateTime?> repeatEndDate = Rx<DateTime?>(null);
  final TextEditingController repeatTimesController = TextEditingController();

  // Fetch all tasks
  Future<void> fetchAllTasks(String dealId) async {
    try {
      isLoading.value = true;
      error.value = '';
      final fetchedTasks = await _service.getAllFollowUpTasks(dealId);
      tasks.value = fetchedTasks;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new task
  Future<bool> createTask(FollowUpTaskModel task) async {
    try {
      isLoading.value = true;
      error.value = '';
      final createdTask = await _service.createFollowUpTask(task);
      tasks.add(createdTask);
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Get task by ID
  Future<void> fetchTaskById(String taskId, String dealId) async {
    try {
      isLoading.value = true;
      error.value = '';
      final task = await _service.getFollowUpTaskById(taskId, dealId);
      selectedTask.value = task;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Update task
  Future<bool> updateTask(String taskId, FollowUpTaskModel task) async {
    try {
      isLoading.value = true;
      error.value = '';
      final updatedTask = await _service.updateFollowUpTask(taskId, task);
      final index = tasks.indexWhere((t) => t.id == taskId);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
      if (selectedTask.value?.id == taskId) {
        selectedTask.value = updatedTask;
      }
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete task
  Future<bool> deleteTask(String taskId, String dealId) async {
    try {
      isLoading.value = true;
      error.value = '';
      final success = await _service.deleteFollowUpTask(taskId, dealId);
      if (success) {
        tasks.removeWhere((task) => task.id == taskId);
        if (selectedTask.value?.id == taskId) {
          selectedTask.value = null;
        }
      }
      return success;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Clear error
  void clearError() {
    error.value = '';
  }

  // Clear selected task
  void clearSelectedTask() {
    selectedTask.value = null;
  }
}
