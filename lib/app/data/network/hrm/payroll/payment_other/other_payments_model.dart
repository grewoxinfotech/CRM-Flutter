class OtherPaymentModel {
  final String id;
  final String employeeId;
  final String title;
  final String type;
  final String currency;
  final double amount;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  OtherPaymentModel({
    required this.id,
    required this.employeeId,
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

  factory OtherPaymentModel.fromJson(Map<String, dynamic> json) {
    return OtherPaymentModel(
      id: json['id'],
      employeeId: json['employeeId'],
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
