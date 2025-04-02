import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadTile extends StatelessWidget {
  final String claint_name;
  final String company_name;
  final String amount;
  final String source;
  final String status;
  final Color status_color;
  final String date;
  final GestureTapCallback? onTap;

  //
  // final String? id ;
  // final String? leadTitle ;
  // final String? leadStage ;
  // final String? currency ;
  // final String? leadValue ;
  // final String? firstName ;
  // final String? lastName ;
  // final String? phoneCode ;
  // final String? telephone ;
  // final String? email ;
  // final String? assigned ;
  // final String? lead_members ;
  // final String? source ;
  // final String? category ;
  // final String? files ;
  // final String? status ;
  // final String? tag ;
  // final String? company_name ;
  // final String? client_id ;
  // final String? created_by ;
  // final String? updated_by ;
  // final String? createdAt ;
  // final String? updatedAt ;
  //
  // const LeadTile({
  //   required this.id,
  //   required this.leadTitle,
  //   required this.leadStage,
  //   required this.currency,
  //   required this.leadValue,
  //   required this.firstName,
  //   required this.lastName,
  //   required this.phoneCode,
  //   required this.telephone,
  //   required this.email,
  //   required this.assigned,
  //   required this.lead_members,
  //   required this.source,
  //   required this.category,
  //   required this.files,
  //   required this.status,
  //   required this.tag,
  //   required this.company_name,
  //   required this.client_id,
  //   required this.created_by,
  //   required this.updated_by,
  //   required this.createdAt,
  //   required this.updatedAt,
  // });

  const LeadTile({
    super.key,
    this.onTap,
    required this.claint_name,
    required this.company_name,
    required this.amount,
    required this.source,
    required this.status,
    required this.status_color,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmContainer(
        width: 500,
        height: 125,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 80,
              decoration: BoxDecoration(
                color: status_color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            claint_name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            company_name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            amount.toString() + ".00",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            source.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: status_color,
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              status.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: status_color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            color: status_color,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            date.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
