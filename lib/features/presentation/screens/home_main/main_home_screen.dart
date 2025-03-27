import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CrmAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
