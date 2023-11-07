import 'dart:math';

import 'package:flutter/material.dart';

class FutureBuilderScreen extends StatefulWidget {
  const FutureBuilderScreen({super.key});

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: streamNumbers(),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "StreamBuilder",
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      "Constate : ${snapshot.connectionState}",
                      style: textStyle,
                    ),
                    Text("Data : ${snapshot.data}"),
                    Text("Error : ${snapshot.error}"),
                    ElevatedButton(onPressed:(){
                      setState(() {

                      });
                    }, child: Text("Setstate"))
                  ],
                );
              }),
        ));
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));
    final random = Random();

    // throw Exception("에러");
    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async*{
    for (int i =0; i<10; i++){
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
