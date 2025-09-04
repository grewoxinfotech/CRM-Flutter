class UserModel {
  final String? id;
  final String? employeeId;
  final String? username;
  final String? password;
  final String? email;
  final String? roleId;
  final String? profilePic;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? phone;
  final String? address;
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
  final double? salary;
  final String? accountHolder;
  final int? accountNumber;
  final String? bankName;
  final String? ifsc;
  final String? gstIn;
  final String? bankLocation;
  final String? cvPath;
  final String? links;
  final String? eSignature;
  final String? accountType;
  final String? clientId;
  final String? clientPlanId;
  final String? documents;
  final String? conversations;
  final String? resetPasswordOTP;
  final DateTime? resetPasswordOTPExpiry;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? storageLimit;
  final int? storageUsed;
  final String currency;

  UserModel({
    this.id,
    this.employeeId,
    this.username,
    this.password,
    this.email,
    this.roleId,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.phone,
    this.address,
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
    this.accountHolder,
    this.accountNumber,
    this.bankName,
    this.ifsc,
    this.gstIn,
    this.bankLocation,
    this.cvPath,
    this.links,
    this.eSignature,
    this.accountType,
    this.clientId,
    this.clientPlanId,
    this.documents,
    this.conversations,
    this.resetPasswordOTP,
    this.resetPasswordOTPExpiry,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.storageLimit,
    this.storageUsed,
    required this.currency,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      employeeId: json['employeeId']?.toString(),
      username: json['username']?.toString(),
      password: json['password']?.toString(),
      email: json['email']?.toString(),
      roleId: json['role_id']?.toString(),
      profilePic: json['profilePic']?.toString(),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      phoneCode: json['phoneCode']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      state: json['state']?.toString(),
      city: json['city']?.toString(),
      country: json['country']?.toString(),
      zipcode: json['zipcode']?.toString(),
      website: json['website']?.toString(),
      gender: json['gender']?.toString(),
      joiningDate:
          json['joiningDate'] != null
              ? DateTime.parse(json['joiningDate'])
              : null,
      leaveDate:
          json['leaveDate'] != null ? DateTime.parse(json['leaveDate']) : null,
      branch: json['branch']?.toString(),
      department: json['department']?.toString(),
      designation: json['designation']?.toString(),
      salary:
          json['salary'] != null
              ? double.parse(json['salary'].toString())
              : null,
      accountHolder: json['accountholder']?.toString(),
      accountNumber:
          json['accountnumber'] != null
              ? int.parse(json['accountnumber'].toString())
              : null,
      bankName: json['bankname']?.toString(),
      ifsc: json['ifsc']?.toString(),
      gstIn: json['gstIn']?.toString(),
      bankLocation: json['banklocation']?.toString(),
      cvPath: json['cv_path']?.toString(),
      links: json['links']?.toString(),
      eSignature: json['e_signature']?.toString(),
      accountType: json['accounttype']?.toString(),
      clientId: json['client_id']?.toString(),
      clientPlanId: json['client_plan_id']?.toString(),
      documents: json['documents']?.toString(),
      conversations: json['conversations']?.toString(),
      resetPasswordOTP: json['resetPasswordOTP']?.toString(),
      resetPasswordOTPExpiry:
          json['resetPasswordOTPExpiry'] != null
              ? DateTime.parse(json['resetPasswordOTPExpiry'])
              : null,
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      storageLimit:
          json['storage_limit'] != null
              ? int.parse(json['storage_limit'].toString())
              : null,
      storageUsed:
          json['storage_used'] != null
              ? int.parse(json['storage_used'].toString())
              : null,
      currency: json['currency']?.toString() ?? 'USD',
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
      'ifsc': num.tryParse(ifsc ?? ''),
      'gstIn': gstIn,
      'banklocation': bankLocation,
      'cv_path': cvPath,
      'links': links,
      'e_signature': eSignature,
      'accounttype': accountType,
      'client_id': clientId,
      'client_plan_id': clientPlanId,
      'documents': documents,
      'conversations': conversations,
      'resetPasswordOTP': resetPasswordOTP,
      'resetPasswordOTPExpiry': resetPasswordOTPExpiry?.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'storage_limit': storageLimit,
      'storage_used': storageUsed,
      'currency': currency,
    };
  }
}
