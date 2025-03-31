import 'package:crm_flutter/app/features/presentation/screens/home/widget/attendance/attendance_widget.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/widget/date_container_widget.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/widget/functions/functions_widgets.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/widget/wellcome_text.dart';
import 'package:flutter/material.dart';

class HomeModelWidget {
  final Widget? widget;
  HomeModelWidget({required this.widget});

  static List<HomeModelWidget> getWidgets() {
    List<HomeModelWidget> widgets = [];

    // wellcome text
    widgets.add(HomeModelWidget(widget: WellcomeText()));

    // date lap box
    widgets.add(HomeModelWidget(widget: DateContainerWidget(fd: "20/dd/205", ld: "21/dd/2006")));

    // attandens box
    widgets.add(HomeModelWidget(widget: AttendanceWidget()));

    // finction box
    widgets.add(HomeModelWidget(widget: FunctionsWidgets()));

    return widgets;
  }
}