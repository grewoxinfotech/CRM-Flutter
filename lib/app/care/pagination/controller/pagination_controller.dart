import 'package:get/get.dart';

abstract class PaginatedController<T> extends GetxController {
  var items = <T>[].obs;
  var isLoading = false.obs;      // For initial loading & refresh
  var isPaging = false.obs;       // For loading next pages
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isRefreshing = false.obs;

  Future<List<T>> fetchItems(int page);

  Future<void> loadInitial() async {
    print("Pagination: loadInitial called");
    currentPage.value = 1;
    items.clear();
    await _loadPage(page: 1);
  }

  Future<void> loadMore() async {
    if (currentPage.value < totalPages.value && !isPaging.value && !isLoading.value) {
      print("Pagination: loadMore called. Current page: ${currentPage.value}, Total pages: ${totalPages.value}");
      currentPage.value += 1;
      await _loadPage(page: currentPage.value);
    } else {
      print("Pagination: loadMore skipped. Current page: ${currentPage.value}, Total pages: ${totalPages.value}, isLoading: ${isLoading.value}, isPaging: ${isPaging.value}");
    }
  }

  Future<void> refreshList() async {
    print("Pagination: refreshList called");
    isRefreshing.value = true;
    currentPage.value = 1;
    items.clear();
    await _loadPage(page: 1);
    isRefreshing.value = false;
  }

  Future<void> _loadPage({required int page}) async {
    print("Pagination: _loadPage called for page $page");

    if (page == 1) {
      isLoading.value = true;
    } else {
      isPaging.value = true;
    }

    final newItems = await fetchItems(page);

    if (page == 1) {
      items.assignAll(newItems);
      isLoading.value = false;
    } else {
      items.addAll(newItems);
      isPaging.value = false;
    }
  }
}
