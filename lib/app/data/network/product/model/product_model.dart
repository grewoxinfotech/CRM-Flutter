class Product {
  final String id;
  final String relatedId;
  final String name;
  final String currency;
  final double buyingPrice;
  final double sellingPrice;
  final String profitMargin;
  final String profitPercentage;
  final String category;
  final String sku;
  final String hsnSac;
  final String description;
  final String? image;
  final int stockQuantity;
  final int minStockLevel;
  final int maxStockLevel;
  final int reorderQuantity;
  final String stockStatus;
  final DateTime lastStockUpdate;
  final double? totalInvestment;
  final double? potentialRevenue;
  final double? potentialProfit;
  final String clientId;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.relatedId,
    required this.name,
    required this.currency,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.profitMargin,
    required this.profitPercentage,
    required this.category,
    required this.sku,
    required this.hsnSac,
    required this.description,
    this.image,
    required this.stockQuantity,
    required this.minStockLevel,
    required this.maxStockLevel,
    required this.reorderQuantity,
    required this.stockStatus,
    required this.lastStockUpdate,
    this.totalInvestment,
    this.potentialRevenue,
    this.potentialProfit,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      relatedId: json['related_id'] ?? '',
      name: json['name'] ?? '',
      currency: json['currency'] ?? '',
      buyingPrice: (json['buying_price'] ?? 0).toDouble(),
      sellingPrice: (json['selling_price'] ?? 0).toDouble(),
      profitMargin: json['profit_margin']?.toString() ?? '0',
      profitPercentage: json['profit_percentage']?.toString() ?? '0',
      category: json['category'] ?? '',
      sku: json['sku'] ?? '',
      hsnSac: json['hsn_sac'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      stockQuantity: json['stock_quantity'] ?? 0,
      minStockLevel: json['min_stock_level'] ?? 0,
      maxStockLevel: json['max_stock_level'] ?? 0,
      reorderQuantity: json['reorder_quantity'] ?? 0,
      stockStatus: json['stock_status'] ?? '',
      lastStockUpdate: json['last_stock_update'] != null
          ? DateTime.parse(json['last_stock_update'])
          : DateTime.now(),
      totalInvestment: json['total_investment']?.toDouble(),
      potentialRevenue: json['potential_revenue']?.toDouble(),
      potentialProfit: json['potential_profit']?.toDouble(),
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'name': name,
      'currency': currency,
      'buying_price': buyingPrice,
      'selling_price': sellingPrice,
      'profit_margin': profitMargin,
      'profit_percentage': profitPercentage,
      'category': category,
      'sku': sku,
      'hsn_sac': hsnSac,
      'description': description,
      'image': image,
      'stock_quantity': stockQuantity,
      'min_stock_level': minStockLevel,
      'max_stock_level': maxStockLevel,
      'reorder_quantity': reorderQuantity,
      'stock_status': stockStatus,
      'last_stock_update': lastStockUpdate.toIso8601String(),
      'total_investment': totalInvestment,
      'potential_revenue': potentialRevenue,
      'potential_profit': potentialProfit,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 