// import 'package:crm_flutter/app/features/presentation/screens/home/features/home_model_widget.dart';
// import 'package:flutter/material.dart';
//
// class HomeModelView extends StatelessWidget {
//   const HomeModelView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Widget space() => const SizedBox(height: 20);
//     final List<HomeModelWidget> widgets = HomeModelWidget.getWidgets();
//     return Container(
//       child: ListView.separated(
//         padding: EdgeInsets.symmetric(vertical: 20),
//         itemCount: widgets.length,
//         separatorBuilder: (context,i) => space(),
//         itemBuilder: (context, i) => widgets[i].widget,
//       ),
//     );
//   }
// }



import 'package:crm_flutter/app/features/presentation/screens/home/features/home_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/widgets/internet_status_widget.dart';
import 'package:flutter/material.dart';

class HomeModelView extends StatelessWidget {
  const HomeModelView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget space() => const SizedBox(height: 20);
    final List<HomeModelWidget> widgets = HomeModelWidget.getWidgets();

    return Column(
      children: [
        InternetStatusWidget(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: widgets.length,
            separatorBuilder: (context, i) => space(),
            itemBuilder: (context, i) => widgets[i].widget,
          ),
        ),
      ],
    );
  }
}

