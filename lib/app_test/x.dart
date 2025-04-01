// CrmContainer(
// padding: const EdgeInsets.all(10),
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.only(bottom: 20, top: 10),
// child: CrmHeadline(title: "Grewox"),
// ),
// GridView.builder(
// itemCount: 6,
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// mainAxisSpacing: 10,
// crossAxisSpacing: 10,
// mainAxisExtent: 200,
// ),
// itemBuilder:
// (context, index) => GestureDetector(
// onTap: () {},
// child: Container(
// decoration: BoxDecoration(
// color: Theme.of(
// context,
// ).colorScheme.outline.withOpacity(0.3),
// borderRadius: BorderRadius.circular(24),
// ),
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// CircleAvatar(
// child: Image.asset(
// 'assets/images/logo.png',
// height: 50,
// ),
// ),
// Column(
// children: [
// Text(
// "Shawn Stone",
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.w700,
// ),
// ),
// Text(
// "UI/UX designer",
// style: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.w600,
// ),
// ),
// ],
// ),
// GestureDetector(
// onTap: () {},
// child: Container(
// padding: EdgeInsets.symmetric(
// horizontal: 5,
// ),
// decoration: BoxDecoration(
// border: Border.all(
// color: Colors.grey,
// width: 2,
// ),
// borderRadius: BorderRadius.circular(10),
// ),
// child: Text(
// "Middle",
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.w400,
// color: Colors.grey,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// //
// // const SizedBox(height: 30),
// // CrmHeadline(title: "Projects"),
// // Container(
// //   width: size.width,
// //   child: ListView.builder(
// //     shrinkWrap: true,
// //     physics: NeverScrollableScrollPhysics(),
// //     itemCount: 3,
// //     itemBuilder: (context, index) {
// //       return CrmContainer(
// //         padding: const EdgeInsets.all(20),
// //         margin: const EdgeInsets.symmetric(
// //           horizontal: 20,
// //           vertical: 10,
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Project ID & Name
// //             Row(
// //               children: [
// //                 CircleAvatar(
// //                   backgroundColor: Colors.purple[100],
// //                   child: Icon(
// //                     Icons.health_and_safety,
// //                     color: Colors.purple,
// //                   ),
// //                 ),
// //                 SizedBox(width: 10),
// //                 Column(
// //                   crossAxisAlignment:
// //                       CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "PN0001265",
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color:
// //                             ColorResources.TEXT_SECONDARY,
// //                       ),
// //                     ),
// //                     SizedBox(height: 4),
// //                     Text(
// //                       "Medical App (iOS native)",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 10),
// //
// //             // Created Date & Priority
// //             Row(
// //               children: [
// //                 Icon(
// //                   Icons.calendar_today,
// //                   size: 16,
// //                   color: ColorResources.TEXT_SECONDARY,
// //                 ),
// //                 SizedBox(width: 5),
// //                 Text(
// //                   "Created Sep 12, 2020",
// //                   style: TextStyle(
// //                     color: ColorResources.TEXT_SECONDARY,
// //                   ),
// //                 ),
// //                 Spacer(),
// //                 Icon(
// //                   Icons.arrow_upward,
// //                   color: Colors.orange,
// //                   size: 16,
// //                 ),
// //                 Text(
// //                   " Medium",
// //                   style: TextStyle(
// //                     color: Colors.orange,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //
// //             Divider(),
// //
// //             // Project Data
// //             Text(
// //               "Project Data",
// //               style: TextStyle(fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 5),
// //
// //             Row(
// //               mainAxisAlignment:
// //                   MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Column(
// //                   crossAxisAlignment:
// //                       CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "All tasks",
// //                       style: TextStyle(
// //                         color:
// //                             ColorResources.TEXT_SECONDARY,
// //                       ),
// //                     ),
// //                     Text(
// //                       "34",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 Column(
// //                   crossAxisAlignment:
// //                       CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Active tasks",
// //                       style: TextStyle(
// //                         color:
// //                             ColorResources.TEXT_SECONDARY,
// //                       ),
// //                     ),
// //                     Text(
// //                       "13",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 Column(
// //                   crossAxisAlignment:
// //                       CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Assignees",
// //                       style: TextStyle(
// //                         color:
// //                             ColorResources.TEXT_SECONDARY,
// //                       ),
// //                     ),
// //                     Row(
// //                       children: [
// //                         CircleAvatar(
// //                           radius: 12,
// //                           backgroundImage: NetworkImage(
// //                             "https://randomuser.me/api/portraits/men/1.jpg",
// //                           ),
// //                         ),
// //                         SizedBox(width: 4),
// //                         CircleAvatar(
// //                           radius: 12,
// //                           backgroundImage: NetworkImage(
// //                             "https://randomuser.me/api/portraits/women/2.jpg",
// //                           ),
// //                         ),
// //                         SizedBox(width: 4),
// //                         CircleAvatar(
// //                           radius: 12,
// //                           backgroundImage: NetworkImage(
// //                             "https://randomuser.me/api/portraits/men/3.jpg",
// //                           ),
// //                         ),
// //                         SizedBox(width: 4),
// //                         CircleAvatar(
// //                           radius: 12,
// //                           backgroundColor: Colors.blue,
// //                           child: Text(
// //                             "+2",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 10,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   ),
// // ),
// // const SizedBox(height: 10),
// // Padding(
// //   padding: const EdgeInsets.symmetric(
// //     horizontal: 30.0,
// //     vertical: 10,
// //   ),
// //   child: CrmHeadline(title: "Projects"),
// // ),
