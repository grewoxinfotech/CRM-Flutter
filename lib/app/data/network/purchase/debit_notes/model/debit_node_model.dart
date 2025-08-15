class DebitNote {
  final String id;
  final String bill;
  final String date;
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
    return DebitNote(
      id: json['id'] ?? '',
      bill: json['bill'] ?? '',
      date: json['date'] ?? '',
      currency: json['currency'] ?? '',
      amount: int.tryParse(json['amount'].toString().split('.').first) ?? 0,
      description: json['description'] ?? '',
    );
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
}
