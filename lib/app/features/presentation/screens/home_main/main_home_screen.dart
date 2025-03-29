import 'package:crm_flutter/app/features/presentation/screens/home/home_screen.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CrmAppBar(),
            SliverToBoxAdapter(
              child: const Column(
                children: [
                  const SizedBox(height: 20),
                  const HomeScreen(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
