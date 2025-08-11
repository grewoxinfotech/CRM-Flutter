class AllUsersModel {
  final bool success;
  final String message;
  final List<User> data;

  AllUsersModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllUsersModel.fromJson(Map<String, dynamic> json) {
    return AllUsersModel(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List).map((e) => User.fromJson(e)).toList(),
    );
  }
}

class User {
  final String id;
  final String? employeeId;
  final String username;
  final String password;
  final String email;
  final String roleId;
  final Map<String, dynamic>? conversations;
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
  final String? accountholder;
  final dynamic accountnumber;
  final String? bankname;
  final String? ifsc;
  final String? gstIn;
  final String? banklocation;
  final String? cvPath;
  final String? links;
  final String? eSignature;
  final String? accounttype;
  final String? clientId;
  final String? clientPlanId;
  final String? documents;
  final String? resetPasswordOTP;
  final String? resetPasswordOTPExpiry;
  final String? storageLimit;
  final String? storageUsed;
  final String createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    this.employeeId,
    required this.username,
    required this.password,
    required this.email,
    required this.roleId,
    this.conversations,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.phone,
    this.currency,
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
    this.accountholder,
    this.accountnumber,
    this.bankname,
    this.ifsc,
    this.gstIn,
    this.banklocation,
    this.cvPath,
    this.links,
    this.eSignature,
    this.accounttype,
    this.clientId,
    this.clientPlanId,
    this.documents,
    this.resetPasswordOTP,
    this.resetPasswordOTPExpiry,
    this.storageLimit,
    this.storageUsed,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      employeeId: json['employeeId'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      roleId: json['role_id'],
      conversations: json['conversations'],
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
      accountholder: json['accountholder'],
      accountnumber: json['accountnumber'],
      bankname: json['bankname'],
      ifsc: json['ifsc'],
      gstIn: json['gstIn'],
      banklocation: json['banklocation'],
      cvPath: json['cv_path'],
      links: json['links'],
      eSignature: json['e_signature'],
      accounttype: json['accounttype'],
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
}
