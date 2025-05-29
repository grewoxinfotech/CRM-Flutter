// models/payment_model.dart

class PaymentModel {
  final String id;
  final String relatedId;
  final String? projectName;
  final String invoice;
  final String? expense;
  final String? estimate;
  final DateTime paidOn;
  final double amount;
  final String currency;
  final String status;
  final String? transactionId;
  final String paymentMethod;
  final String? receipt;
  final String? remark;
  final String clientId;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentModel({
    required this.id,
    required this.relatedId,
    required this.projectName,
    required this.invoice,
    required this.expense,
    required this.estimate,
    required this.paidOn,
    required this.amount,
    required this.currency,
    required this.status,
    required this.transactionId,
    required this.paymentMethod,
    required this.receipt,
    required this.remark,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      relatedId: json['related_id'],
      projectName: json['project_name'],
      invoice: json['invoice'],
      expense: json['expense'],
      estimate: json['estimate'],
      paidOn: DateTime.parse(json['paidOn']),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      currency: json['currency'],
      status: json['status'],
      transactionId: json['transactionId'],
      paymentMethod: json['paymentMethod'],
      receipt: json['receipt'],
      remark: json['remark'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
