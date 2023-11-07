import 'package:flutter/material.dart';

class TabBarHomeScreen extends StatelessWidget {
  const TabBarHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {}, child: Text("Basic Appbar TabBar Screen"))
        ],
      ),
    );
  }
}
