class SalesInvoiceItem {
  final double? tax; // changed from String? to double?
  final String? taxName; // optional GST/VAT label
  final String? name;
  final double total;
  final double amount;
  final double? profit;
  final String hsnSac;
  final double discount;
  final int quantity;
  final double subtotal;
  final String productId;
  final double taxAmount;
  final double unitPrice;
  final double? buyingPrice;
  final String discountType;
  final double discountAmount;
  final double? profitPercentage; // changed from String to double
  final double? amountAfterDiscount;

  SalesInvoiceItem({
    this.tax,
    this.taxName,
    this.name,
    required this.total,
    required this.amount,
    this.profit,
    required this.hsnSac,
    required this.discount,
    required this.quantity,
    required this.subtotal,
    required this.productId,
    required this.taxAmount,
    required this.unitPrice,
    this.buyingPrice,
    required this.discountType,
    required this.discountAmount,
    this.profitPercentage,
    this.amountAfterDiscount,
  });

  factory SalesInvoiceItem.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceItem(
      tax: (json['tax'] ?? 0).toDouble(),
      taxName: json['tax_name'],
      name: json['name']?.toString() ?? '',
      total: (json['total'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      profit: (json['profit'] ?? 0).toDouble(),
      hsnSac: json['hsn_sac']?.toString() ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      quantity:
          (json['quantity'] is String)
              ? int.tryParse(json['quantity']) ?? 0
              : (json['quantity'] ?? 0),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      productId: json['product_id']?.toString() ?? '',
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      buyingPrice: (json['buying_price'] ?? 0).toDouble(),
      discountType: json['discount_type']?.toString() ?? 'fixed',
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      profitPercentage:
          (json['profit_percentage'] is String)
              ? double.tryParse(json['profit_percentage']) ?? 0
              : (json['profit_percentage'] ?? 0).toDouble(),
      amountAfterDiscount: (json['amount_after_discount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tax': tax,
      'tax_name': taxName,
      'name': name,
      'total': total,
      'amount': amount,
      'profit': profit,
      'hsn_sac': hsnSac,
      'discount': discount,
      'quantity': quantity,
      'subtotal': subtotal,
      'product_id': productId,
      'tax_amount': taxAmount,
      'unit_price': unitPrice,
      'buying_price': buyingPrice,
      'discount_type': discountType,
      'discount_amount': discountAmount,
      'profit_percentage': profitPercentage,
      'amount_after_discount': amountAfterDiscount,
    };
  }
}
