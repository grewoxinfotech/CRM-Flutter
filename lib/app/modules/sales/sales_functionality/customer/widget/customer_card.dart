import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/color_res.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/sales/customer/model/customer_model.dart';
import 'customer_detail_screen.dart';

class CustomerCard extends StatelessWidget {
  final CustomerData customer;

  const CustomerCard({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CustomerDetailScreen(customer: customer));
      },
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Avatar or Placeholder
                CircleAvatar(
                    radius: 28,
                    backgroundColor: ColorRes.primary.withOpacity(0.2),

                  child: Text(
                    (customer.name?.substring(0, 1).capitalize ?? "?") ,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorRes.primary,
                    ),
                  )
                ),
                const SizedBox(width: 12),

                // Customer Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        customer.name ?? 'Unnamed Customer',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      // Email
                      if (customer.email != null && customer.email!.isNotEmpty)
                       CommonWidget.buildText(customer.email ?? '',"Email: "),
                        // Text(
                        //   customer.email!,
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.blueGrey,
                        //   ),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),

                      const SizedBox(height: 4),

                      // Phone
                      if (customer.contact != null &&
                          customer.contact!.isNotEmpty)
                        CommonWidget.buildText(customer.contact ?? '',"Contact: "),

                        // Text(
                        //   customer.contact!,
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.black87,
                        //   ),
                        // ),

                      // Optional Address
                      // if (customer.shippingAddress != null)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 6),
                      //     child: Text(
                      //       'Address: ${Address.formatAddress(customer.shippingAddress)}',
                      //       style: TextStyle(
                      //         fontSize: 13,
                      //         color: Colors.grey[700],
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
