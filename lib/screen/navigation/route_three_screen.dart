import 'package:flutter/material.dart';
import 'package:flutter_first/screen/navigation/layout/main_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;
    return MainLayout(
        title: "route three", children: [
          Text("$argument"),
      ElevatedButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: Text("pop"))
    ]
    );
  }
}
