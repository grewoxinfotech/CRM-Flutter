class AllowanceModel {
  final String id;
  final String employeeId;
  final String allowanceOption;
  final String title;
  final String type;
  final String currency;
  final double amount;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllowanceModel({
    required this.id,
    required this.employeeId,
    required this.allowanceOption,
    required this.title,
    required this.type,
    required this.currency,
    required this.amount,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllowanceModel.fromJson(Map<String, dynamic> json) {
    return AllowanceModel(
      id: json['id'],
      employeeId: json['employeeId'],
      allowanceOption: json['allowanceOption'],
      title: json['title'],
      type: json['type'],
      currency: json['currency'],
      amount: double.parse(json['amount'].toString()),
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'allowanceOption': allowanceOption,
      'title': title,
      'type': type,
      'currency': currency,
      'amount': amount,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
