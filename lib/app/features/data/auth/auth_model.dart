
class UserModel {
  String email;
  String password;

  UserModel({required this.email, required this.password});
}


class AuthModel {
  bool? success;
  String? message;
  Data? data;

  AuthModel({this.success, this.message, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  Null? employeeId;
  String? username;
  String? password;
  String? email;
  String? roleId;
  Null? profilePic;
  Null? firstName;
  Null? lastName;
  Null? phoneCode;
  Null? phone;
  Null? address;
  Null? state;
  Null? city;
  Null? country;
  Null? zipcode;
  Null? website;
  Null? gender;
  Null? joiningDate;
  Null? leaveDate;
  Null? branch;
  Null? department;
  Null? designation;
  Null? salary;
  Null? accountholder;
  Null? accountnumber;
  Null? bankname;
  Null? ifsc;
  Null? gstIn;
  Null? banklocation;
  Null? cvPath;
  Null? links;
  Null? eSignature;
  Null? accounttype;
  String? clientId;
  String? clientPlanId;
  Null? documents;
  Null? resetPasswordOTP;
  Null? resetPasswordOTPExpiry;
  String? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
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
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    roleId = json['role_id'];
    profilePic = json['profilePic'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneCode = json['phoneCode'];
    phone = json['phone'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    website = json['website'];
    gender = json['gender'];
    joiningDate = json['joiningDate'];
    leaveDate = json['leaveDate'];
    branch = json['branch'];
    department = json['department'];
    designation = json['designation'];
    salary = json['salary'];
    accountholder = json['accountholder'];
    accountnumber = json['accountnumber'];
    bankname = json['bankname'];
    ifsc = json['ifsc'];
    gstIn = json['gstIn'];
    banklocation = json['banklocation'];
    cvPath = json['cv_path'];
    links = json['links'];
    eSignature = json['e_signature'];
    accounttype = json['accounttype'];
    clientId = json['client_id'];
    clientPlanId = json['client_plan_id'];
    documents = json['documents'];
    resetPasswordOTP = json['resetPasswordOTP'];
    resetPasswordOTPExpiry = json['resetPasswordOTPExpiry'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['profilePic'] = this.profilePic;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneCode'] = this.phoneCode;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['website'] = this.website;
    data['gender'] = this.gender;
    data['joiningDate'] = this.joiningDate;
    data['leaveDate'] = this.leaveDate;
    data['branch'] = this.branch;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['salary'] = this.salary;
    data['accountholder'] = this.accountholder;
    data['accountnumber'] = this.accountnumber;
    data['bankname'] = this.bankname;
    data['ifsc'] = this.ifsc;
    data['gstIn'] = this.gstIn;
    data['banklocation'] = this.banklocation;
    data['cv_path'] = this.cvPath;
    data['links'] = this.links;
    data['e_signature'] = this.eSignature;
    data['accounttype'] = this.accounttype;
    data['client_id'] = this.clientId;
    data['client_plan_id'] = this.clientPlanId;
    data['documents'] = this.documents;
    data['resetPasswordOTP'] = this.resetPasswordOTP;
    data['resetPasswordOTPExpiry'] = this.resetPasswordOTPExpiry;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
