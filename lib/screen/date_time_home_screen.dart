import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateHomeScreen extends StatefulWidget {
  const DateHomeScreen({super.key});

  @override
  State<DateHomeScreen> createState() => _DateHomeScreenState();
}

class _DateHomeScreenState extends State<DateHomeScreen> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              _BottomPart()
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    final DateTime now = DateTime.now();

    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                maximumDate: DateTime(now.year, now.month, now.day),
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                  print(selectedDate);
                },
              ),
            ),
          );
        });
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({required this.selectedDate, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "U&I",
            style: TextStyle(
                color: Colors.white, fontFamily: "parisienne", fontSize: 80),
          ),
          Column(
            children: [
              Text(
                "우리 처음 만난 날",
                style: TextStyle(
                    color: Colors.white, fontFamily: "sunflower", fontSize: 30),
              ),
              Text(
                "${selectedDate.year}.${selectedDate.month}.${selectedDate.day}",
                style: TextStyle(
                    color: Colors.white, fontFamily: "sunflower", fontSize: 20),
              ),
            ],
          ),
          IconButton(
              onPressed: onPressed,
              iconSize: 60,
              icon: Icon(Icons.favorite, color: Colors.red)),
          Text(
            "D+${DateTime(now.year, now.month, now.day).difference(selectedDate).inDays + 1}",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "sunflower",
                fontSize: 50,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset("asset/img/middle_image.png"));
  }
}
