import 'package:flutter/material.dart';
import 'package:flutter_first/component/number_row.dart';
import 'package:flutter_first/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({super.key, required this.maxNumber});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;


  @override
  void initState() {
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(
                maxNumber: maxNumber,
              ),
              _Footer(
                maxNumber: maxNumber,
                onSliderChanged: onSliderChanged,
                onSavePressed: onSavePressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val){
    setState(() {
      maxNumber = val;
    });
  }

  void onSavePressed(){
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({super.key, required this.maxNumber});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt(),),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onSavePressed;

  const _Footer(
      {super.key,
      required this.maxNumber,
      required this.onSliderChanged,
      required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            min: 1000,
            max: 10000,
            value: maxNumber,
            onChanged: onSliderChanged),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
            onPressed: onSavePressed,
            child: Text("저장"))
      ],
    );
  }
}
