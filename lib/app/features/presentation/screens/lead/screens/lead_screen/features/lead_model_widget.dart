import 'package:crm_flutter/app/features/presentation/screens/lead/widgets/lead_summery/lead_summary_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/widgets/leads/lead_view.dart';
import 'package:flutter/material.dart';

class LeadModelWidget {
  final Widget? widget;

  const LeadModelWidget({required this.widget});

  static List<LeadModelWidget> getWidgets() {
    List<LeadModelWidget> widgets = [];

    // leads horisontal box
    widgets.add(LeadModelWidget(widget: LeadSummaryView()));

    // leads box
    widgets.add(LeadModelWidget(widget: LeadView()));

    return widgets;
  }
}
