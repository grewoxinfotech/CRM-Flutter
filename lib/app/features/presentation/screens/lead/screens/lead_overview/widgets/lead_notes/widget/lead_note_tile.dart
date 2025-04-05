import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadNoteTile extends StatelessWidget {
  final String? url;
  final String? title;
  final String? subTitle;
  final String? role;

  final GestureTapCallback? onTap;

  const LeadNoteTile({
    super.key,
    this.onTap,
    this.url,
    this.title,
    this.subTitle,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    bool isUser;
    return GestureDetector(
      onTap: onTap,
      child: CrmContainer(
        height: 70,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                image:
                (url != null)
                    ? DecorationImage(image: NetworkImage(url.toString()))
                    : null,
              ),
              alignment: Alignment.center,
              child:
              (url == null)
                  ? Text(
                title![0].toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              )
                  : null,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CrmContainer(
                color: Get.theme.colorScheme.background,
                borderRadius: BorderRadius.circular(10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subTitle.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        role.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
