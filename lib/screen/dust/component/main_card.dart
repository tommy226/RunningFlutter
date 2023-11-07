import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class MainCard extends StatelessWidget {
  final Widget child;

  const MainCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: LIGHT_COLOR,
        child: child);
  }
}
