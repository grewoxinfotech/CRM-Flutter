import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../care/constants/color_res.dart';
import '../../../care/constants/font_res.dart';
import '../../../data/network/super_admin/auth/model/user_model.dart';
import '../../../widgets/button/crm_button.dart';
import '../../../widgets/common/inputs/crm_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel? user;

  EditProfileScreen({super.key, this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final zipCtrl = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await SecureStorage.getUserData();
    if (user != null) {
      setState(() {
        firstNameCtrl.text = user.firstName ?? '';
        lastNameCtrl.text = user.lastName ?? '';
        usernameCtrl.text = user.username ?? '';
        emailCtrl.text = user.email ?? '';
        phoneCtrl.text = user.phone ?? '';
        addressCtrl.text = user.address ?? '';
        cityCtrl.text = user.city ?? '';
        stateCtrl.text = user.state ?? '';
        countryCtrl.text = user.country ?? '';
        zipCtrl.text = user.zipcode ?? '';
      });
    }
  }

  // Future<void> _saveProfile() async {
  //   if (!_formKey.currentState!.validate()) return;
  //
  //   setState(() => _loading = true);
  //   final user = await SecureStorage.getUserData();
  //   // Replace with your API call
  //   final updatedUser = user;
  //
  //   await SecureStorage.saveUserData(updatedUser); // 👈 add this in service
  //
  //   setState(() => _loading = false);
  //   Get.back(result: true);
  //   Get.snackbar(
  //     "Success",
  //     "Profile updated successfully",
  //     backgroundColor: Colors.green,
  //     colorText: Colors.white,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CrmTextField(
                title: "First Name",
                controller: firstNameCtrl,
                hintText: "Enter First Name",
              ),
              CrmTextField(
                title: "Last Name",
                controller: lastNameCtrl,
                hintText: "Enter Last Name",
              ),
              CrmTextField(
                title: "Username",
                controller: usernameCtrl,
                hintText: "Enter Username",
              ),
              CrmTextField(
                title: "Email",
                hintText: "Enter Email",
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              CrmTextField(
                hintText: "Enter Phone",
                title: "Phone",
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
              ),
              CrmTextField(
                title: "Address",
                controller: addressCtrl,
                hintText: "Enter Address",
              ),
              CrmTextField(
                title: "City",
                controller: cityCtrl,
                hintText: "Enter City",
              ),
              CrmTextField(
                title: "State",
                controller: stateCtrl,
                hintText: "Enter State",
              ),
              CrmTextField(
                title: "Country",
                controller: countryCtrl,
                hintText: "Enter Country",
              ),
              CrmTextField(
                title: "ZIP Code",
                hintText: "Enter ZIP Code",
                controller: zipCtrl,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                child: CrmButton(
                  // onTap: _loading ? null : _saveProfile,
                  onTap: () {},
                  title: _loading ? "Saving..." : "Save Changes",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
