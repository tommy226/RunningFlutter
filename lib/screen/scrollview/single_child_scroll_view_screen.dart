import 'package:flutter/material.dart';
import 'package:flutter_first/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  const SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: "singlechildScrollview",
        body: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ));
  }
}
