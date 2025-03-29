import 'package:crm_flutter/app/features/presentation/screens/home/features/home_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          const CrmAppBar(),
          SliverToBoxAdapter(child: const HomeModelView()),
        ],
      ),
    );
  }
}
