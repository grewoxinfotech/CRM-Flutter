import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadOverviewInformation extends StatelessWidget {
  const LeadOverviewInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CrmContainer(
            color: Colors.green.shade50,
            child: ListTile(
              leading: CrmContainer(
                width: 40,
                height: 40,
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(14),
                child: Icon(Icons.price_change_rounded, color: Colors.white),
              ),
              title: Text(
                "LEAD VALUE",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade600,
                ),
              ),
              subtitle: Text(
                "465,462,168,416",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CrmContainer(
            color: Colors.yellow.shade50,
            child: ListTile(
              leading: CrmContainer(
                width: 40,
                height: 40,
                color: Colors.yellow.shade600,
                borderRadius: BorderRadius.circular(14),
                child: Icon(Icons.speed_rounded, color: Colors.white),
              ),
              title: Text(
                "INTEREST LEVEL",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.yellow.shade600,
                ),
              ),
              subtitle: Text(
                "Medium Interest",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow.shade600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CrmContainer(
            color: Colors.blue.shade50,
            child: ListTile(
              leading: CrmContainer(
                width: 40,
                height: 40,
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(14),
                child: Icon(Icons.date_range_rounded, color: Colors.white),
              ),
              title: Text(
                "CREATED",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue.shade600,
                ),
              ),
              subtitle: Text(
                "3/30/2025",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CrmContainer(
            color: Colors.red.shade50,
            child: ListTile(
              leading: CrmContainer(
                width: 40,
                height: 40,
                color: Colors.red.shade600,
                borderRadius: BorderRadius.circular(14),
                child: Icon(Icons.man_2_rounded, color: Colors.white),
              ),
              title: Text(
                "LEAD MEMBERS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade600,
                ),
              ),
              subtitle: Text(
                "125",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
