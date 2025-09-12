import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/controllers/customer_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/add_customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/widget/customer_card.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/add_product_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/customer_detail_screen.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();
    Get.lazyPut<CustomerController>(() => CustomerController());
    final CustomerController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Customers")),
      floatingActionButton:
          accessController.can(AccessModule.salesCustomer, AccessAction.create)
              ? FloatingActionButton(
                onPressed: () {
                  // Navigate to add product_service screen

                  Get.to(() => AddCustomerScreen());
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
      body: FutureBuilder(
        future: controller.loadInitial(), // Load initial data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CrmLoadingCircle());
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error:\n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {

              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge && metrics.pixels != 0) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: controller.refreshList,
                  child: ViewScreen(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final customer = controller.items[index];
                        return CustomerCard(customer: customer);
                      } else if (controller.isPaging.value) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              );

          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
