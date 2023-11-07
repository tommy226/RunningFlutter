import 'package:flutter/material.dart';
import 'package:flutter_first/screen/navigation/layout/main_layout.dart';
import 'package:flutter_first/screen/navigation/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({super.key, this.number});

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "Route One", children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(456);
        },
        child: Text("Pop $number"),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => RouteTwoScreen(),
                settings: RouteSettings(arguments: 789)));
          },
          child: Text("push"))
    ]);
  }
}
