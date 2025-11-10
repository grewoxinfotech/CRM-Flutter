class PlanModel {
  bool? success;
  String? message;
  List<PlanData>? data;

  PlanModel({this.success, this.message, this.data});

  PlanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<PlanData>.from(
        json['data'].map((x) => PlanData.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PlanData {
  String? id;
  String? name;
  String? currency;
  String? price;
  String? duration;
  String? trialPeriod;
  String? maxUsers;
  String? maxClients;
  String? maxCustomers;
  String? maxVendors;
  bool? isDefault;
  String? storageLimit;
  String? features;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  PlanData({
    this.id,
    this.name,
    this.currency,
    this.price,
    this.duration,
    this.trialPeriod,
    this.maxUsers,
    this.maxClients,
    this.maxCustomers,
    this.maxVendors,
    this.isDefault,
    this.storageLimit,
    this.features,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  PlanData.fromJson(Map<String, dynamic> json) {
    id = _parseString(json['id']);
    name = _parseString(json['name']);
    // Handle currency - could be string ID or object
    currency = _parseCurrency(json['currency']);
    price = _parseString(json['price']);
    duration = _parseString(json['duration']);
    trialPeriod = _parseString(json['trial_period']);
    maxUsers = _parseString(json['max_users']);
    maxClients = _parseString(json['max_clients']);
    maxCustomers = _parseString(json['max_customers']);
    maxVendors = _parseString(json['max_vendors']);
    isDefault = json['is_default'];
    storageLimit = _parseString(json['storage_limit']);
    features = _parseString(json['features']);
    status = _parseString(json['status']);
    createdBy = _parseString(json['created_by']);
    updatedBy = _parseString(json['updated_by']);
    createdAt = _parseString(json['createdAt']);
    updatedAt = _parseString(json['updatedAt']);
  }

  String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  String? _parseCurrency(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map<String, dynamic>) {
      // If currency is an object, extract ID or code
      return value['id']?.toString() ?? value['code']?.toString();
    }
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['currency'] = currency;
    map['price'] = price;
    map['duration'] = duration;
    map['trial_period'] = trialPeriod;
    map['max_users'] = maxUsers;
    map['max_clients'] = maxClients;
    map['max_customers'] = maxCustomers;
    map['max_vendors'] = maxVendors;
    map['is_default'] = isDefault;
    map['storage_limit'] = storageLimit;
    map['features'] = features;
    map['status'] = status;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
