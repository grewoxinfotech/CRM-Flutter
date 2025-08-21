import 'package:crm_flutter/app/care/constants/color_res.dart';
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
      appBar: AppBar(title: Text(role.roleName ?? "Role Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role Info
            Text(
              role.roleName ?? "Unnamed Role",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            if (role.createdBy != null && role.createdBy!.isNotEmpty)
              Text(
                role.createdBy!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            const SizedBox(height: 20),

            const Text(
              "Permissions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Divider(),

            // Permissions Table
            Expanded(
              child:
                  role.permissions != null && role.permissions!.isNotEmpty
                      ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
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
                            rows:
                                role.permissions!.entries.map((entry) {
                                  final module = getReadableName(entry.key);

                                  final perms =
                                      entry.value
                                          .expand((e) => e.permissions ?? [])
                                          .toList();

                                  print('[DEBUG]=> $perms');

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(module)),
                                      DataCell(
                                        Row(
                                          children:
                                              perms
                                                  .map(
                                                    (perm) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 18,
                                                          ),
                                                      child: Tooltip(
                                                        message: perm,
                                                        child: Icon(
                                                          getActionIcon(perm),
                                                          size: 20,
                                                          color:
                                                              ColorRes.primary,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
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

/// Converts API keys into human-readable names
String getReadableName(String key) {
  switch (key) {
    case "extra-hrm-role":
      return "Role";
    case "dashboards-deal":
      return "Deal";
    case "dashboards-lead":
      return "Lead";
    case "dashboards-task":
      return "Task";
    case "extra-hrm-branch":
      return "Branch";
    case "extra-users-list":
      return "Users List";
    case "extra-hrm-holiday":
      return "Holiday";
    case "extra-hrm-meeting":
      return "Meeting";
    case "extra-hrm-payroll":
      return "Payroll";
    case "extra-hrm-document":
      return "Document";
    case "extra-hrm-employee":
      return "Employee";
    case "dashboards-proposal":
      return "Proposal";
    case "extra-hrm-department":
      return "Department";
    case "extra-hrm-designation":
      return "Designation";
    case "dashboards-systemsetup":
      return "System Setup";
    case "extra-hrm-announcement":
      return "Announcement";
    case "extra-hrm-jobs-joblist":
      return "Job List";
    case "dashboards-TaskCalendar":
      return "Task Calendar";
    case "dashboards-project-list":
      return "Project List";
    case "extra-hrm-trainingSetup":
      return "Training Setup";
    case "extra-users-client-list":
      return "Client List";
    case "dashboards-sales-invoice":
      return "Sales Invoice";
    case "dashboards-sales-revenue":
      return "Sales Revenue";
    case "extra-hrm-jobs-interview":
      return "Job Interview";
    case "dashboards-sales-customer":
      return "Sales Customer";
    case "extra-hrm-leave-leavelist":
      return "Leave List";
    case "dashboards-purchase-vendor":
      return "Purchase Vendor";
    case "dashboards-purchase-billing":
      return "Purchase Billing";
    case "extra-hrm-jobs-jobcandidate":
      return "Job Candidate";
    case "extra-hrm-jobs-jobonbording":
      return "Job Onboarding";
    case "dashboards-sales-credit-notes":
      return "Credit Notes";
    case "extra-hrm-jobs-jobapplication":
      return "Job Application";
    case "extra-hrm-jobs-jobofferletter":
      return "Job Offer Letter";
    case "dashboards-purchase-debit-note":
      return "Debit Note";
    case "dashboards-sales-product-services":
      return "Product & Services";
    case "extra-hrm-attendance-attendancelist":
      return "Attendance List";
    default:
      return key; // fallback: return original if not matched
  }
}

/// Returns appropriate icon for each action
IconData getActionIcon(String action) {
  switch (action.toLowerCase()) {
    case "view":
      return Icons.visibility;
    case "create":
      return Icons.add_rounded;
    case "update":
      return Icons.edit_rounded;
    case "delete":
      return Icons.delete_rounded;
    default:
      return Icons.help_outline; // fallback icon
  }
}

// /// Optional: gives each action a color
// Color _getActionColor(String action) {
//   switch (action.toLowerCase()) {
//     case "view":
//       return Colors.blue;
//     case "create":
//       return Colors.green;
//     case "update":
//       return Colors.orange;
//     case "delete":
//       return Colors.red;
//     default:
//       return Colors.grey;
//   }
// }
