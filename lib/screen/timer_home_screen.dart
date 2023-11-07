import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimerHomeScreen extends StatefulWidget {
  const TimerHomeScreen({super.key});

  @override
  State<TimerHomeScreen> createState() => _TimerHomeScreenState();
}

class _TimerHomeScreenState extends State<TimerHomeScreen> {
  Timer? timer;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int currentPage = pageController.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }
      pageController.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5]
            .map((e) => Image.asset(
          "asset/img/image_$e.jpeg",
          fit: BoxFit.cover,
        ))
            .toList(),
      ),
    );
  }
}