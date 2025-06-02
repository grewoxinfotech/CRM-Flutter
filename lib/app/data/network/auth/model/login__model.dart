import 'package:crm_flutter/app/data/network/all/user_managemant/user_model.dart';

class LoginModel {
  final String? token;
  final UserModel? user;

  LoginModel({required this.token, required this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'tokan': token, 'usar': user!.toJson()};
  }
}
