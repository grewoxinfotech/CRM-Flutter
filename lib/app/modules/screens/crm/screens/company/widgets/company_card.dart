import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  final String? id;
  final String? accountOwner;
  final String? companyName;
  final String? companySource;
  final String? email;
  final String? companyNumber;
  final String? companyType;
  final String? companyCategory;
  final String? companyRevenue;
  final String? phoneCode;
  final String? phoneNumber;
  final String? website;
  final String? billingAddress;
  final String? billingCity;
  final String? billingState;
  final String? billingPinCode;
  final String? billingCountry;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingState;
  final String? shippingPinCode;
  final String? shippingCountry;
  final String? description;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  CompanyCard({
    super.key,
    this.id,
    this.accountOwner,
    this.companyName,
    this.companySource,
    this.email,
    this.companyNumber,
    this.companyType,
    this.companyCategory,
    this.companyRevenue,
    this.phoneCode,
    this.phoneNumber,
    this.website,
    this.billingAddress,
    this.billingCity,
    this.billingState,
    this.billingPinCode,
    this.billingCountry,
    this.shippingAddress,
    this.shippingCity,
    this.shippingState,
    this.shippingPinCode,
    this.shippingCountry,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            "H",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: white,
            ),
          ),
        ),
        title: Text(
          "doifnpdofignpsd ifg",

          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        subtitle: Text(
          "+91 95575649898",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textSecondary,
          ),
        ),
        trailing: FittedBox(
          child: Row(
            children: [
              CrmIc(iconPath: Ic.edit, color: success, onTap: onEdit),
              AppSpacing.horizontalSmall,
              CrmIc(iconPath: Ic.delete, color: error, onTap: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}
