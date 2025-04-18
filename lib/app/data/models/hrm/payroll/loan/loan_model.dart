class LoanModel {
  final String id;
  final String employeeId;
  final String loanOption;
  final String title;
  final String type;
  final String currency;
  final double amount;
  final String reason;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  LoanModel({
    required this.id,
    required this.employeeId,
    required this.loanOption,
    required this.title,
    required this.type,
    required this.currency,
    required this.amount,
    required this.reason,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      employeeId: json['employeeId'],
      loanOption: json['loanOption'],
      title: json['title'],
      type: json['type'],
      currency: json['currency'],
      amount: double.parse(json['amount'].toString()),
      reason: json['reason'],
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
      'loanOption': loanOption,
      'title': title,
      'type': type,
      'currency': currency,
      'amount': amount,
      'reason': reason,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
