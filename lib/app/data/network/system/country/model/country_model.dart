class CountryModel {
  final String id;
  final String countryName;
  final String countryCode;
  final String phoneCode;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  CountryModel({
    required this.id,
    required this.countryName,
    required this.countryCode,
    required this.phoneCode,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      phoneCode: json['phoneCode'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'countryName': countryName,
      'countryCode': countryCode,
      'phoneCode': phoneCode,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
