import 'package:crm_flutter/features/presentation/widgets/widget/attendance/attendance_widget.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/build_wellcome_text.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/functionalities/functionalities_widgets.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_app_bar.dart';
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
                FunctionalitiesWidgets(),
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
