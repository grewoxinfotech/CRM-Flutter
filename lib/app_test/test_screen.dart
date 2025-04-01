import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CrmContainer(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CrmContainer(
                          width: 50,
                          height: 50,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade50,
                          alignment: Alignment.center,
                          child: Text(
                            "T",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Test123",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Company",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      height: 20,
                      indent: 10,
                      endIndent: 10,
                    ),
                    CrmContainer(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade50,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.email, size: 20),
                        ),
                        title: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text("abcd@gmail.com"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CrmContainer(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade50,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.phone_iphone_rounded, size: 20),
                        ),
                        title: Text(
                          "Phone",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text("+91 4568514520"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CrmContainer(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.location_on_rounded, size: 20),
                        ),
                        title: Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text("Surat ,Gujrat"),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      height: 20,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            tile1(
                              "Lead Value",
                              "15648/-",
                              Colors.green,
                              Icons.ac_unit_outlined,
                            ),
                            const SizedBox(height: 10),
                            tile1(
                              "Created",
                              "3/35/2025",
                              Colors.purple,
                              Icons.ac_unit_outlined,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            tile1(
                              "Interest Level",
                              "Hight",
                              Colors.red,
                              Icons.add,
                            ),
                            const SizedBox(height: 10),
                            tile1(
                              "Lead Mamber",
                              "45",
                              Colors.pink,
                              Icons.man_2_rounded,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      height: 20,
                      indent: 10,
                      endIndent: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            tile2("Source", "Phone", () {}),
                            const SizedBox(height: 10),
                            tile2("Category", "Manufacturing", () {}),
                          ],
                        ),
                        Column(
                          children: [
                            tile2("Stage", "Qualified", () {}),
                            const SizedBox(height: 10),
                            tile2("Status", "Cancelled", () {}),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // CrmBottomNavigationBar()
            ],
          ),
        ),
      ),
    );
  }
}

Widget tile1(String title, String subtitle, Color color, icon) {
  return CrmContainer(
    width: 150,
    height: 75,
    padding: const EdgeInsets.all(10),
    color: color.withOpacity(0.15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color.withOpacity(0.75),
              ),
            ),
            Icon(icon, color: color.withOpacity(0.75), size: 18),
          ],
        ),
        Divider(height: 10, color: color.withOpacity(0.2)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color.withOpacity(1),
          ),
        ),
      ],
    ),
  );
}

Widget tile2(String title, String subtitle, GestureTapCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      child: CrmContainer(
        padding: const EdgeInsets.all(10),
        width: 150,
        height: 80,
        color: Get.theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            Divider(
              height: 10,
              color: Get.theme.colorScheme.primary.withOpacity(0.25),
            ),
            Text(subtitle.toString(), style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    ),
  );
}

// //
//
//
