// pagination_models.dart
class PaginationParams {
  final int page;
  final int pageSize;
  final Map<String, dynamic>? filters;

  PaginationParams({
    this.page = 1,
    this.pageSize = 10,
    this.filters,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'pageSize': pageSize,
      ...?filters,
    };
  }
}

class PaginationResponse<T> {
  final List<T> items;
  final PaginationMeta meta;

  PaginationResponse({
    required this.items,
    required this.meta,
  });
}

class PaginationMeta {
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PaginationMeta({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  bool get hasMore => currentPage < totalPages;
}