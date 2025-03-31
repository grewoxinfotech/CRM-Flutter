import 'package:crm_flutter/app/features/presentation/screens/home/home_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/lead_overview_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/lead_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
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
                title: Text(screens[i].title),
                subtitle: Text(screens[i].suntitle),
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
      ScreenModel(title: "Test Screen", suntitle: "test", widget: TestScreen()),
      ScreenModel(title: "Home Screen", suntitle: "home", widget: HomeScreen()),
      ScreenModel(title: "Lead Screen", suntitle: "leads", widget: LeadScreen()),
      ScreenModel(title: "Lead Add Screen", suntitle: "leads", widget: LeadsAddScreen()),
      ScreenModel(title: "Lead Over View Screen", suntitle: "leads", widget: LeadOverviewScreen()),
    ];
  }
}
