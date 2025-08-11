class productsServicesModel {
  bool? success;
  Message? message;
  Null? data;

  productsServicesModel({this.success, this.message, this.data});

  productsServicesModel.fromJson(Map<String, dynamic> json) {
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
  List<Data>? data;
  Pagination? pagination;

  Message({this.data, this.pagination});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? id;
  String? relatedId;
  String? name;
  String? currency;
  int? buyingPrice;
  int? sellingPrice;
  String? profitMargin;
  String? profitPercentage;
  String? category;
  String? sku;
  String? hsnSac;
  String? description;
  String? taxName;
  int? taxPercentage;
  String? image;
  int? stockQuantity;
  int? minStockLevel;
  int? maxStockLevel;
  int? reorderQuantity;
  String? stockStatus;
  String? lastStockUpdate;
  Null? totalInvestment;
  Null? potentialRevenue;
  Null? potentialProfit;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  Data(
      {this.id,
        this.relatedId,
        this.name,
        this.currency,
        this.buyingPrice,
        this.sellingPrice,
        this.profitMargin,
        this.profitPercentage,
        this.category,
        this.sku,
        this.hsnSac,
        this.description,
        this.taxName,
        this.taxPercentage,
        this.image,
        this.stockQuantity,
        this.minStockLevel,
        this.maxStockLevel,
        this.reorderQuantity,
        this.stockStatus,
        this.lastStockUpdate,
        this.totalInvestment,
        this.potentialRevenue,
        this.potentialProfit,
        this.clientId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.key});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relatedId = json['related_id'];
    name = json['name'];
    currency = json['currency'];
    buyingPrice = json['buying_price'];
    sellingPrice = json['selling_price'];
    profitMargin = json['profit_margin'];
    profitPercentage = json['profit_percentage'];
    category = json['category'];
    sku = json['sku'];
    hsnSac = json['hsn_sac'];
    description = json['description'];
    taxName = json['tax_name'];
    taxPercentage = json['tax_percentage'];
    image = json['image'];
    stockQuantity = json['stock_quantity'];
    minStockLevel = json['min_stock_level'];
    maxStockLevel = json['max_stock_level'];
    reorderQuantity = json['reorder_quantity'];
    stockStatus = json['stock_status'];
    lastStockUpdate = json['last_stock_update'];
    totalInvestment = json['total_investment'];
    potentialRevenue = json['potential_revenue'];
    potentialProfit = json['potential_profit'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['related_id'] = this.relatedId;
    data['name'] = this.name;
    data['currency'] = this.currency;
    data['buying_price'] = this.buyingPrice;
    data['selling_price'] = this.sellingPrice;
    data['profit_margin'] = this.profitMargin;
    data['profit_percentage'] = this.profitPercentage;
    data['category'] = this.category;
    data['sku'] = this.sku;
    data['hsn_sac'] = this.hsnSac;
    data['description'] = this.description;
    data['tax_name'] = this.taxName;
    data['tax_percentage'] = this.taxPercentage;
    data['image'] = this.image;
    data['stock_quantity'] = this.stockQuantity;
    data['min_stock_level'] = this.minStockLevel;
    data['max_stock_level'] = this.maxStockLevel;
    data['reorder_quantity'] = this.reorderQuantity;
    data['stock_status'] = this.stockStatus;
    data['last_stock_update'] = this.lastStockUpdate;
    data['total_investment'] = this.totalInvestment;
    data['potential_revenue'] = this.potentialRevenue;
    data['potential_profit'] = this.potentialProfit;
    data['client_id'] = this.clientId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['key'] = this.key;
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['current'] = this.current;
    data['pageSize'] = this.pageSize;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
