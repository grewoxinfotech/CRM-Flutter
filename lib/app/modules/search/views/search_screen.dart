import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../care/constants/size_manager.dart';
import '../../../data/network/search/module_config.dart';
import '../../../widgets/common/inputs/crm_text_field.dart';
import '../controllers/search_controller.dart';

class SearchModuleScreen extends StatelessWidget {
  final ModuleController controller = Get.put(ModuleController());

  SearchModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Modules")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: CrmTextField(
              onChanged: controller.filterModules,
              hintText: 'Search Module...',
              suffixIcon: Icon(Icons.search_rounded),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.filteredModules.isEmpty) {
                return const Center(child: Text("No modules found"));
              }
              return ViewScreen(
                itemCount: controller.filteredModules.length,
                itemBuilder: (context, index) {
                  final module = controller.filteredModules[index];
                  // return ListTile(
                  //   title: Text(module.name),
                  //   subtitle: Text(module.tag),
                  //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  //   onTap: () => controller.openModule(module),
                  // );
                  return SearchModuleCard(
                    module: module,
                    onTap: () => controller.openModule(module),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SearchModuleCard extends StatelessWidget {
  final ModuleConfig module;
  final VoidCallback onTap;

  const SearchModuleCard({
    super.key,
    required this.module,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          children: [
            // leading icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: CrmIc(
                iconPath: ModuleIconMapper.getIcon(module.tag),
                color: ColorRes.primary,
                // color: Colors.blueAccent,
              ),
            ),

            const SizedBox(width: 16),

            // text column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    module.category,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
