import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileTile extends StatelessWidget {
  final String? title;
  final String? subTitle;

  final String? fileFormat;

  final GestureTapCallback? deleteButton;
  final GestureTapCallback? onTap;

  const FileTile({
    super.key,
    this.title,
    this.subTitle,
    this.deleteButton,
    this.onTap,
    this.fileFormat,
  });

  @override
  Widget build(BuildContext context) {
    String url =
        "https://images.pexels.com/photos/31300173/pexels-photo-31300173/free-photo-of-vibrant-blue-poison-dart-frog-on-leaf.jpeg?auto=compress&cs=tinysrgb&w=600";

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(5),
        height: 145,
        child: Row(
          children: [
            Container(
              height: 135,
              width: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CrmCard(
                padding: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(10),
                color: Get.theme.colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subTitle.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
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
                            fileFormat.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        CrmIcon(
                          iconPath: ICRes.delete,
                          color: Colors.red,
                          onTap: deleteButton,
                        ),
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
