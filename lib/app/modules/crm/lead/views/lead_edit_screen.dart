// import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LeadEditScreen extends StatelessWidget {
//   final String leadId;
//   LeadEditScreen({required this.leadId});
//
//   @override
//   Widget build(BuildContext context) {
//     final LeadController leadController = Get.put(LeadController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Lead"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: leadController.leadTitleController,
//               decoration: InputDecoration(labelText: 'Lead Title'),
//             ),
//             TextField(
//               controller: leadController.interestLevelController,
//               decoration: InputDecoration(labelText: 'Interest Level'),
//             ),
//             TextField(
//               controller: leadController.leadValueController,
//               decoration: InputDecoration(labelText: 'Lead Value'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => leadController.updateLead(leadId),
//               child: Text("Update Lead"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
