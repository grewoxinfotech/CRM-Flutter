import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';

class UsersController extends GetxController {
  final AllUsersService _usersService = AllUsersService();

  final RxList<User> users = <User>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      error.value = '';

      final usersList = await _usersService.getUsers();
      users.assignAll(usersList);
      print('Successfully loaded ${usersList.length} users');
      if (users.isEmpty) {
        error.value = 'No users found';
      }
    } catch (e) {
      error.value = e.toString();
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load users: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshList() async {
    await fetchUsers();
  }

  // User methods

  // Get user by ID
  User? getUserById(String userId) {
    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Get users by role ID
  List<User> getUsersByRoleId(String roleId) {
    return users.where((user) => user.roleId == roleId).toList();
  }

  // Get users by client ID
  Future<List<User>> getUsersByClientId(String clientId) async {
    await fetchUsers();
    print("Users by client ID: ${users.map((user) => user.clientId).toList()}");
    return await users
        .where((user) => user.clientId == clientId && user.employeeId == null)
        .toList();
  }

  // Get full name of a user
  String getUserFullName(String userId) {
    try {
      final user = users.firstWhere((user) => user.id == userId);
      final firstName = user.firstName ?? '';
      final lastName = user.lastName ?? '';

      if (firstName.isEmpty && lastName.isEmpty) {
        return user.username;
      }

      return '$firstName $lastName'.trim();
    } catch (e) {
      return 'Unknown User';
    }
  }

  // Get a list of all users as a map with id and username (useful for dropdowns)
  List<Map<String, String>> getUsersAsMap() {
    return users
        .map(
          (user) => {
            'id': user.id,
            'username': user.username,
            'fullName': '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
          },
        )
        .toList();
  }
}
