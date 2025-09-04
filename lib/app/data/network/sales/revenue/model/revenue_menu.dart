// class RevenueModel {
//   bool? success;
//   RevenueMessage? message;
//   dynamic data;
//
//   RevenueModel({this.success, this.message, this.data});
//
//   RevenueModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message =
//         json['message'] != null
//             ? RevenueMessage.fromJson(json['message'])
//             : null;
//     data = json['data'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = {};
//     map['success'] = success;
//     if (message != null) {
//       map['message'] = message!.toJson();
//     }
//     map['data'] = data;
//     return map;
//   }
// }
//
// class RevenueMessage {
//   List<RevenueData>? data;
//   Pagination? pagination;
//
//   RevenueMessage({this.data, this.pagination});
//
//   RevenueMessage.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = List<RevenueData>.from(
//         json['data'].map((x) => RevenueData.fromJson(x)),
//       );
//     }
//     pagination =
//         json['pagination'] != null
//             ? Pagination.fromJson(json['pagination'])
//             : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = {};
//     if (data != null) {
//       map['data'] = data!.map((v) => v.toJson()).toList();
//     }
//     if (pagination != null) {
//       map['pagination'] = pagination!.toJson();
//     }
//     return map;
//   }
// }

class RevenueModel {
  bool? success;
  Message? message;
  Null? data;

  RevenueModel({this.success, this.message, this.data});

  RevenueModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Message {
  List<RevenueData>? data;
  Pagination? pagination;

  Message({this.data, this.pagination});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RevenueData>[];
      json['data'].forEach((v) {
        data!.add(new RevenueData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class RevenueData {
  double? profit;
  double? profitMarginPercentage;
  List<Product>? products;
  String? id;
  String? relatedId;
  String? date;
  String? currency;
  double? amount;
  double? costOfGoods;
  String? account;
  String? customer;
  String? description;
  String? salesInvoiceNumber;
  String? category;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  RevenueData({
    this.profit,
    this.profitMarginPercentage,
    this.products,
    this.id,
    this.relatedId,
    this.date,
    this.currency,
    this.amount,
    this.costOfGoods,
    this.account,
    this.customer,
    this.description,
    this.salesInvoiceNumber,
    this.category,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  RevenueData.fromJson(Map<String, dynamic> json) {
    profit = (json['profit'] as num?)?.toDouble();
    profitMarginPercentage =
        (json['profit_margin_percentage'] as num?)?.toDouble();
    if (json['products'] != null) {
      products = List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)),
      );
    }
    id = json['id'];
    relatedId = json['related_id'];
    date = json['date'];
    currency = json['currency'];
    amount = (json['amount'] as num?)?.toDouble();
    costOfGoods = (json['cost_of_goods'] as num?)?.toDouble();
    account = json['account'];
    customer = json['customer'];
    description = json['description'];
    salesInvoiceNumber = json['salesInvoiceNumber'];
    category = json['category'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['profit'] = profit;
    map['profit_margin_percentage'] = profitMarginPercentage;
    if (products != null) {
      map['products'] = products!.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    map['related_id'] = relatedId;
    map['date'] = date;
    map['currency'] = currency;
    map['amount'] = amount;
    map['cost_of_goods'] = costOfGoods;
    map['account'] = account;
    map['customer'] = customer;
    map['description'] = description;
    map['salesInvoiceNumber'] = salesInvoiceNumber;
    map['category'] = category;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    return map;
  }
}

class Product {
  String? productId;
  int? quantity;
  double? unitPrice;
  double? tax;
  String? taxName;
  double? taxAmount;
  double? discount;
  String? discountType;
  String? hsnSac;
  double? amount;
  String? name;
  double? buyingPrice;
  double? subtotal;
  double? taxPercentage;
  double? discountAmount;
  double? amountAfterDiscount;
  double? total;
  double? profit;
  String? profitPercentage;
  double? revenue;

  Product({
    this.productId,
    this.quantity,
    this.unitPrice,
    this.tax,
    this.taxName,
    this.taxAmount,
    this.discount,
    this.discountType,
    this.hsnSac,
    this.amount,
    this.name,
    this.buyingPrice,
    this.subtotal,
    this.taxPercentage,
    this.discountAmount,
    this.amountAfterDiscount,
    this.total,
    this.profit,
    this.profitPercentage,
    this.revenue,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    unitPrice = (json['unit_price'] as num?)?.toDouble();
    tax = (json['tax'] as num?)?.toDouble();
    taxName = json['tax_name'];
    taxAmount = (json['tax_amount'] as num?)?.toDouble();
    discount = (json['discount'] as num?)?.toDouble();
    discountType = json['discount_type'];
    hsnSac = json['hsn_sac'];
    amount = (json['amount'] as num?)?.toDouble();
    name = json['name'];
    buyingPrice = (json['buying_price'] as num?)?.toDouble();
    subtotal = (json['subtotal'] as num?)?.toDouble();
    taxPercentage = (json['tax_percentage'] as num?)?.toDouble();
    discountAmount = (json['discount_amount'] as num?)?.toDouble();
    amountAfterDiscount = (json['amount_after_discount'] as num?)?.toDouble();
    total = (json['total'] as num?)?.toDouble();
    profit = (json['profit'] as num?)?.toDouble();
    profitPercentage = json['profit_percentage'];
    revenue = (json['revenue'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['product_id'] = productId;
    map['quantity'] = quantity;
    map['unit_price'] = unitPrice;
    map['tax'] = tax;
    map['tax_name'] = taxName;
    map['tax_amount'] = taxAmount;
    map['discount'] = discount;
    map['discount_type'] = discountType;
    map['hsn_sac'] = hsnSac;
    map['amount'] = amount;
    map['name'] = name;
    map['buying_price'] = buyingPrice;
    map['subtotal'] = subtotal;
    map['tax_percentage'] = taxPercentage;
    map['discount_amount'] = discountAmount;
    map['amount_after_discount'] = amountAfterDiscount;
    map['total'] = total;
    map['profit'] = profit;
    map['profit_percentage'] = profitPercentage;
    map['revenue'] = revenue;
    return map;
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['current'] = current;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
