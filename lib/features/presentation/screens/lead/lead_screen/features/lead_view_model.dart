import 'package:crm_flutter/features/presentation/screens/lead/widgets/lead_summery/lead_summary_view.dart';
import 'package:crm_flutter/features/presentation/screens/lead/widgets/leads/lead_view.dart';
import 'package:flutter/material.dart';

class LeadViewModel {
  final Widget? widget;

  const LeadViewModel({required this.widget});

  static List<LeadViewModel> getWidgets() {
    List<LeadViewModel> widgets = [];

    // leads horisontal box
    widgets.add(LeadViewModel(widget: LeadSummaryView()));

    // leads box
    widgets.add(LeadViewModel(widget: LeadView()));

    return widgets;
  }
}
