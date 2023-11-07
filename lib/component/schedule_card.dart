import 'package:flutter/material.dart';
import 'package:flutter_first/constant/color.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.content,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: PRIMARY_COLOR
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(startTime: startTime, endTime: endTime),
              SizedBox(
                width: 16,
              ),
              _Content(content: content),
              SizedBox(width: 16,),
              _Category(color: color)
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({super.key, required this.startTime, required this.endTime});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.w600, color: PRIMARY_COLOR, fontSize: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${startTime.toString().padLeft(2, "0")}:00",
          style: textStyle,
        ),
        Text(
          "${endTime.toString().padLeft(2, "0")}:00",
          style: textStyle.copyWith(fontSize: 10),
        )
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content));
  }
}

class _Category extends StatelessWidget {
  final Color color;

  const _Category({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: 16,
      height: 16,
    );
  }
}
