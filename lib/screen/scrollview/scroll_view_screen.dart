import 'package:flutter/material.dart';
import 'package:flutter_first/layout/main_layout.dart';
import 'package:flutter_first/screen/scrollview/single_child_scroll_view_screen.dart';

class ScrollHomeScreen extends StatelessWidget {
  const ScrollHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: "home",
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SingleChildScrollViewScreen())
                );
              }, child: Text("singleChildScrollViewScreen"))
            ],
          ),
        ));
  }
}
