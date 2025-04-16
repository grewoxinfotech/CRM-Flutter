import 'dart:convert';

import 'package:crm_flutter/app/data/models/lead_model.dart';
import 'package:crm_flutter/app/data/models/system/product_model.dart';

class DealModel {
  final String? id;
  final String? dealTitle;
  final String? currency;
  final num? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final DateTime? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final List<Product>? products;
  final List<FileModel>? files;
  final List<String>? assignedTo;
  final String? clientId;
  final bool? isWon;
  final String? companyId;
  final String? contactId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DealModel({
    this.id,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label,
    this.closedDate,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.source,
    this.companyName,
    this.website,
    this.address,
    this.products,
    this.files,
    this.assignedTo,
    this.clientId,
    this.isWon,
    this.companyId,
    this.contactId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['products'];
    final fileJson = json['files'];
    final assignedJson = json['assigned_to'];

    return DealModel(
      id: json['id'],
      dealTitle: json['dealTitle'],
      currency: json['currency'],
      value: json['value'],
      pipeline: json['pipeline'],
      stage: json['stage'],
      status: json['status'],
      label: json['label'],
      closedDate: DateTime.parse(json['closedDate']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'] ?? '',
      phone: json['phone'],
      source: json['source'],
      companyName: json['company_name'],
      website: json['website'],
      address: json['address'] ?? '',
      products: List<Product>.from(
        (productJson != null ? (jsonDecode(productJson)['products'] ?? []) : [])
            .map((e) => Product.fromJson(e)),
      ),
      files: List<FileModel>.from(
        (fileJson != null ? jsonDecode(fileJson) : []).map(
          (e) => FileModel.fromJson(e),
        ),
      ),
      assignedTo: List<String>.from(
        (assignedJson != null ? jsonDecode(assignedJson)['assigned_to'] : []),
      ),
      clientId: json['client_id'],
      isWon: json['is_won'],
      companyId: json['company_id'],
      contactId: json['contact_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
