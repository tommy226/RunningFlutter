import 'package:flutter/material.dart';
import 'package:flutter_first/screen/navigation/layout/main_layout.dart';
import 'package:flutter_first/screen/navigation/route_one_screen.dart';

class NavigationHomeScreen extends StatelessWidget {
  const NavigationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: MainLayout(title: "HomeScreen", children: [
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RouteOneScreen(number: 123,)));
            print(result);
          },
          child: Text("Push"),
        ),
      ]),
    );
  }
}
