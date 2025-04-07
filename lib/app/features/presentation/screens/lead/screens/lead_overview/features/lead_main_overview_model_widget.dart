import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_file/features/lead_file_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_members/features/lead_member_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_notes/features/lead_note_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/features/lead_overview_model_view.dart';
import 'package:flutter/cupertino.dart';

class LeadMainOverviewModelWidget {
  final Widget widget;

  LeadMainOverviewModelWidget({required this.widget});

  static List<LeadMainOverviewModelWidget> getwidgets() {
    return [
      LeadMainOverviewModelWidget(widget: LeadMemberModelView()),
      LeadMainOverviewModelWidget(widget: LeadFileModelView()),
      LeadMainOverviewModelWidget(widget: LeadNoteModelView()),
    ];
  }
}
