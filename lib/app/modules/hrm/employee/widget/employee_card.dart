import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/hrm/hrm_system/designation/designation_model.dart';
import 'package:crm_flutter/app/data/network/system/country/controller/country_controller.dart';
import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/modules/hrm/designation/controllers/designation_controller.dart';
import 'package:crm_flutter/app/modules/hrm/employee/controllers/employee_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeCard extends StatefulWidget {
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
  final String? currency;
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
    this.onDelete, this.currency,
  });

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  final DesignationController designationController = Get.put(
    DesignationController(),
  );
  final EmployeeController employeeController = Get.find<EmployeeController>();
  final CountryController countryController = Get.put(CountryController());
  final CurrencyController currencyController = Get.put(CurrencyController());

  @override
  void initState() {
    super.initState();
    // Fetch designation safely after first frame
    if (widget.designation != null && widget.designation!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        employeeController.getDesignationById(widget.designation!);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await currencyController.getCurrency();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textPrimary = Get.theme.colorScheme.onPrimary;
    final textSecondary = Get.theme.colorScheme.onSecondary;

    return GestureDetector(
      onTap: widget.onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Profile Picture or Initials ---
            CircleAvatar(
              radius: 28,
              backgroundColor: ColorRes.primary.withOpacity(0.2),
              backgroundImage:
                  (widget.profilePic != null && widget.profilePic!.isNotEmpty)
                      ? NetworkImage(widget.profilePic!)
                      : null,
              child:
                  (widget.profilePic == null || widget.profilePic!.isEmpty)
                      ? Text(
                        "${widget.firstName?.substring(0, 1) ?? '?'}${widget.lastName?.substring(0, 1) ?? ''}",
                        style: const TextStyle(
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
                  // Name + Salary
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.firstName ?? ''} ${widget.lastName ?? ''}"
                              .trim(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                      ),
                      if (widget.salary != null)
                        Obx(
                          () {
                            final currency = currencyController.currencyModel.firstWhereOrNull((element) => element.id == widget.currency,);
                            if (currency == null) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                            "${currency.currencyIcon} ${widget.salary}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          );
                          },
                        ),
                    ],
                  ),

                  // Designation (reactive)
                  if (widget.designation != null &&
                      widget.designation!.isNotEmpty)
                    Obx(() {
                      final DesignationData? data = designationController.items
                          .firstWhereOrNull(
                            (element) => element.id == widget.designation,
                          );
                      return data == null
                          ? const SizedBox.shrink()
                          : Text(
                            data.designationName ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: textSecondary,
                            ),
                          );
                    }),

                  // Department
                  // if (widget.department != null &&
                  //     widget.department!.isNotEmpty)
                  //   Text(
                  //     widget.department!,
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //       color: textSecondary.withOpacity(0.8),
                  //     ),
                  //   ),
                  // const SizedBox(height: 6),

                  // Contact Info
                  if (widget.email != null)
                    Text(
                      widget.email!,
                      style: TextStyle(fontSize: 13, color: textSecondary),
                    ),
                  if (widget.phone != null)
                    Obx(() {
                      final data = countryController.countryModel
                          .firstWhereOrNull(
                            (element) => element.id == widget.phoneCode,
                          );
                      return data == null
                          ? const SizedBox.shrink()
                          : Text(
                            "${data.phoneCode ?? ''} ${widget.phone}",
                            style: TextStyle(
                              fontSize: 13,
                              color: textSecondary,
                            ),
                          );
                    }),
                  if (widget.address != null)
                    Text(
                      widget.address!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: textSecondary),
                    ),
                  const SizedBox(height: 6),

                  // Joining Date
                  if (widget.joiningDate != null)
                    Text(
                      "Joined: ${widget.joiningDate}",
                      style: TextStyle(fontSize: 12, color: textSecondary),
                    ),
                ],
              ),
            ),

            // --- Delete Icon ---
            if (widget.onDelete != null)
              CrmIc(
                iconPath: ICRes.delete,
                width: 40,
                color: ColorRes.error,
                onTap: widget.onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
