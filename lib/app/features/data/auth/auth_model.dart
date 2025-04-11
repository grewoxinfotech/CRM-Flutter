class AuthModel {
  final String? token;
  final UserModel user;

  AuthModel({this.token,required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user.toJson()};
  }
}

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
  final String? joiningDate;
  final String? leaveDate;
  final String? branch;
  final String? department;
  final String? designation;
  final String? salary;
  final String? accountholder;
  final String? accountnumber;
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
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
      'joiningDate': joiningDate,
      'leaveDate': leaveDate,
      'branch': branch,
      'department': department,
      'designation': designation,
      'salary': salary,
      'accountholder': accountholder,
      'accountnumber': accountnumber,
      'bankname': bankname,
      'ifsc': ifsc,
      'gstIn': gstIn,
      'banklocation': banklocation,
      'cv_path': cvPath,
      'links': links,
      'e_signature': eSignature,
      'accounttype': accounttype,
      'client_id': clientId,
      'client_plan_id': clientPlanId,
      'documents': documents,
      'resetPasswordOTP': resetPasswordOTP,
      'resetPasswordOTPExpiry': resetPasswordOTPExpiry,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
