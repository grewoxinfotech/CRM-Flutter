class CreditNoteModel {
  bool? success;
  CreditNoteMessage? message;
  dynamic data;

  CreditNoteModel({this.success, this.message, this.data});

  CreditNoteModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? CreditNoteMessage.fromJson(json['message'])
            : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['data'] = data;
    return map;
  }
}

class CreditNoteMessage {
  List<CreditNoteData>? data;
  Pagination? pagination;

  CreditNoteMessage({this.data, this.pagination});

  CreditNoteMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<CreditNoteData>.from(
        json['data'].map((x) => CreditNoteData.fromJson(x)),
      );
    }
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class CreditNoteData {
  String? id;
  String? relatedId;
  String? invoice;
  String? currency;
  String? customer;
  String? amount;
  String? date;
  String? description;
  String? attachment;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  CreditNoteData({
    this.id,
    this.relatedId,
    this.customer,
    this.invoice,
    this.currency,
    this.amount,
    this.date,
    this.description,
    this.attachment,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  CreditNoteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relatedId = json['related_id'];
    invoice = json['invoice'];
    currency = json['currency'];
    amount = json['amount'];
    date = json['date'];
    description = json['description'];
    attachment = json['attachment'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['related_id'] = relatedId;
    map['invoice'] = invoice;
    map['customer'] = customer;
    map['currency'] = currency;
    map['amount'] = amount;
    map['date'] = date;
    map['description'] = description;
    map['attachment'] = attachment;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
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
