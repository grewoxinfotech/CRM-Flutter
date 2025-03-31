import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsWidget extends StatelessWidget {

  EventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CrmHeadline(
          title: "Nearest Events",
          showViewAll: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
      ],
    );
  }
}
