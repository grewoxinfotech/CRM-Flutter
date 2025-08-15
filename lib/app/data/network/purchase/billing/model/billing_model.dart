class BillingModel {
  bool? success;
  BillingMessage? message;
  dynamic data; // Keep dynamic for flexibility

  BillingModel({this.success, this.message, this.data});

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      success: json['success'],
      message:
          json['message'] != null
              ? BillingMessage.fromJson(json['message'])
              : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (message != null) 'message': message!.toJson(),
      'data': data,
    };
  }
}

class BillingMessage {
  List<BillingData> data;
  Pagination? pagination;

  BillingMessage({List<BillingData>? data, this.pagination})
    : data = data ?? [];

  factory BillingMessage.fromJson(Map<String, dynamic> json) {
    return BillingMessage(
      data:
          json['data'] != null
              ? (json['data'] as List)
                  .map((v) => BillingData.fromJson(v))
                  .toList()
              : [],
      pagination:
          json['pagination'] != null
              ? Pagination.fromJson(json['pagination'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((v) => v.toJson()).toList(),
      if (pagination != null) 'pagination': pagination!.toJson(),
    };
  }
}

class BillingData {
  String? id;
  String? relatedId;
  String? billNumber;
  String? vendor;
  String? upiLink;
  String? billDate;
  String? discription;
  double? subTotal;
  String? currency;
  List<BillingItem>? items;
  String? overallDiscountType;
  double? overallDiscount;
  double? overallDiscountAmount;
  dynamic overallTax;
  double? overallTaxAmount;
  String? status;
  dynamic updatedTotal;
  String? billStatus;
  double? discount;
  double? tax;
  double? total;
  double? amount;
  String? note;
  String? currencyCode;
  String? currencyIcon;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  BillingData({
    this.id,
    this.relatedId,
    this.billNumber,
    this.vendor,
    this.currencyCode,
    this.currencyIcon,
    this.upiLink,
    this.billDate,
    this.discription,
    this.subTotal,
    this.currency,
    this.items,
    this.overallDiscountType,
    this.overallDiscount,
    this.overallDiscountAmount,
    this.overallTax,
    this.overallTaxAmount,
    this.status,
    this.updatedTotal,
    this.billStatus,
    this.discount,
    this.tax,
    this.total,
    this.amount,
    this.note,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  factory BillingData.fromJson(Map<String, dynamic> json) {
    return BillingData(
      id: json['id'],
      relatedId: json['related_id'],
      billNumber: json['billNumber'],
      vendor: json['vendor'],
      upiLink: json['upiLink'],
      billDate: json['billDate'],
      discription: json['discription'],
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      currency: json['currency'],
      items:
          json['items'] != null
              ? (json['items'] as List)
                  .map((v) => BillingItem.fromJson(v))
                  .toList()
              : [],
      overallDiscountType: json['overallDiscountType'],
      overallDiscount: (json['overallDiscount'] as num?)?.toDouble(),
      overallDiscountAmount:
          (json['overallDiscountAmount'] as num?)?.toDouble(),
      overallTax: json['overallTax'],
      overallTaxAmount: (json['overallTaxAmount'] as num?)?.toDouble(),
      status: json['status'],
      updatedTotal: json['updated_total'],
      billStatus: json['bill_status'],
      discount: (json['discount'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      note: json['note'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (relatedId != null) 'related_id': relatedId,
      if (billNumber != null) 'billNumber': billNumber,
      if (vendor != null) 'vendor': vendor,
      if (upiLink != null) 'upiLink': upiLink,
      if (billDate != null) 'billDate': billDate,
      if (discription != null) 'discription': discription,
      if (subTotal != null) 'subTotal': subTotal,
      if (currency != null) 'currency': currency,
      if (items != null) 'items': items!.map((v) => v.toJson()).toList(),
      if (overallDiscountType != null)
        'overallDiscountType': overallDiscountType,
      if (overallDiscount != null) 'overallDiscount': overallDiscount,
      if (overallDiscountAmount != null)
        'overallDiscountAmount': overallDiscountAmount,
      'overallTax': overallTax,
      if (overallTaxAmount != null) 'overallTaxAmount': overallTaxAmount,
      if (status != null) 'status': status,
      'updated_total': updatedTotal,
      if (billStatus != null) 'bill_status': billStatus,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (total != null) 'total': total,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (clientId != null) 'client_id': clientId,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'createdAt': createdAt,
      if (currencyCode != null) 'currencyCode': currencyCode,
      if (currencyIcon != null) 'currencyIcon': currencyIcon,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (key != null) 'key': key,
    };
  }
}

class BillingItem {
  double? amount;
  String? hsnSac;
  String? currency;
  double? discount;
  String? itemName;
  double? quantity;
  String? taxName;
  double? taxAmount;
  double? unitPrice;
  String? productId;
  String? currencyIcon;
  String? discountType;
  double? discountAmount;
  double? taxPercentage;

  BillingItem({
    this.amount,
    this.hsnSac,
    this.currency,
    this.discount,
    this.itemName,
    this.quantity,
    this.taxName,
    this.taxAmount,
    this.unitPrice,
    this.productId,
    this.currencyIcon,
    this.discountType,
    this.discountAmount,
    this.taxPercentage,
  });

  factory BillingItem.fromJson(Map<String, dynamic> json) {
    return BillingItem(
      amount: (json['amount'] as num?)?.toDouble(),
      hsnSac: json['hsnSac'],
      currency: json['currency'],
      discount: (json['discount'] as num?)?.toDouble(),
      itemName: json['itemName'],
      quantity: (json['quantity'] as num?)?.toDouble(),
      taxName: json['tax_name'],
      taxAmount: (json['taxAmount'] as num?)?.toDouble(),
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      productId: json['product_id'],
      currencyIcon: json['currencyIcon'],
      discountType: json['discount_type'],
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      taxPercentage: (json['tax_percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (amount != null) 'amount': amount,
      if (hsnSac != null) 'hsnSac': hsnSac,
      if (currency != null) 'currency': currency,
      if (discount != null) 'discount': discount,
      if (itemName != null) 'itemName': itemName,
      if (quantity != null) 'quantity': quantity,
      if (taxName != null) 'tax_name': taxName,
      if (taxAmount != null) 'taxAmount': taxAmount,
      if (unitPrice != null) 'unitPrice': unitPrice,
      if (productId != null) 'product_id': productId,
      if (currencyIcon != null) 'currencyIcon': currencyIcon,
      if (discountType != null) 'discount_type': discountType,
      if (discountAmount != null) 'discountAmount': discountAmount,
      if (taxPercentage != null) 'tax_percentage': taxPercentage,
    };
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      current: json['current'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (total != null) 'total': total,
      if (current != null) 'current': current,
      if (pageSize != null) 'pageSize': pageSize,
      if (totalPages != null) 'totalPages': totalPages,
    };
  }
}
