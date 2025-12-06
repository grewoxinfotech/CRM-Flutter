
import 'package:get/get.dart';
import '../../../data/network/access/access_service.dart';

class AccessController extends GetxController {
  late AccessService _accessService;

  // Reactive map for UI or other observers
  final RxMap<String, List<String>> permissions = <String, List<String>>{}.obs;

  /// Initialize the controller with role data
  void init(Map<String, dynamic> roleData) {
    _accessService = AccessService(roleData);
    permissions.value = _accessService.allPermissions;
  }

  @override
  void onInit() {
    super.onInit();
    // Do not initialize _accessService here since role data is not yet available
  }

  /// Check if user can perform an action in a module
  bool can(String module, String action) {
    if (_accessService == null) return false;
    final canAccess = _accessService.can(module, action);
    return canAccess;
  }

  /// Get all allowed actions for a module
  List<String> allowedActions(String module) {
    if (_accessService == null) return [];
    return _accessService.allowedActions(module);
  }
}
