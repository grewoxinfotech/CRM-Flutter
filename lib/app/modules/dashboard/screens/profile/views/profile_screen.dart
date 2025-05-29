import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppMargin.medium),
        child: Column(
          children: [
            CrmCard(
              width: double.infinity,
              padding: const EdgeInsets.all(AppPadding.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CrmCard(
                        borderRadius: BorderRadius.circular(1000),
                        boxShadow: [],
                        color: AppColors.primary.withAlpha(30),
                        padding: EdgeInsets.all(5),
                        child: CrmCard(
                          width: 60,
                          height: 60,
                          gradient: RadialGradient(
                            colors: [AppColors.primary.withAlpha(150), AppColors.primary],
                          ),
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: [],
                          alignment: Alignment.center,
                          child: Text(
                            "R",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.horizontalMedium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "raiser2",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            "@raiser2",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color:AppColors. divider, height: AppPadding.large),
                  _tile(title: "Email", subTitle: "raiser2@yopmail.com"),
                  _tile(title: "Phone", subTitle: "1234567890"),
                  _tile(title: "Address", subTitle: "Sutar, Gujrat, India"),
                  AppSpacing.verticalSmall,
                  CrmCard(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.small),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: AppPadding.small / 2,
                      horizontal: AppPadding.small,
                    ),
                    child: Row(
                      children: [
                        CrmIc(icon: LucideIcons.briefcase, color: AppColors.white),
                        AppSpacing.horizontalSmall,
                        Text(
                          "Company",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _tile extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _tile({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          "$title : ",
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "$subTitle",
          style: TextStyle(
            fontSize: 12,
            color:AppColors. textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
