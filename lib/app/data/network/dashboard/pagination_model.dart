class PaginatedResponse<T> {
  final List<T> data;
  final PaginationModel pagination;

  PaginatedResponse({required this.data, required this.pagination});
}

class PaginationModel {
  final int total;
  final int current;
  final int pageSize;
  final int totalPages;

  PaginationModel({
    required this.total,
    required this.current,
    required this.pageSize,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'] ?? 0,
      current: json['current'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}
