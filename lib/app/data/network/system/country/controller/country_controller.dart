import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/data/network/system/country/model/country_model.dart';
import 'package:crm_flutter/app/data/network/system/country/service/country_service.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final CountryService countryService = CountryService();
  final RxList<CountryModel> countryModel = <CountryModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCountries();
  }

  Future<void> getCountries() async {
    try {
      isLoading.value = true;
      final data = await countryService.getCountries();
      if (data.isNotEmpty) {
        countryModel.assignAll(data); // ✅ Assign list to observable
        print("CountryData:----$countryModel");
      } else {
        countryModel.clear();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch Countries: ${e.toString()}',
        contentType: ContentType.failure,
      );
      countryModel.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<CountryModel?> getCountryById(String countryId) async {
    try {
      print("id:-------$countryId");
      isLoading.value = true;
      final data = await countryService.getCountries();
      // Case-insensitive comparison
      final country = data.firstWhereOrNull(
        (c) => c.id.toLowerCase() == countryId.toLowerCase().trim(),
      );
      print("CountryData:----$country");



      return country;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch country: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Country name by ID or code
  String getCountryName(String countryIdOrCode) {
    if (countryModel.isEmpty) {
      print("id:-------$countryIdOrCode");
      return countryIdOrCode;
    } // Fallback if no data loaded

    // First try to find by ID
    final countryById = countryModel.firstWhereOrNull(
      (c) => c.id.equalsIgnoreCase(countryIdOrCode),
    );

    // Then try to find by country code
    final countryByCode = countryModel.firstWhereOrNull(
      (c) => c.countryCode.equalsIgnoreCase(countryIdOrCode),
    );

    // Return the most appropriate name
    return countryById?.countryName ??
        countryByCode?.countryName ??
        countryIdOrCode; // Fallback to input if not found
  }
}

// ✅ Helper extension for case-insensitive comparison
extension StringExtensions on String {
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();
}
