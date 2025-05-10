

import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';

class LoginModel {
  final String? token;
  final UserModel? user;

  LoginModel({this.token, this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user!.toJson()};
  }
}