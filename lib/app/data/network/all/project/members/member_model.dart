class MemberModel {
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
  final String? currency;
  final String? address;
  final String? state;
  final String? city;
  final String? country;
  final String? zipcode;
  final String? website;
  final String? gender;
  final String? joiningDate;
  final String? leaveDate;
  final String? branch;
  final String? department;
  final String? designation;
  final String? salary;
  final String? accountHolder;
  final String? accountNumber;
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
  final String? resetPasswordOTP;
  final String? resetPasswordOTPExpiry;
  final String? storageLimit;
  final String? storageUsed;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  MemberModel({
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
   required this.currency,
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
   required this.resetPasswordOTP,
   required this.resetPasswordOTPExpiry,
   required this.storageLimit,
   required this.storageUsed,
   required this.createdBy,
   required this.updatedBy,
   required this.createdAt,
   required this.updatedAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
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
      currency: json['currency'],
      address: json['address'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      zipcode: json['zipcode'],
      website: json['website'],
      gender: json['gender'],
      joiningDate: json['joiningDate'],
      leaveDate: json['leaveDate'],
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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
      'currency': currency,
      'address': address,
      'state': state,
      'city': city,
      'country': country,
      'zipcode': zipcode,
      'website': website,
      'gender': gender,
      'joiningDate': joiningDate,
      'leaveDate': leaveDate,
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
