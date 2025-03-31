import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadOverviewWidgetBasicDetails extends StatelessWidget {
  const LeadOverviewWidgetBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CrmContainer(
                width: 50,
                height: 50,
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade50,
                alignment: Alignment.center,
                child: Text("T",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Test123",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Company",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 20,
            indent: 10,
            endIndent: 10,
          ),
          CrmContainer(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade50,
            child: ListTile(
              leading: CircleAvatar(
                radius: 15,
                child: Icon(Icons.email, size: 20),
              ),
              title: Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              subtitle: Text("abcd@gmail.com"),
            ),
          ),
          const SizedBox(height: 10),
          CrmContainer(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.shade50,
            child: ListTile(
              leading: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: Icon(Icons.phone_iphone_rounded, size: 20,),
              ),
              title: Text(
                "Phone",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              subtitle: Text("+91 4568514520"),
            ),
          ),
          const SizedBox(height: 10),
          CrmContainer(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
            child: ListTile(
              leading: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                child: Icon(Icons.location_on_rounded, size: 20),
              ),
              title: Text(
                "Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              subtitle: Text("Surat ,Gujrat"),
            ),
          ),
        ],
      ),
    );
  }
}
