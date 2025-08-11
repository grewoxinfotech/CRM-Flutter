class CurrencyModel {
  final String id;
  final String currencyName;
  final String currencyIcon;
  final String currencyCode;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrencyModel({
    required this.id,
    required this.currencyName,
    required this.currencyIcon,
    required this.currencyCode,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    // Helper function to safely extract string values

    return CurrencyModel(
      id: json['id'],
      currencyName: json['currencyName'],
      currencyIcon: json['currencyIcon'],
      currencyCode: json['currencyCode'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(
        json['createdAt'] != ''
            ? json['createdAt']
            : DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] != ''
            ? json['updatedAt']
            : DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currencyName': currencyName,
      'currencyIcon': currencyIcon,
      'currencyCode': currencyCode,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
