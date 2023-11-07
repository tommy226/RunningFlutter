import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_first/component/number_row.dart';
import 'package:flutter_first/constant/color.dart';
import 'package:flutter_first/screen/random/random_setting_screen.dart';

class RandomHomeScreen extends StatefulWidget {
  const RandomHomeScreen({super.key});

  @override
  State<RandomHomeScreen> createState() => _RandomHomeScreenState();
}

class _RandomHomeScreenState extends State<RandomHomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(onPressed: onSettingsPop,),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomNumber)
            ],
          ),
        ),
      ),
    );
  }

  void onRandomNumber() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  void onSettingsPop () async {
    final result = await Navigator.of(context).push<int>(
        MaterialPageRoute(builder: (BuildContext context){
          return SettingScreen(maxNumber: maxNumber,);
        })
    );

    if(result != null){
      setState(() {
        maxNumber = result;
        onRandomNumber();
      });
    }
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "랜덤 숫자 생성기",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            )),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({super.key, required this.randomNumbers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: randomNumbers
              .asMap()
              .entries
              .map((x) =>
              Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16),
                child: NumberRow(number : x.value),
              ))
              .toList(),
        ));
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
            onPressed: onPressed,
            child: Text("생성하기")));
  }
}

