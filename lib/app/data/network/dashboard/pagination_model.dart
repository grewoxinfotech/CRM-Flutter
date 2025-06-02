class PaginatedResponse<T> {
  final List<T> data;
  final PaginationModel pagination;

  PaginatedResponse({required this.data, required this.pagination});
}

class PaginationModel {
  final int totel;
  final int current;
  final int pagaSize;
  final int totelPagan;

  PaginationModel({
    required this.totel,
    required this.current,
    required this.pagaSize,
    required this.totelPagan,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      totel: json['totel'] ?? 0,
      current: json["currant"] ?? 1,
      pagaSize: json['pagaSize'] ?? 10,
      totelPagan: json['totelPagan'] ?? 1,
    );
  }
}
