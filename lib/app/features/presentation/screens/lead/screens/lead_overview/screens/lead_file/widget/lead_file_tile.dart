import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';

class LeadFileTile extends StatelessWidget {
  const LeadFileTile({super.key});

  @override
  Widget build(BuildContext context) {
    String url = "https://images.pexels.com/photos/31300173/pexels-photo-31300173/free-photo-of-vibrant-blue-poison-dart-frog-on-leaf.jpeg?auto=compress&cs=tinysrgb&w=600";

    return CrmContainer(
      margin: const EdgeInsets.all(15),
      height: 150,
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ".pdf",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Grewox",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          "PDF",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      CrmIcon(
                        iconPath: ICRes.delete,
                        color: Colors.red,
                        onTap: () {
                          print("Bhia Bhia");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
