import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/data/network/system/country/controller/country_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/purchase/vendor/model/vendor_model.dart';
import '../views/vendor_detail_screen.dart';

class VendorCard extends StatelessWidget {
  final VendorData vendor;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const VendorCard({
    Key? key,
    required this.vendor,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  // Get first letter for avatar
  String getInitial() {
    if (vendor.name != null && vendor.name!.isNotEmpty) {
      return vendor.name!.substring(0, 1).toUpperCase();
    }
    return "?";
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>CountryController());
    final CountryController countryController = Get.find();
    return GestureDetector(
      onTap: () {
        Get.to(() => VendorDetailScreen(vendor: vendor));
      },
      child: CrmCard(
        padding: EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    getInitial(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Vendor Info
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // shrink to content
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Client ID Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              vendor.name ?? 'No Name',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (vendor.createdBy != null &&
                              vendor.createdBy!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                vendor.createdBy ?? 'No Client',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Contact Info Vertical
                      if (vendor.contact != null)...[
                        Obx(() {
                          countryController.getCountryById(vendor.phonecode ?? '');
                          final country = countryController.countryModel.firstWhereOrNull((element) => element.id == vendor.phonecode,);
                          return CommonWidget.buildText("${country?.phoneCode ?? ''} ${vendor.contact}", "Contact: ");
                        }),
                      const SizedBox(height: 6),
                        ],
                        // Text("Contact: +${vendor.phonecode} ${vendor.contact}"),
                      if (vendor.email != null)...[
                        CommonWidget.buildText(vendor.email ?? '', "Email: "),
                        // Text("Email: ${vendor.email}"),
                      // if (vendor.phonecode != null)
                      //   Text("Phone Code: ${vendor.phonecode}"),
                      const SizedBox(height: 6),
                      ],
                      if (vendor.taxNumber != null)...[
                        CommonWidget.buildText(vendor.taxNumber ?? '', "Tax Number: "),
                        // Text("Tax Number: ${vendor.taxNumber}"),
                      const SizedBox(height: 6),
],
                      // Address Vertical
                      // if (vendor.address != null && vendor.address!.isNotEmpty)
                      //   Text(
                      //     "Address: ${vendor.address}, ${vendor.city ?? ''}, ${vendor.state ?? ''}, ${vendor.country ?? ''} - ${vendor.zipcode ?? ''}",
                      //     style: TextStyle(color: Colors.grey[700]),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
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