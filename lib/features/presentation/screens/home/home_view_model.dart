import 'package:crm_flutter/features/presentation/widgets/widget/attendance/attendance_widget.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/date_container_widget.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/functionalities/functionalities_widgets.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/wellcome_text.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  final Widget? widget;

  const HomeViewModel({required this.widget});

  static List<HomeViewModel> getWidgets() {
    List<HomeViewModel> widgets = [];

    // wellcome text
    widgets.add(HomeViewModel(widget: WellcomeText()));

    // date lap box
    widgets.add(HomeViewModel(widget: DateContainerWidget(fd: "20/dd/205", ld: "21/dd/2006")));

    // attandens box
    widgets.add(HomeViewModel(widget: AttendanceWidget()));

    // finction box
    widgets.add(HomeViewModel(widget: FunctionalitiesWidgets()));

    return widgets;
  }
}
