import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteTile extends StatelessWidget {
  final String? url;
  final String? title;
  final String? subTitle;
  final String? role;

  final GestureTapCallback? onTap;

  const NoteTile({
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
        height: 145,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 135,
              height: 135,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text(
                          "05:45am",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "05/06/2025",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CrmIcon(iconPath: ICRes.edit, color: Colors.green),
                        const SizedBox(width: 5),
                        CrmIcon(iconPath: ICRes.delete, color: Colors.red),
                      ],
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
