class PaymentModel {
  final String id;
  final String relatedId;
  final String? projectName;
  final String? invoice;
  final String? expense;
  final String? estimate;
  final DateTime? paidOn;
  final String amount;
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
      paidOn: json['paidOn'] != null ? DateTime.parse(json['paidOn']) : null,
      amount: json['amount'],
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'project_name': projectName,
      'invoice': invoice,
      'expense': expense,
      'estimate': estimate,
      'paidOn': paidOn?.toIso8601String(),
      'amount': amount,
      'currency': currency,
      'status': status,
      'transactionId': transactionId,
      'paymentMethod': paymentMethod,
      'receipt': receipt,
      'remark': remark,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
