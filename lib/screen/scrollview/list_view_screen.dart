import 'package:flutter/material.dart';
import 'package:flutter_first/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "ListViewScreen", body: ListView(children: [

    ],));
  }
}
