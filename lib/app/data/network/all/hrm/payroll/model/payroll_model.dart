class PayrollModel {
  final String id;
  final String employeeId;
  final String payslipType;
  final String currency;
  final String salary;
  final num netSalary;
  final String status;
  final DateTime paymentDate;
  final String bankAccount;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String key;

  PayrollModel({
    required this.id,
    required this.employeeId,
    required this.payslipType,
    required this.currency,
    required this.salary,
    required this.netSalary,
    required this.status,
    required this.paymentDate,
    required this.bankAccount,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      id: json['id'] ?? '',
      employeeId: json['employeeId'] ?? '',
      payslipType: json['payslipType'] ?? '',
      currency: json['currency'] ?? '',
      salary: json['salary'] ?? '0',
      netSalary: json['netSalary'] ?? 0,
      status: json['status'] ?? '',
      paymentDate: DateTime.parse(json['paymentDate']),
      bankAccount: json['bankAccount'] ?? '',
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      key: json['key'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "employeeId": employeeId,
      "payslipType": payslipType,
      "currency": currency,
      "salary": salary,
      "netSalary": netSalary,
      "status": status,
      "paymentDate": paymentDate.toIso8601String(),
      "bankAccount": bankAccount,
      "client_id": clientId,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "key": key,
    };
  }
}
