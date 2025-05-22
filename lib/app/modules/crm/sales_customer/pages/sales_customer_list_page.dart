import 'package:crm_flutter/app/data/network/sales_customer/controller/sales_customer_controller.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesCustomerListPage extends StatelessWidget {
  const SalesCustomerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SalesCustomerController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Customers'),
        leading: const CrmBackButton(),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.salesCustomers.length,
                itemBuilder: (context, index) {
                  final customer = controller.salesCustomers[index];
                  return _buildCustomerCard(customer);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/sales-customer/create'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCustomerCard(SalesCustomer customer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(customer.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact: ${customer.contact}'),
            if (customer.taxNumber != null)
              Text('GST: ${customer.taxNumber}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Get.toNamed('/sales-customer/edit/${customer.id}'),
        ),
        onTap: () => Get.toNamed('/sales-customer/view/${customer.id}'),
      ),
    );
  }
} 