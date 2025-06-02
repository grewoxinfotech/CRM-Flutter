class InvoiceModel {
  final String? id;
  final String? salesInvoiceNumber;
  final String? relatedId;
  final String? customer;
  final DateTime? issueDate;
  final DateTime? dueDate;
  final String?category;
  final String? upiLink;
  final List<InvoiceItemModel>? items;
  final double? discount;
  final double? tax;
  final double? subtotal;
  final double? total;
  final double? amount;
  final String? paymentStatus;
  final String? currency;
  final double? costOfGoods;
  final double? profit;
  final double? profitPercentage;
  final String? additionalNotes;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? key;

  InvoiceModel({
   required this.id,
   required this.salesInvoiceNumber,
   required this.relatedId,
   required this.customer,
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
   required this.key,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      salesInvoiceNumber: json['salesInvoiceNumber'],
      relatedId: json['related_id'],
      customer: json['customer'],
      issueDate: DateTime.parse(json['issueDate']),
      dueDate: DateTime.parse(json['dueDate']),
      category: json['category'],
      upiLink: json['upiLink'],
      items: (json['items'] as List).map((e) => InvoiceItemModel.fromJson(e)).toList(),
      discount: (json['discount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      paymentStatus: json['payment_status'],
      currency: json['currency'],
      costOfGoods: (json['cost_of_goods'] ?? 0).toDouble(),
      profit: (json['profit'] ?? 0).toDouble(),
      profitPercentage: (json['profit_percentage'] ?? 0).toDouble(),
      additionalNotes: json['additional_notes'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      key: json['key'],
    );
  }
}

class InvoiceItemModel {
  final double tax;
  final String name;
  final double total;
  final double amount;
  final double profit;
  final String hsnSac;
  final double discount;
  final int quantity;
  final double subtotal;
  final String taxName;
  final String productId;
  final double taxAmount;
  final double unitPrice;
  final double buyingPrice;
  final String discountType;
  final double taxPercentage;
  final double discountAmount;
  final String profitPercentage;
  final double amountAfterDiscount;

  InvoiceItemModel({
    required this.tax,
    required this.name,
    required this.total,
    required this.amount,
    required this.profit,
    required this.hsnSac,
    required this.discount,
    required this.quantity,
    required this.subtotal,
    required this.taxName,
    required this.productId,
    required this.taxAmount,
    required this.unitPrice,
    required this.buyingPrice,
    required this.discountType,
    required this.taxPercentage,
    required this.discountAmount,
    required this.profitPercentage,
    required this.amountAfterDiscount,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      tax: (json['tax'] ?? 0).toDouble(),
      name: json['name'],
      total: (json['total'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      profit: (json['profit'] ?? 0).toDouble(),
      hsnSac: json['hsn_sac'],
      discount: (json['discount'] ?? 0).toDouble(),
      quantity: json['quantity'],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      taxName: json['tax_name'],
      productId: json['product_id'],
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      buyingPrice: (json['buying_price'] ?? 0).toDouble(),
      discountType: json['discount_type'],
      taxPercentage: (json['tax_percentage'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      profitPercentage: json['profit_percentage'].toString(),
      amountAfterDiscount: (json['amount_after_discount'] ?? 0).toDouble(),
    );
  }
}
