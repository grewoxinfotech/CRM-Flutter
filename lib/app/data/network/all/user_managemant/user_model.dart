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
   required this.id,
   required this.employeeId,
   required this.username,
   required this.password,
   required this.email,
   required this.roleId,
   required this.profilePic,
   required this.firstName,
   required this.lastName,
   required this.phoneCode,
   required this.phone,
   required this.address,
   required this.state,
   required this.city,
   required this.country,
   required this.zipcode,
   required this.website,
   required this.gender,
   required this.joiningDate,
   required this.leaveDate,
   required this.branch,
   required this.department,
   required this.designation,
   required this.salary,
   required this.accountHolder,
   required this.accountNumber,
   required this.bankName,
   required this.ifsc,
   required this.gstIn,
   required this.bankLocation,
   required this.cvPath,
   required this.links,
   required this.eSignature,
   required this.accountType,
   required this.clientId,
   required this.clientPlanId,
   required this.documents,
   required this.conversations,
   required this.resetPasswordOTP,
   required this.resetPasswordOTPExpiry,
   required this.createdBy,
   required this.updatedBy,
   required this.createdAt,
   required this.updatedAt,
   required this.currency,
   required this.storageLimit,
   required this.storageUsed,
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
      joiningDate: json['joiningDate'] != null ? DateTime.tryParse(json['joiningDate']) : null,
      leaveDate: json['leaveDate'] != null ? DateTime.tryParse(json['leaveDate']) : null,
      branch: json['branch']?.toString(),
      department: json['department']?.toString(),
      designation: json['designation']?.toString(),
      salary: json['salary'] != null ? double.tryParse(json['salary'].toString()) : null,
      accountHolder: json['accountholder']?.toString(),
      accountNumber: json['accountnumber'] != null ? int.tryParse(json['accountnumber'].toString()) : null,
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
      resetPasswordOTPExpiry: json['resetPasswordOTPExpiry'] != null
          ? DateTime.tryParse(json['resetPasswordOTPExpiry'])
          : null,
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // default fallback
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      storageLimit: json['storage_limit'] != null ? int.tryParse(json['storage_limit'].toString()) : null,
      storageUsed: json['storage_used'] != null ? int.tryParse(json['storage_used'].toString()) : null,
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
