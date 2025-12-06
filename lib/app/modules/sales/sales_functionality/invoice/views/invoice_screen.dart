import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/sales_invoice/pages/sales_invoice_edit_page.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/database/storage/secure_storage_service.dart';
import '../../../../../data/network/sales_invoice/controller/sales_invoice_controller.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../crm/crm_functionality/deal/controllers/deal_controller.dart';
import '../../../../crm/crm_functionality/sales_invoice/pages/sales_invoice_create_page.dart';
import '../../../../project/invoice/widget/invoice_card.dart';

import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';

import '../../customer/controllers/customer_controller.dart';
import '../bindings/invoice_binding.dart';
import '../controllers/invoice_controller.dart';
import 'invoice_detail_screen.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key});

  String? customerId;

  /// Asynchronously retrieves the customer ID from secure storage
  /// and assigns it to the `customerId` variable.
  ///
  /// This function accesses user data stored securely,
  /// extracting the user ID and converting it to a string.
  /// If the user data is null, `customerId` will also be null.
  void _showDeleteInvoiceDialog(
      BuildContext context,
      SalesInvoiceController controller,
      String invoiceId,
      String dealId,
      ) {
    showDialog(
      context: context,
      builder:
          (context) => CrmDeleteDialog(
        entityType: "invoice",
        onConfirm: () async {
          final success = await controller.deleteInvoice(invoiceId);
          if (success) {
            // Refresh the invoices list
            await controller.fetchInvoicesForDeal(dealId);
          }
          // Get.back();
        },
      ),
    );
  }

  void getCustomerId() async {
    customerId = (await SecureStorage.getUserData())?.id;
  }

  @override
  Widget build(BuildContext context) {
    getCustomerId();
    Get.lazyPut<InvoiceController>(() => InvoiceController());
    final InvoiceController controller = Get.find();
    Get.lazyPut<SalesInvoiceController>(() => SalesInvoiceController());
    final SalesInvoiceController salesInvoiceController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Invoices")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => SalesInvoiceCreatePage(dealId: customerId!),
            binding: InvoiceBinding(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder(
        future: controller.loadInitial(),
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
            return Obx(() {
              Get.lazyPut<CustomerController>(() => CustomerController());
              final CustomerController customerController = Get.find();

              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No Invoices found."));
              }

              final invoices =
                  controller.items
                      .where((item) => item.relatedId == customerId!)
                      .toList();

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
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final invoice = invoices[index];
                        final CustomerData? customer = customerController.items
                            .firstWhereOrNull(
                              (element) => element.id == invoice.customer,
                            );

                        print("=>${invoice.currency}");
                        return InvoiceCard(
                          id: invoice.id,
                          leadTitle: invoice.salesInvoiceNumber,
                          firstName: salesInvoiceController.getCustomerName(
                            invoice.customer!,
                          ),
                          leadValue: invoice.total.toString(),
                          currency: invoice.currency,
                          status: invoice.paymentStatus,
                          createdAt: invoice.issueDate.toString(),
                          dueDate: invoice.dueDate.toString(),
                          pendingAmount: invoice.pendingAmount?.toString(),
                          onDelete:
                              () => _showDeleteInvoiceDialog(
                            context,
                            salesInvoiceController,
                            invoice.id!,
                            customer!.id!,
                          ),
                          onEdit:
                              () => Get.to(
                                () => SalesInvoiceEditPage(
                                  invoice: invoice,
                                  dealId: customer!.id!,
                                ),
                              ),
                          onTap:
                              () => Get.to(
                                () => InvoiceDetailScreen(
                                  invoice: invoice,
                                  customer: customer,
                                ),
                              ),
                        );
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
            });
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
