import 'package:crm_flutter/app/data/network/user/role/model/roles_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';

class RoleController extends GetxController {
  final RolesService _rolesService = Get.find<RolesService>();

  final RxList<RoleModel> roles = <RoleModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      isLoading.value = true;
      error.value = '';

      final rolesList = await _rolesService.getRoles();
      roles.assignAll(rolesList);



      if (roles.isEmpty) {
        error.value = 'No roles found';
      }
    } catch (e) {
      error.value = e.toString();
      print("Error loading roles: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load roles: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get role name by ID
  String getRoleName(String roleId) {
    try {
      print("Looking for role with ID: $roleId in ${roles.length} roles");

      if (roleId.isEmpty) {
        print("Role ID is empty");
        return 'No Role';
      }

      final role = roles.firstWhereOrNull((role) => role.id == roleId);

      if (role == null) {
        print("Role not found for ID: $roleId");
        // If role not found, try to fetch roles again
        if (roles.isEmpty) {
          print("Roles list is empty, fetching roles");
          fetchRoles();
        }
        return 'Unknown Role';
      }

      print("Found role: ${role.roleName} for ID: $roleId");
      return role.roleName;
    } catch (e) {
      print("Error getting role name: $e");
      return 'Unknown Role';
    }
  }

  bool hasPermission(
    String roleId,
    String permissionKey,
    String permissionType,
  ) {
    try {
      if (roleId.isEmpty) return false;

      final role = roles.firstWhereOrNull((role) => role.id == roleId);
      if (role == null) return false;

      final permissionList = role.permissions[permissionKey];
      if (permissionList == null) return false;

      return permissionList.any(
        (permission) => permission.permissions.contains(permissionType),
      );
    } catch (e) {
      return false;
    }
  }

  // Get roles filtered by client ID
  List<RoleModel> getRolesByClientId(String clientId) {
    return roles.where((role) => role.clientId == clientId).toList();
  }

  // Ensure roles are loaded
  Future<bool> ensureRolesLoaded() async {
    try {
      if (roles.isEmpty) {
        await fetchRoles();
      }
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    }
  }
}
