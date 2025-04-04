import 'package:crm_flutter/app/features/presentation/screens/auth/screens/login/login_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/home_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_overview/lead_overview_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/lead_screen.dart';
import 'package:crm_flutter/app_test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ScreenModel> screens = [];
    screens = ScreenModel.getScreen();
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(title: Text("All screen")),
      body: SingleChildScrollView(
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: screens.length,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                leading: Text("${i+1}.",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),
                title: Text(screens[i].title,style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),
                trailing: Text(screens[i].suntitle,style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                ),),
                onTap: () {
                  Get.to(screens[i].widget);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserModel {
  String email;
  String password;

  UserModel({required this.email, required this.password});
}

class ScreenModel {
  final String title;
  final String suntitle;
  final Widget widget;

  ScreenModel({
    required this.title,
    required this.suntitle,
    required this.widget,
  });

  static List<ScreenModel> getScreen (){
    return [
      ScreenModel(title: "Test", suntitle: "Test", widget: TestScreen()),
      ScreenModel(title: "Login", suntitle: "Auth", widget: LoginScreen()),
      ScreenModel(title: "Home", suntitle: "Home", widget: HomeScreen()),
      ScreenModel(title: "Lead", suntitle: "Lead", widget: LeadScreen()),
      ScreenModel(title: "Lead Add", suntitle: "lead", widget: LeadsAddScreen()),
      ScreenModel(title: "Lead Overview", suntitle: "lead", widget: LeadOverviewScreen(leadId: "aKH5RLo3mdHWPbUAjUNikpZ")),
    ];
  }
}
