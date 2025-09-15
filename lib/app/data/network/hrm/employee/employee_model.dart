// class EmployeeModel {
//   final String id;
//   final String employeeId;
//   final String username;
//   final String password;
//   final String email;
//   final String roleId;
//   final String profilePic;
//   final String firstName;
//   final String lastName;
//   final String? phoneCode;
//   final String phone;
//   final String address;
//   final String? state;
//   final String? city;
//   final String? country;
//   final String? zipcode;
//   final String? website;
//   final String gender;
//   final DateTime joiningDate;
//   final DateTime leaveDate;
//   final String branch;
//   final String department;
//   final String designation;
//   final String salary;
//   final String accountHolder;
//   final int accountNumber;
//   final String bankName;
//   final String ifsc;
//   final String? gstIn;
//   final String bankLocation;
//   final String? cvPath;
//   final String? links;
//   final String? eSignature;
//   final String? accountType;
//   final String clientId;
//   final String? clientPlanId;
//   final String? documents;
//   final String? resetPasswordOTP;
//   final String? resetPasswordOTPExpiry;
//   final String? storageLimit;
//   final String? storageUsed;
//   final String createdBy;
//   final String updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   EmployeeModel({
//     required this.id,
//     required this.employeeId,
//     required this.username,
//     required this.password,
//     required this.email,
//     required this.roleId,
//     required this.profilePic,
//     required this.firstName,
//     required this.lastName,
//     required this.phoneCode,
//     required this.phone,
//     required this.address,
//     this.state,
//     this.city,
//     this.country,
//     this.zipcode,
//     this.website,
//     required this.gender,
//     required this.joiningDate,
//     required this.leaveDate,
//     required this.branch,
//     required this.department,
//     required this.designation,
//     required this.salary,
//     required this.accountHolder,
//     required this.accountNumber,
//     required this.bankName,
//     required this.ifsc,
//     this.gstIn,
//     required this.bankLocation,
//     this.cvPath,
//     this.links,
//     this.eSignature,
//     this.accountType,
//     required this.clientId,
//     this.clientPlanId,
//     this.documents,
//     this.resetPasswordOTP,
//     this.resetPasswordOTPExpiry,
//     this.storageLimit,
//     this.storageUsed,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory EmployeeModel.fromJson(Map<String, dynamic> json) {
//     return EmployeeModel(
//       id: json['id'],
//       employeeId: json['employeeId'],
//       username: json['username'],
//       password: json['password'],
//       email: json['email'],
//       roleId: json['role_id'],
//       profilePic: json['profilePic'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       phoneCode: json['phoneCode'],
//       phone: json['phone'],
//       address: json['address'],
//       state: json['state'],
//       city: json['city'],
//       country: json['country'],
//       zipcode: json['zipcode'],
//       website: json['website'],
//       gender: json['gender'],
//       joiningDate: DateTime.parse(json['joiningDate']),
//       leaveDate: DateTime.parse(json['leaveDate']),
//       branch: json['branch'],
//       department: json['department'],
//       designation: json['designation'],
//       salary: json['salary'],
//       accountHolder: json['accountholder'],
//       accountNumber: json['accountnumber'],
//       bankName: json['bankname'],
//       ifsc: json['ifsc'],
//       gstIn: json['gstIn'],
//       bankLocation: json['banklocation'],
//       cvPath: json['cv_path'],
//       links: json['links'],
//       eSignature: json['e_signature'],
//       accountType: json['accounttype'],
//       clientId: json['client_id'],
//       clientPlanId: json['client_plan_id'],
//       documents: json['documents'],
//       resetPasswordOTP: json['resetPasswordOTP'],
//       resetPasswordOTPExpiry: json['resetPasswordOTPExpiry'],
//       storageLimit: json['storage_limit'],
//       storageUsed: json['storage_used'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'employeeId': employeeId,
//       'username': username,
//       'password': password,
//       'email': email,
//       'role_id': roleId,
//       'profilePic': profilePic,
//       'firstName': firstName,
//       'lastName': lastName,
//       'phoneCode': phoneCode,
//       'phone': phone,
//       'address': address,
//       'state': state,
//       'city': city,
//       'country': country,
//       'zipcode': zipcode,
//       'website': website,
//       'gender': gender,
//       'joiningDate': joiningDate.toIso8601String(),
//       'leaveDate': leaveDate.toIso8601String(),
//       'branch': branch,
//       'department': department,
//       'designation': designation,
//       'salary': salary,
//       'accountholder': accountHolder,
//       'accountnumber': accountNumber,
//       'bankname': bankName,
//       'ifsc': ifsc,
//       'gstIn': gstIn,
//       'banklocation': bankLocation,
//       'cv_path': cvPath,
//       'links': links,
//       'e_signature': eSignature,
//       'accounttype': accountType,
//       'client_id': clientId,
//       'client_plan_id': clientPlanId,
//       'documents': documents,
//       'resetPasswordOTP': resetPasswordOTP,
//       'resetPasswordOTPExpiry': resetPasswordOTPExpiry,
//       'storage_limit': storageLimit,
//       'storage_used': storageUsed,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

class EmployeeModel {
  final bool success;
  final EmployeeMessage? message;
  final dynamic data;

  EmployeeModel({required this.success, this.message, this.data});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      success: json['success'] ?? false,
      message:
          json['message'] != null
              ? EmployeeMessage.fromJson(json['message'])
              : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message?.toJson(), "data": data};
  }
}

class EmployeeMessage {
  final List<EmployeeData> data;
  final Pagination pagination;

  EmployeeMessage({required this.data, required this.pagination});

  factory EmployeeMessage.fromJson(Map<String, dynamic> json) {
    return EmployeeMessage(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => EmployeeData.fromJson(e))
              .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data.map((e) => e.toJson()).toList(),
      "pagination": pagination.toJson(),
    };
  }
}

class Pagination {
  final int total;
  final int current;
  final String pageSize;
  final int? totalPages;

  Pagination({
    required this.total,
    required this.current,
    required this.pageSize,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] ?? 0,
      current: json['current'] ?? 0,
      pageSize: json['pageSize']?.toString() ?? "all",
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total": total,
      "current": current,
      "pageSize": pageSize,
      "totalPages": totalPages,
    };
  }
}

class EmployeeData {
  final Map<String, dynamic>? conversations;
  final String? id;
  final String? employeeId;
  final String username;
  final String password;
  final String email;
  final String? roleId;
  final String? profilePic;
  final String firstName;
  final String lastName;
  final String phoneCode;
  final String phone;
  final String currency;
  final String? address;
  final String? state;
  final String? city;
  final String? country;
  final String? zipcode;
  final String? website;
  final String? gender;
  final DateTime? joiningDate;
  final DateTime? leaveDate;
  final String branch;
  final String department;
  final String designation;
  final String salary;
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
  final String? storageLimit;
  final String? storageUsed;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? key;

  EmployeeData({
    this.conversations,
    this.id,
    this.employeeId,
    required this.username,
    required this.password,
    required this.email,
    this.roleId,
    this.profilePic,
    required this.firstName,
    required this.lastName,
    required this.phoneCode,
    required this.phone,
    required this.currency,
    this.address,
    this.state,
    this.city,
    this.country,
    this.zipcode,
    this.website,
    this.gender,
    this.joiningDate,
    this.leaveDate,
    required this.branch,
    required this.department,
    required this.designation,
    required this.salary,
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
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      conversations: json['conversations'],
      id: json['id'] ?? "",
      employeeId: json['employeeId'] ?? "",
      username: json['username'] ?? "",
      password: json['password'] ?? "",
      email: json['email'] ?? "",
      roleId: json['role_id'] ?? "",
      profilePic: json['profilePic'],
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      phoneCode: json['phoneCode'] ?? "",
      phone: json['phone'] ?? "",
      currency: json['currency'] ?? "",
      address: json['address'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      zipcode: json['zipcode'],
      website: json['website'],
      gender: json['gender'],
      joiningDate:
          json['joiningDate'] != null
              ? DateTime.tryParse(json['joiningDate'])
              : null,
      leaveDate:
          json['leaveDate'] != null
              ? DateTime.tryParse(json['leaveDate'])
              : null,
      branch: json['branch'] ?? "",
      department: json['department'] ?? "",
      designation: json['designation'] ?? "",
      salary: json['salary'].toString() ?? "0.0",
      accountholder: json['accountholder'],
      accountnumber: json['accountnumber'].toString() ?? '',
      bankname: json['bankname'],
      ifsc: json['ifsc'],
      gstIn: json['gstIn'],
      banklocation: json['banklocation'],
      cvPath: json['cv_path'],
      links: json['links'],
      eSignature: json['e_signature'],
      accounttype: json['accounttype'],
      clientId: json['client_id'] ?? "",
      clientPlanId: json['client_plan_id'],
      documents: json['documents'],
      resetPasswordOTP: json['resetPasswordOTP'],
      resetPasswordOTPExpiry: json['resetPasswordOTPExpiry'],
      storageLimit: json['storage_limit'],
      storageUsed: json['storage_used'],
      createdBy: json['created_by'] ?? "",
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      key: json['key'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "conversations": conversations,
      "id": id,
      "employeeId": employeeId,
      "username": username,
      "password": password,
      "email": email,
      "role_id": roleId,
      "profilePic": profilePic,
      "firstName": firstName,
      "lastName": lastName,
      "phoneCode": phoneCode,
      "phone": phone,
      "currency": currency,
      "address": address,
      "state": state,
      "city": city,
      "country": country,
      "zipcode": zipcode,
      "website": website,
      "gender": gender,
      "joiningDate": joiningDate?.toIso8601String(),
      "leaveDate": leaveDate?.toIso8601String(),
      "branch": branch,
      "department": department,
      "designation": designation,
      "salary": salary,
      "accountholder": accountholder,
      "accountnumber": accountnumber,
      "bankname": bankname,
      "ifsc": ifsc,
      "gstIn": gstIn,
      "banklocation": banklocation,
      "cv_path": cvPath,
      "links": links,
      "e_signature": eSignature,
      "accounttype": accounttype,
      "client_id": clientId,
      "client_plan_id": clientPlanId,
      "documents": documents,
      "resetPasswordOTP": resetPasswordOTP,
      "resetPasswordOTPExpiry": resetPasswordOTPExpiry,
      "storage_limit": storageLimit,
      "storage_used": storageUsed,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "key": key,
    };
  }
}
