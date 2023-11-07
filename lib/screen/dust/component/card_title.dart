import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class CardTitle extends StatelessWidget {
  final String title;

  const CardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: DARK_COLOR,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ));
  }
}
