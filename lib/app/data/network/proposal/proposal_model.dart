class ProposalModel {
  final String id;
  final String leadTitle;
  final DateTime validTill;
  final String currency;
  final String description;
  final List<Item> items;
  final double discount;
  final double tax;
  final double total;
  final double subtotal;
  final String clientId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProposalModel({
    required this.id,
    required this.leadTitle,
    required this.validTill,
    required this.currency,
    required this.description,
    required this.items,
    required this.discount,
    required this.tax,
    required this.total,
    required this.subtotal,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProposalModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemList = list.map((i) => Item.fromJson(i)).toList();

    return ProposalModel(
      id: json['id'],
      leadTitle: json['lead_title'],
      validTill: DateTime.parse(json['valid_till']),
      currency: json['currency'],
      description: json['description'],
      items: itemList,
      discount: json['discount'].toDouble(),
      tax: json['tax'].toDouble(),
      total: json['total'].toDouble(),
      subtotal: json['subtotal'].toDouble(),
      clientId: json['client_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> itemsJson = items.map((i) => i.toJson()).toList();

    return {
      'id': id,
      'lead_title': leadTitle,
      'valid_till': validTill.toIso8601String(),
      'currency': currency,
      'description': description,
      'items': itemsJson,
      'discount': discount,
      'tax': tax,
      'total': total,
      'subtotal': subtotal,
      'client_id': clientId,
      'created_by': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Item {
  final String name;
  final String description;
  final double price;
  final int quantity;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }
}
