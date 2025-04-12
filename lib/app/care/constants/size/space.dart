import 'package:flutter/cupertino.dart';

class Space extends StatelessWidget {
  final double? size;

  const Space({super.key, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size);
  }
}
