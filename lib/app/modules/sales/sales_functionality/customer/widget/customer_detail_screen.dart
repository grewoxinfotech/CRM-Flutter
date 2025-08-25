import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/widget/address_detail_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/widget/customer_overview_card.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/ic_res.dart';
import '../../../../../data/network/sales/customer/model/customer_model.dart';
import '../../../../../widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import '../../../../../widgets/bar/tab_bar/model/tab_bar_model.dart';
import '../controllers/customer_controller.dart';

class CustomerDetailScreen extends StatefulWidget {
  final CustomerData customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen>
    with SingleTickerProviderStateMixin {
  final customerController = Get.put(CustomerController());
  CustomerData? customer;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    customer = widget.customer;
    _loadCustomer();
  }

  Future<void> _loadCustomer() async {
    final updated = await customerController.getCustomerById(
      widget.customer.id!,
    );
    if (mounted) {
      setState(() {
        customer = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.put(TabBarController());
    final customerController = Get.put(CustomerController());

    return Scaffold(
      appBar: AppBar(
        title: Text(customer?.name ?? "Customer Detail"),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Billing Address"),
            TabBarModel(iconPath: ICRes.attach, label: "Shipping Address"),
          ],
        ),
      ),
      body: Obx(() {
        if (customerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (customerController.error.isNotEmpty) {
          return Center(child: Text(customerController.error.value));
        }
        if (customer == null) {
          return const Center(child: Text("Customer not found"));
        }

        List<Widget> widgets = [
          _buildOverviewTab(customer!),
          _buildAddressTab(customer!.billingAddress, "Billing"),
          _buildShippingTab(customer!.shippingAddress, "Shipping"),
        ];

        return PageView.builder(
          itemCount: widgets.length,
          controller: tabBarController.pageController,
          onPageChanged: tabBarController.onPageChanged,
          itemBuilder: (context, i) => widgets[i],
        );
      }),
    );
  }

  Widget _buildOverviewTab(CustomerData c) {
    return CustomerOverviewCard(
      id: c.customerNumber ?? "-",
      firstName: c.name ?? "-",
      phone: c.contact ?? "-",
      email: c.email ?? "-",
      phonCodePrefix: c.phonecode,
      companyName: c.company ?? "-",
      address: Address.formatAddress(customer!.billingAddress),
      onDelete:
          () => Get.dialog(
            CrmDeleteDialog(
              onConfirm: () async {
                final success = await customerController.deleteCustomer(c.id!);
                if (success) {
                  CrmSnackBar.showAwesomeSnackbar(
                    title: 'Success',
                    message: "${c.name} is Deleted Successfully",
                    contentType: ContentType.success,
                  );
                  Get.back();
                }
              },
              entityType: c.name,
            ),
          ),
    );
  }

  Widget _buildAddressTab(Address? address, String label) {
    if (address == null) {
      return Center(child: Text("$label address not available"));
    }
    return AddressDetailScreen(address: address);
  }

  Widget _buildShippingTab(Address? address, String label) {
    if (address == null) {
      return Center(child: Text("$label address not available"));
    }
    return AddressDetailScreen(address: address);
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
