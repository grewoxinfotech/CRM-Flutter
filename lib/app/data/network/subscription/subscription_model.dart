class SubscriptionModel {
  bool? success;
  String? message;
  List<SubscriptionData>? data;

  SubscriptionModel({this.success, this.message, this.data});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<SubscriptionData>.from(
        json['data'].map((x) => SubscriptionData.fromJson(x)),
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

class SubscriptionData {
  String? id;
  String? clientId;
  String? planId;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? status;
  int? currentStorageUsed;
  int? currentUsersCount;
  int? currentClientsCount;
  int? currentVendorsCount;
  int? currentCustomersCount;
  String? paymentStatus;
  String? lastPaymentDate;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  Plan? plan;
  String? clientUsername;
  Storage? storage;

  SubscriptionData({
    this.id,
    this.clientId,
    this.planId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.status,
    this.currentStorageUsed,
    this.currentUsersCount,
    this.currentClientsCount,
    this.currentVendorsCount,
    this.currentCustomersCount,
    this.paymentStatus,
    this.lastPaymentDate,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.plan,
    this.clientUsername,
    this.storage,
  });

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    currentStorageUsed = _parseInt(json['current_storage_used']);
    currentUsersCount = _parseInt(json['current_users_count']);
    currentClientsCount = _parseInt(json['current_clients_count']);
    currentVendorsCount = _parseInt(json['current_vendors_count']);
    currentCustomersCount = _parseInt(json['current_customers_count']);
    paymentStatus = json['payment_status'];
    lastPaymentDate = json['last_payment_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    plan = json['Plan'] != null ? Plan.fromJson(json['Plan']) : null;
    clientUsername = json['clientUsername'];
    storage = json['storage'] != null ? Storage.fromJson(json['storage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['client_id'] = clientId;
    map['plan_id'] = planId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['status'] = status;
    map['current_storage_used'] = currentStorageUsed;
    map['current_users_count'] = currentUsersCount;
    map['current_clients_count'] = currentClientsCount;
    map['current_vendors_count'] = currentVendorsCount;
    map['current_customers_count'] = currentCustomersCount;
    map['payment_status'] = paymentStatus;
    map['last_payment_date'] = lastPaymentDate;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (plan != null) {
      map['Plan'] = plan!.toJson();
    }
    map['clientUsername'] = clientUsername;
    if (storage != null) {
      map['storage'] = storage!.toJson();
    }
    return map;
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

}

class Plan {
  String? storageLimit;

  Plan({this.storageLimit});

  Plan.fromJson(Map<String, dynamic> json) {
    storageLimit = json['storage_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['storage_limit'] = storageLimit;
    return map;
  }
}

class Storage {
  double? used;
  double? total;
  double? percentage;

  Storage({this.used, this.total, this.percentage});

  Storage.fromJson(Map<String, dynamic> json) {
    used = (json['used'] as num?)?.toDouble();
    total = (json['total'] as num?)?.toDouble();
    percentage = (json['percentage'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['used'] = used;
    map['total'] = total;
    map['percentage'] = percentage;
    return map;
  }


}
