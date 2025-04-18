class ContractModel {
  final String id;
  final String contractNumber;
  final String subject;
  final String client;
  final String project;
  final String type;
  final num value;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String currency;
  final String phone;
  final String city;
  final String state;
  final String country;
  final int zipcode;
  final String address;
  final String notes;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContractModel({
    required this.id,
    required this.contractNumber,
    required this.subject,
    required this.client,
    required this.project,
    required this.type,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.currency,
    required this.phone,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
    required this.address,
    required this.notes,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'],
      contractNumber: json['contract_number'],
      subject: json['subject'],
      client: json['client'],
      project: json['project'],
      type: json['type'],
      value: json['value'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      currency: json['currency'],
      phone: json['phone'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipcode: json['zipcode'],
      address: json['address'],
      notes: json['notes'],
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
      'contract_number': contractNumber,
      'subject': subject,
      'client': client,
      'project': project,
      'type': type,
      'value': value,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'description': description,
      'currency': currency,
      'phone': phone,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'address': address,
      'notes': notes,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
