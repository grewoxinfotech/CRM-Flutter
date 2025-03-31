import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

final formkey = GlobalKey<FormState>();

String? email_validation(String email) => (email.isEmail)? "Enter your Email!" : (!GetUtils.isEmail(email)? "Enter Valide Email!" :null);
String? password_validation(String password) => (password.length == 0)? "Pleasw! Enter Your Password" : (password.length<8)? "Provide Valide Password!" : null;