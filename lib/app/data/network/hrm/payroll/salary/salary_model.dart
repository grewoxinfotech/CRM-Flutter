class SalaryModel {
  final String id;
  final String employeeId;
  final String payslipType;
  final String currency;
  final double salary;
  final double netSalary;
  final String status;
  final DateTime paymentDate;
  final String bankAccount;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  SalaryModel({
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
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      id: json['id'],
      employeeId: json['employeeId'],
      payslipType: json['payslipType'],
      currency: json['currency'],
      salary: double.parse(json['salary'].toString()),
      netSalary: double.parse(json['netSalary'].toString()),
      status: json['status'],
      paymentDate: DateTime.parse(json['paymentDate']),
      bankAccount: json['bankAccount'],
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
      'payslipType': payslipType,
      'currency': currency,
      'salary': salary,
      'netSalary': netSalary,
      'status': status,
      'paymentDate': paymentDate.toIso8601String(),
      'bankAccount': bankAccount,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
