class DealModel {
  final String? id;
  final String? leadTitle;
  final String? dealName;
  final String? pipeline;
  final String? stage;
  final String? currency;
  final int? price;
  final DateTime? closedDate;
  final String? project;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DealModel({
   this.id,
   this.leadTitle,
   this.dealName,
   this.pipeline,
   this.stage,
   this.currency,
   this.price,
   this.closedDate,
   this.project,
   this.clientId,
   this.createdBy,
   this.updatedBy,
   this.createdAt,
   this.updatedAt,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'],
      leadTitle: json['leadTitle'],
      dealName: json['dealName'],
      pipeline: json['pipeline'],
      stage: json['stage'],
      currency: json['currency'],
      price: json['price'],
      closedDate: DateTime.parse(json['closedDate']),
      project: json['project'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leadTitle': leadTitle,
      'dealName': dealName,
      'pipeline': pipeline,
      'stage': stage,
      'currency': currency,
      'price': price,
      'closedDate': closedDate,
      'project': project,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
