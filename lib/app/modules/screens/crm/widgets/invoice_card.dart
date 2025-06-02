import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/data/network/all/project/invoice/invoice_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceModel? invoice;

  const InvoiceCard({Key? key, this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: CrmIc(
                  icon: LucideIcons.receipt,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              CrmIc(icon: LucideIcons.moreVertical, color: AppColors.primary),
            ],
          ),
          CrmStatusCard(title: "N/A"),
        ],
      ),
    );
  }
}
