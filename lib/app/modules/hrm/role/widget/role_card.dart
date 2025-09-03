import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/hrm_system/role/role_model.dart';

class RoleCard extends StatelessWidget {
  final RoleData role;

  const RoleCard({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              children: [
                // Icon Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.purple[100],
                    child: Icon(
                      Icons.security, // role icon
                      color: Colors.purple[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Role Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Role Name
                      Text(
                        role.roleName ?? 'Unnamed Role',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Role Description
                      if (role.createdBy != null && role.createdBy!.isNotEmpty)
                        Text(
                          role.createdBy!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),

                      // Permissions count
                      if (role.permissions != null && role.permissions!.isNotEmpty)
                        Text(
                          "Permissions: ${role.permissions!.length}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
