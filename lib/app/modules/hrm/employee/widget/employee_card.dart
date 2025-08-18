// import 'package:crm_flutter/app/care/constants/color_res.dart';
// import 'package:crm_flutter/app/care/constants/ic_res.dart';
// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class EmployeeCard extends StatelessWidget {
//   final String? id;
//   final String? employeeId;
//   final String? username;
//   final String? password;
//   final String? email;
//   final String? roleId;
//   final String? profilePic;
//   final String? firstName;
//   final String? lastName;
//   final String? phoneCode;
//   final String? phone;
//   final String? address;
//   final String? state;
//   final String? city;
//   final String? country;
//   final String? zipcode;
//   final String? website;
//   final String? gender;
//   final String? joiningDate;
//   final String? leaveDate;
//   final String? branch;
//   final String? department;
//   final String? designation;
//   final String? salary;
//   final String? accountHolder;
//   final String? accountNumber;
//   final String? bankName;
//   final String? ifsc;
//   final String? gstIn;
//   final String? bankLocation;
//   final String? cvPath;
//   final String? links;
//   final String? eSignature;
//   final String? accountType;
//   final String? clientId;
//   final String? clientPlanId;
//   final String? documents;
//   final String? resetPasswordOTP;
//   final String? resetPasswordOTPExpiry;
//   final String? storageLimit;
//   final String? storageUsed;
//   final String? createdBy;
//   final String? updatedBy;
//   final String? createdAt;
//   final String? updatedAt;
//   final GestureTapCallback? onTap;
//   final GestureTapCallback? onDelete;
//
//   const EmployeeCard({
//     super.key,
//     this.id,
//     this.employeeId,
//     this.username,
//     this.password,
//     this.email,
//     this.roleId,
//     this.profilePic,
//     this.firstName,
//     this.lastName,
//     this.phoneCode,
//     this.phone,
//     this.address,
//     this.state,
//     this.city,
//     this.country,
//     this.zipcode,
//     this.website,
//     this.gender,
//     this.joiningDate,
//     this.leaveDate,
//     this.branch,
//     this.department,
//     this.designation,
//     this.salary,
//     this.accountHolder,
//     this.accountNumber,
//     this.bankName,
//     this.ifsc,
//     this.gstIn,
//     this.bankLocation,
//     this.cvPath,
//     this.links,
//     this.eSignature,
//     this.accountType,
//     this.clientId,
//     this.clientPlanId,
//     this.documents,
//     this.resetPasswordOTP,
//     this.resetPasswordOTPExpiry,
//     this.storageLimit,
//     this.storageUsed,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.onTap,
//     this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Color textPrimary = Get.theme.colorScheme.onPrimary;
//     Color textSecondary = Get.theme.colorScheme.onSecondary;
//     return GestureDetector(
//       onTap: onTap,
//       child: CrmCard(
//         padding: EdgeInsets.all(AppPadding.small),
//         margin: EdgeInsets.symmetric(horizontal: AppMargin.large),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("id : $id",style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: textSecondary,
//             ),),
//             Text("employeeId : $employeeId"),
//             Text("username : $username"),
//             Text("password : $password"),
//             Text("email : $email"),
//             Text("roleId : $roleId"),
//             Text("profilePic : $profilePic"),
//             Text("firstName : $firstName"),
//             Text("lastName : $lastName"),
//             Text("phoneCode : $phoneCode"),
//             Text("phone : $phone"),
//             Text("address : $address"),
//             Text("state : $state"),
//             Text("city : $city"),
//             Text("country : $country"),
//             Text("zipcode : $zipcode"),
//             Text("website : $website"),
//             Text("gender : $gender"),
//             Text("joiningDate : $joiningDate"),
//             Text("leaveDate : $leaveDate"),
//             Text("branch : $branch"),
//             Text("department : $department"),
//             Text("designation : $designation"),
//             Text("salary : $salary"),
//             Text("accountHolder : $accountHolder"),
//             Text("accountNumber : $accountNumber"),
//             Text("bankName : $bankName"),
//             Text("ifsc : $ifsc"),
//             Text("gstIn : $gstIn"),
//             Text("bankLocation : $bankLocation"),
//             Text("cvPath : $cvPath"),
//             Text("links : $links"),
//             Text("eSignature : $eSignature"),
//             Text("accountType : $accountType"),
//             Text("clientId : $clientId"),
//             Text("clientPlanId : $clientPlanId"),
//             Text("documents : $documents"),
//             Text("resetPasswordOTP : $resetPasswordOTP"),
//             Text("resetPasswordOTPExpiry : $resetPasswordOTPExpiry"),
//             Text("storageLimit : $storageLimit"),
//             Text("storageUsed : $storageUsed"),
//             Text("createdBy : $createdBy"),
//             Text("updatedBy : $updatedBy"),
//             Text("createdAt : $createdAt"),
//             Text("updatedAt : $updatedAt"),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CrmIc(
//                   iconPath: ICRes.delete,
//                   width: 50,
//                   color: ColorRes.error,
//                   onTap: onDelete,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeCard extends StatelessWidget {
  final String? id;
  final String? employeeId;
  final String? username;
  final String? email;
  final String? profilePic;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? phone;
  final String? address;
  final String? branch;
  final String? department;
  final String? designation;
  final String? salary;
  final String? joiningDate;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;

  const EmployeeCard({
    super.key,
    this.id,
    this.employeeId,
    this.username,
    this.email,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.phone,
    this.address,
    this.branch,
    this.department,
    this.designation,
    this.salary,
    this.joiningDate,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        // margin: const EdgeInsets.symmetric(
        //   horizontal: AppMargin.large,
        //   vertical: AppMargin.small,
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Profile Picture or Initials ---
            CircleAvatar(
              radius: 28,
              backgroundColor: ColorRes.primary.withOpacity(0.2),
              backgroundImage:
                  (profilePic != null && profilePic!.isNotEmpty)
                      ? NetworkImage(profilePic!)
                      : null,
              child:
                  (profilePic == null || profilePic!.isEmpty)
                      ? Text(
                        (firstName?.substring(0, 1) ?? "?") +
                            (lastName?.substring(0, 1) ?? ""),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorRes.primary,
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 12),

            // --- Employee Details ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Designation
                  Text(
                    "${firstName ?? ''} ${lastName ?? ''}".trim(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  if (designation != null && designation!.isNotEmpty)
                    Text(
                      designation!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: textSecondary,
                      ),
                    ),
                  if (department != null && department!.isNotEmpty)
                    Text(
                      department!,
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary.withOpacity(0.8),
                      ),
                    ),
                  const SizedBox(height: 6),

                  // Contact Info
                  if (email != null)
                    Text(
                      email!,
                      style: TextStyle(fontSize: 13, color: textSecondary),
                    ),
                  if (phone != null)
                    Text(
                      "${phoneCode ?? ''} $phone",
                      style: TextStyle(fontSize: 13, color: textSecondary),
                    ),
                  if (address != null)
                    Text(
                      address!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: textSecondary),
                    ),
                  const SizedBox(height: 6),

                  // Joining date & Salary
                  Row(
                    children: [
                      if (joiningDate != null)
                        Text(
                          "Joined: $joiningDate",
                          style: TextStyle(fontSize: 12, color: textSecondary),
                        ),
                      const Spacer(),
                      if (salary != null)
                        Text(
                          "₹$salary",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.success,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Delete Icon ---
            // CrmIc(
            //   iconPath: ICRes.delete,
            //   width: 40,
            //   color: ColorRes.error,
            //   onTap: onDelete,
            // ),
          ],
        ),
      ),
    );
  }
}
