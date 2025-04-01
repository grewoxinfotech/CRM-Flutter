import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';

class CrmBottomNavigationBar extends StatefulWidget {
  @override
  _CrmBottomNavigationBarState createState() => _CrmBottomNavigationBarState();
}

class _CrmBottomNavigationBarState extends State<CrmBottomNavigationBar> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> navItems = [
    {"icon": Icons.home, "label": "Home"},
    {"icon": Icons.notifications, "label": "Alerts"},
    {"icon": Icons.settings, "label": "Settings"},
    {"icon": Icons.person, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          bool isSelected = index == selectedIndex;
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: isSelected ? 40 : 40,
            width: isSelected ? 100 : 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: isSelected ? Get.theme.colorScheme.primary : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = index),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: isSelected
                        ? Get.theme.colorScheme.primary
                        : Colors.transparent,
                    child: Icon(navItems[index]["icon"],
                        size: isSelected ? 24 : 24,
                        color: isSelected
                            ? Colors.white
                            : Get.theme.colorScheme.primary,),
                  ),
                  if (isSelected)
                    Text(navItems[index]["label"],
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

