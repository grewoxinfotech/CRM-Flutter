import 'package:crm/features/presentation/widgets/widget/attendance/attendance_widget.dart';
import 'package:crm/features/presentation/widgets/widget/attendance/build_attendance_section.dart';
import 'package:crm/features/presentation/widgets/widget/build_wellcome_text.dart';
import 'package:crm/features/presentation/widgets/widget/functionalities/build_app_functions_section.dart';
import 'package:crm/features/presentation/widgets/widget_custem/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget space() => const SizedBox(height: 20);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          CrmAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space(), buildWelcomeText(),
                space(),
                AttendanceWidget(),
                space(),
                buildAppFunctionsSection(context),
                space(),
                // buildNearestEvents(context, size),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
