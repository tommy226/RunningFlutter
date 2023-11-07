import 'package:flutter/material.dart';
import 'package:flutter_first/screen/navigation/layout/main_layout.dart';
import 'package:flutter_first/screen/navigation/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;

    return MainLayout(title: "Route two", children: [
      Text(
        "$argument",
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Pop"),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/three", arguments: 999);
          },
          child: Text("push Named")),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/three");
          },
          child: Text("pushReplacementNamed")),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
             "/three", (route) => route.settings.name == "/");
          },
          child: Text("pushAndRemoveUntil"))
    ]);
  }
}
