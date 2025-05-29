// models/invoice_model.dart

class InvoiceModel {
  final String id;
  final String salesInvoiceNumber;
  final String relatedId;
  final String customerId;
  final DateTime issueDate;
  final DateTime dueDate;
  final String? category;
  final String upiLink;
  final List<InvoiceItemModel> items;
  final double discount;
  final double tax;
  final double subtotal;
  final double total;
  final double amount;
  final String paymentStatus;
  final String currency;
  final double costOfGoods;
  final double profit;
  final double profitPercentage;
  final String? additionalNotes;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  InvoiceModel({
    required this.id,
    required this.salesInvoiceNumber,
    required this.relatedId,
    required this.customerId,
    required this.issueDate,
    required this.dueDate,
    required this.category,
    required this.upiLink,
    required this.items,
    required this.discount,
    required this.tax,
    required this.subtotal,
    required this.total,
    required this.amount,
    required this.paymentStatus,
    required this.currency,
    required this.costOfGoods,
    required this.profit,
    required this.profitPercentage,
    required this.additionalNotes,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      salesInvoiceNumber: json['salesInvoiceNumber'],
      relatedId: json['related_id'],
      customerId: json['customer'],
      issueDate: DateTime.parse(json['issueDate']),
      dueDate: DateTime.parse(json['dueDate']),
      category: json['category'],
      upiLink: json['upiLink'],
      items: (json['items'] as List)
          .map((item) => InvoiceItemModel.fromJson(item))
          .toList(),
      discount: (json['discount'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      paymentStatus: json['payment_status'],
      currency: json['currency'],
      costOfGoods: (json['cost_of_goods'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      profitPercentage: (json['profit_percentage'] as num).toDouble(),
      additionalNotes: json['additional_notes'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class InvoiceItemModel {
  final String name;
  final double quantity;
  final double unitPrice;
  final double subtotal;
  final double amount;
  final double total;
  final double buyingPrice;
  final double tax;
  final double taxAmount;
  final String taxName;
  final String hsnSac;
  final double profit;
  final String productId;
  final double discount;
  final String discountType;
  final double discountAmount;
  final double amountAfterDiscount;
  final double taxPercentage;
  final String profitPercentage;

  InvoiceItemModel({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.amount,
    required this.total,
    required this.buyingPrice,
    required this.tax,
    required this.taxAmount,
    required this.taxName,
    required this.hsnSac,
    required this.profit,
    required this.productId,
    required this.discount,
    required this.discountType,
    required this.discountAmount,
    required this.amountAfterDiscount,
    required this.taxPercentage,
    required this.profitPercentage,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      name: json['name'],
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      buyingPrice: (json['buying_price'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      taxAmount: (json['tax_amount'] as num).toDouble(),
      taxName: json['tax_name'],
      hsnSac: json['hsn_sac'],
      profit: (json['profit'] as num).toDouble(),
      productId: json['product_id'],
      discount: (json['discount'] as num).toDouble(),
      discountType: json['discount_type'],
      discountAmount: (json['discount_amount'] as num).toDouble(),
      amountAfterDiscount: (json['amount_after_discount'] as num).toDouble(),
      taxPercentage: (json['tax_percentage'] as num).toDouble(),
      profitPercentage: json['profit_percentage'],
    );
  }
}
