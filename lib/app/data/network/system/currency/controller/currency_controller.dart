import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/data/network/system/currency/model/currency_model.dart';
import 'package:crm_flutter/app/data/network/system/currency/service/currency_service.dart';
import 'package:get/get.dart';

import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class CurrencyController extends GetxController {
  final CurrencyService currencyService = CurrencyService();
  final RxList<CurrencyModel> currencyModel = <CurrencyModel>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> getCurrency() async {
    try {
      isLoading.value = true;
      final data = await currencyService.getCurrencies();
      if (data.isNotEmpty) {
        currencyModel.assignAll(data); // ✅ this is correct
        print("CurrencyData:----$currencyModel");
      } else {
        currencyModel.clear();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch Currency: ${e.toString()}',
        contentType: ContentType.failure,
      );
      currencyModel.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<CurrencyModel?> getCurrencyById(String currencyId) async {
    try {
      isLoading.value = true;
      final data = await currencyService.getCurrencies();
      // Case-insensitive comparison
      final currency = data.firstWhereOrNull(
        (c) => c.id.toLowerCase() == currencyId.toLowerCase().trim(),
      );

      if (currency == null) {
        // CrmSnackBar.showAwesomeSnackbar(
        //   title: 'Not Found',
        //   message: 'Currency with ID "$currencyId" not found.',
        //   contentType: ContentType.warning,
        // );
      }

      return currency;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch currency: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Currency name by ID or name
  String getCurrencyName(String currencyIdOrCode) {
    if (currencyModel.isEmpty) {
      print("id:-------$currencyIdOrCode");
      return currencyIdOrCode;
    } // Fallback to code if no data

    // First try to find by ID
    final currencyById = currencyModel.firstWhereOrNull(
      (c) => c.id.equalsIgnoreCase(currencyIdOrCode),
    );

    // Then try to find by currency code
    final currencyByCode = currencyModel.firstWhereOrNull(
      (c) => c.currencyCode.equalsIgnoreCase(currencyIdOrCode),
    );

    // Return the most appropriate name
    return currencyById?.currencyName ??
        currencyByCode?.currencyName ??
        currencyIdOrCode; // Fallback to input if not found
  }
}

// Helper extension for case-insensitive comparison
extension StringExtensions on String {
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();
}
