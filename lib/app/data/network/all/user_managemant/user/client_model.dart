


class ClientUserModel {
  final String id;
  final String? employeeId;
  final String username;
  final String password;
  final String email;
  final String roleId;
  final String profilePic;
  final String firstName;
  final String lastName;
  final String? phoneCode;
  final String phone;
  final String address;
  final String? state;
  final String? city;
  final String? country;
  final String? zipcode;
  final String? website;
  final String? gender;
  final DateTime? joiningDate;
  final DateTime? leaveDate;
  final String? branch;
  final String? department;
  final String? designation;
  final String? salary;
  final String accountHolder;
  final int accountNumber;
  final String bankName;
  final String ifsc;
  final String? gstIn;
  final String bankLocation;
  final String? cvPath;
  final String? links;
  final String? eSignature;
  final String? accountType;
  final String clientId;
  final String? clientPlanId;
  final String? documents;
  final String? resetPasswordOTP;
  final String? resetPasswordOTPExpiry;
  final String? storageLimit;
  final String? storageUsed;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientUserModel({
    required this.id,
    this.employeeId,
    required this.username,
    required this.password,
    required this.email,
    required this.roleId,
    required this.profilePic,
    required this.firstName,
    required this.lastName,
    this.phoneCode,
    required this.phone,
    required this.address,
    this.state,
    this.city,
    this.country,
    this.zipcode,
    this.website,
    this.gender,
    this.joiningDate,
    this.leaveDate,
    this.branch,
    this.department,
    this.designation,
    this.salary,
    required this.accountHolder ,
    required this.accountNumber,
    required this.bankName,
    required this.ifsc,
    this.gstIn,
    required this.bankLocation,
    this.cvPath,
    this.links,
    this.eSignature,
    this.accountType,
    required this.clientId,
    this.clientPlanId,
    this.documents,
    this.resetPasswordOTP,
    this.resetPasswordOTPExpiry,
    this.storageLimit,
    this.storageUsed,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientUserModel.fromJson(Map<String, dynamic> json) {
    var conversationsFromJson = json['conversations'] as List?;

    return ClientUserModel(
      id: json['id'],
      employeeId: json['employeeId'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      roleId: json['role_id'],
      profilePic: json['profilePic'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneCode: json['phoneCode'],
      phone: json['phone'],
      address: json['address'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      zipcode: json['zipcode'],
      website: json['website'],
      gender: json['gender'],
      joiningDate: json['joiningDate'] != null ? DateTime.tryParse(json['joiningDate']) : null,
      leaveDate: json['leaveDate'] != null ? DateTime.tryParse(json['leaveDate']) : null,
      branch: json['branch'],
      department: json['department'],
      designation: json['designation'],
      salary: json['salary'],
      accountHolder: json['accountholder'],
      accountNumber: json['accountnumber'],
      bankName: json['bankname'],
      ifsc: json['ifsc'],
      gstIn: json['gstIn'],
      bankLocation: json['banklocation'],
      cvPath: json['cv_path'],
      links: json['links'],
      eSignature: json['e_signature'],
      accountType: json['accounttype'],
      clientId: json['client_id'],
      clientPlanId: json['client_plan_id'],
      documents: json['documents'],
      resetPasswordOTP: json['resetPasswordOTP'],
      resetPasswordOTPExpiry: json['resetPasswordOTPExpiry'],
      storageLimit: json['storage_limit'],
      storageUsed: json['storage_used'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'employeeId': employeeId,
      'username': username,
      'password': password,
      'email': email,
      'role_id': roleId,
      'profilePic': profilePic,
      'firstName': firstName,
      'lastName': lastName,
      'phoneCode': phoneCode,
      'phone': phone,
      'address': address,
      'state': state,
      'city': city,
      'country': country,
      'zipcode': zipcode,
      'website': website,
      'gender': gender,
      'joiningDate': joiningDate?.toIso8601String(),
      'leaveDate': leaveDate?.toIso8601String(),
      'branch': branch,
      'department': department,
      'designation': designation,
      'salary': salary,
      'accountholder': accountHolder,
      'accountnumber': accountNumber,
      'bankname': bankName,
      'ifsc': ifsc,
      'gstIn': gstIn,
      'banklocation': bankLocation,
      'cv_path': cvPath,
      'links': links,
      'e_signature': eSignature,
      'accounttype': accountType,
      'client_id': clientId,
      'client_plan_id': clientPlanId,
      'documents': documents,
      'resetPasswordOTP': resetPasswordOTP,
      'resetPasswordOTPExpiry': resetPasswordOTPExpiry,
      'storage_limit': storageLimit,
      'storage_used': storageUsed,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
