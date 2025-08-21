import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/network/hrm/hrm_system/role/role_model.dart';

class RoleDetailScreen extends StatelessWidget {
  final RoleData role;

  const RoleDetailScreen({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("[DEBUG] RoleDetailScreen: ${role.toJson()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(role.roleName ?? "Role Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role Info
            Text(
              role.roleName ?? "Unnamed Role",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            if (role.createdBy != null && role.createdBy!.isNotEmpty)
              Text(
                role.createdBy!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            const SizedBox(height: 20),

            const Text(
              "Permissions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(),

            // Permissions Table
            Expanded(
              child: role.permissions != null && role.permissions!.isNotEmpty
                  ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        "Module",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Allowed Permissions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: role.permissions!.entries.map((entry) {
                    final module = entry.key;
                    final perms = entry.value.join(", ");
                    return DataRow(
                      cells: [
                        DataCell(Text(module)),
                        DataCell(Text(perms)),
                      ],
                    );
                  }).toList(),
                ),
              )
                  : const Center(
                child: Text(
                  "No permissions assigned.",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
