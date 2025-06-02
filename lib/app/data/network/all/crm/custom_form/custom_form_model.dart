class CustomFormModel {
  final String? id;
  final String? title;
  final String? description;
  final String? eventName;
  final String? eventLocation;
  final DateTime? startDate;
  final DateTime? endDate;
  final Map<String, CustomFormField>? fields;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomFormModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventName,
    required this.eventLocation,
    required this.startDate,
    required this.endDate,
    required this.fields,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomFormModel.fromJson(Map<String, dynamic> json) {
    return CustomFormModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventName: json['event_name'],
      eventLocation: json['event_location'],
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      fields: json['fields'] != null
          ? Map<String, CustomFormField>.from(json['fields'].map(
              (key, value) => MapEntry(key, CustomFormField.fromJson(value))))
          : null,
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_name': eventName,
      'event_location': eventLocation,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'fields': fields?.map((key, value) => MapEntry(key, value.toJson())),
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class CustomFormField {
  final String? type;
  final bool? required;
  final Map<String, dynamic>? validation;

  CustomFormField({
    this.type,
    this.required,
    this.validation,
  });

  factory CustomFormField.fromJson(Map<String, dynamic> json) {
    return CustomFormField(
      type: json['type'],
      required: json['required'],
      validation: json['validation'] != null
          ? Map<String, dynamic>.from(json['validation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'required': required,
      'validation': validation,
    };
  }
}
