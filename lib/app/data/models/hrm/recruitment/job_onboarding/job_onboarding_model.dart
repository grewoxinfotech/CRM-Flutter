class JobOnboardingModel {
  final String id;
  final String interviewer;
  final String joiningDate;
  final String daysOfWeek;
  final String salary;
  final String currency;
  final String salaryType;
  final String salaryDuration;
  final String jobType;
  final String status;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobOnboardingModel({
    required this.id,
    required this.interviewer,
    required this.joiningDate,
    required this.daysOfWeek,
    required this.salary,
    required this.currency,
    required this.salaryType,
    required this.salaryDuration,
    required this.jobType,
    required this.status,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobOnboardingModel.fromJson(Map<String, dynamic> json) {
    return JobOnboardingModel(
      id: json['id'],
      interviewer: json['Interviewer'],
      joiningDate: json['JoiningDate'],
      daysOfWeek: json['DaysOfWeek'],
      salary: json['Salary'],
      currency: json['Currency'],
      salaryType: json['SalaryType'],
      salaryDuration: json['SalaryDuration'],
      jobType: json['JobType'],
      status: json['Status'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Interviewer": interviewer,
      "JoiningDate": joiningDate,
      "DaysOfWeek": daysOfWeek,
      "Salary": salary,
      "Currency": currency,
      "SalaryType": salaryType,
      "SalaryDuration": salaryDuration,
      "JobType": jobType,
      "Status": status,
      "client_id": clientId,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
