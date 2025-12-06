class DebitNote {
  final String id;
  final String bill;
  final String? date;
  final String currency;
  final int amount;
  final String description;

  DebitNote({
    required this.id,
    required this.bill,
    required this.date,
    required this.currency,
    required this.amount,
    required this.description,
  });

  factory DebitNote.fromJson(Map<String, dynamic> json) {
    int parseNum(dynamic value) =>
        int.tryParse(value.toString().split('.').first) ?? 0;

    return DebitNote(
      id: json['id'] ?? '',
      bill: json['bill'] ?? '',
      date: json['date'] != null ? json['date'] : null,
      currency: json['currency'] ?? '',
      amount: parseNum(json['amount']),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "bill": bill,
      "date": date,
      "currency": currency,
      "amount": amount,
      "description": description,
    };
  }
}

class UpdatedBill {
  final String id;
  final int previousAmount;
  final int newAmount;
  final int debitedAmount;
  final int totalDebitedAmount;
  final String previousStatus;
  final String newStatus;
  final bool stockUpdated;

  UpdatedBill({
    required this.id,
    required this.previousAmount,
    required this.newAmount,
    required this.debitedAmount,
    required this.totalDebitedAmount,
    required this.previousStatus,
    required this.newStatus,
    required this.stockUpdated,
  });

  factory UpdatedBill.fromJson(Map<String, dynamic> json) {
    int parseNum(dynamic value) =>
        int.tryParse(value.toString().split('.').first) ?? 0;

    return UpdatedBill(
      id: json['id'] ?? '',
      previousAmount: parseNum(json['previousAmount']),
      newAmount: parseNum(json['newAmount']),
      debitedAmount: parseNum(json['debitedAmount']),
      totalDebitedAmount: parseNum(json['totalDebitedAmount']),
      previousStatus: json['previousStatus'] ?? '',
      newStatus: json['newStatus'] ?? '',
      stockUpdated: json['stockUpdated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "previousAmount": previousAmount,
      "newAmount": newAmount,
      "debitedAmount": debitedAmount,
      "totalDebitedAmount": totalDebitedAmount,
      "previousStatus": previousStatus,
      "newStatus": newStatus,
      "stockUpdated": stockUpdated,
    };
  }
}

class DebitNoteItem {
  final DebitNote debitNote;
  final UpdatedBill updatedBill;

  DebitNoteItem({required this.debitNote, required this.updatedBill});

  factory DebitNoteItem.fromJson(Map<String, dynamic> json) {
    return DebitNoteItem(
      debitNote: DebitNote.fromJson(json['debitNote'] ?? json),
      updatedBill: UpdatedBill.fromJson(json['updatedBill'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "debitNote": debitNote.toJson(),
      "updatedBill": updatedBill.toJson(),
    };
  }
}

class DebitNoteModel {
  bool? success;
  DebitNoteMessage? message;
  dynamic data;

  DebitNoteModel({this.success, this.message, this.data});

  factory DebitNoteModel.fromJson(Map<String, dynamic> json) {
    return DebitNoteModel(
      success: json['success'],
      message:
          json['message'] != null
              ? DebitNoteMessage.fromJson(json['message'])
              : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (message != null) map['message'] = message!.toJson();
    map['data'] = data;
    return map;
  }
}

class DebitNoteMessage {
  List<DebitNoteItem>? data;
  Pagination? pagination;

  DebitNoteMessage({this.data, this.pagination});

  factory DebitNoteMessage.fromJson(Map<String, dynamic> json) {
    return DebitNoteMessage(
      data:
          json['data'] != null
              ? List<DebitNoteItem>.from(
                json['data'].map((x) => DebitNoteItem.fromJson(x)),
              )
              : [],
      pagination:
          json['pagination'] != null
              ? Pagination.fromJson(json['pagination'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
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
      'total': total,
      'current': current,
      'pageSize': pageSize,
      'totalPages': totalPages,
    };
  }
}
