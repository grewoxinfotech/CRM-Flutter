class PayslipModel {
  bool? success;
  PayslipMessage? message;
  dynamic data;

  PayslipModel({this.success, this.message, this.data});

  PayslipModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? PayslipMessage.fromJson(json['message'])
            : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['data'] = data;
    return map;
  }
}

class PayslipMessage {
  List<PayslipData>? data;
  Pagination? pagination;

  PayslipMessage({this.data, this.pagination});

  PayslipMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<PayslipData>.from(
        json['data'].map((x) => PayslipData.fromJson(x)),
      );
    }
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class PayslipData {
  String? id;
  String? employeeId;
  String? payslipType;
  String? currency;
  String? currencyCode;
  String? salary;
  int? netSalary;
  String? status;
  String? paymentDate;
  String? bankAccount;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  PayslipData({
    this.id,
    this.employeeId,
    this.payslipType,
    this.currency,
    this.currencyCode,
    this.salary,
    this.netSalary,
    this.status,
    this.paymentDate,
    this.bankAccount,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  PayslipData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    payslipType = json['payslipType'];
    currency = json['currency'];
    currencyCode = json['currencyCode'];
    salary = json['salary'];
    netSalary = json['netSalary'];
    status = json['status'];
    paymentDate = json['paymentDate'];
    bankAccount = json['bankAccount'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['employeeId'] = employeeId;
    map['payslipType'] = payslipType;
    map['currency'] = currency;
    map['currencyCode'] = currencyCode;
    map['salary'] = salary;
    map['netSalary'] = netSalary.toString();
    map['status'] = status;
    map['paymentDate'] = paymentDate;
    map['bankAccount'] = bankAccount;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    return map;
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['current'] = current;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
