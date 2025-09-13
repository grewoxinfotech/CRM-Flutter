import 'package:get/get.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/job/job_list/job_list_service.dart';

class JobListController extends GetxController {
  final JobListService _jobService = JobListService();

  /// Observables
  var jobs = <JobData>[].obs;
  var isLoading = false.obs;
  var pagination = Pagination().obs;

  /// Fetch jobs with pagination & search
  Future<void> fetchJobs({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      isLoading.value = true;
      final response = await _jobService.fetchJobs(
        page: page,
        pageSize: pageSize,
        search: search,
      );

      if (response != null && response.message?.data != null) {
        jobs.value = response.message!.data!;
        pagination.value = response.message?.pagination ?? Pagination();
      }
    } catch (e) {
      print("Fetch jobs exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Get single job by ID
  Future<JobData?> getJobById(String id) async {
    try {
      return await _jobService.getJobById(id);
    } catch (e) {
      print("Get job by ID exception: $e");
      return null;
    }
  }

  /// Create job
  Future<bool> createJob(JobData job) async {
    final success = await _jobService.createJob(job);
    if (success) {
      await fetchJobs(); // refresh list
    }
    return success;
  }

  /// Update job
  Future<bool> updateJob(String id, JobData job) async {
    final success = await _jobService.updateJob(id, job);
    if (success) {
      await fetchJobs(); // refresh list
    }
    return success;
  }

  /// Delete job
  Future<bool> deleteJob(String id) async {
    final success = await _jobService.deleteJob(id);
    if (success) {
      jobs.removeWhere((job) => job.id == id);
    }
    return success;
  }
}
