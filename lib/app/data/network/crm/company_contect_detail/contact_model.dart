class ContactModel {
  final String id;
  final String contactOwner;
  final String firstName;
  final String lastName;
  final String companyName;
  final String email;
  final String phone;
  final String contactSource;
  final String description;
  final String address;
  final String city;
  final String state;
  final String country;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContactModel({
    required this.id,
    required this.contactOwner,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.contactSource,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      contactOwner: json['contact_owner'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      companyName: json['company_name'],
      email: json['email'],
      phone: json['phone'],
      contactSource: json['contact_source'],
      description: json['description'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
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
      'contact_owner': contactOwner,
      'first_name': firstName,
      'last_name': lastName,
      'company_name': companyName,
      'email': email,
      'phone': phone,
      'contact_source': contactSource,
      'description': description,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
