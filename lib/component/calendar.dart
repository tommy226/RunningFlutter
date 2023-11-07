import 'package:flutter/material.dart';
import 'package:flutter_first/constant/color.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;


  Calendar({super.key, required this.selectedDay, required this.focusedDay, required this.onDaySelected});

  final defaultBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6), color: Colors.grey[200]);

  final defaultTextStyle =
      TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "ko_KR",
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          defaultDecoration: defaultBoxDecoration,
          weekendDecoration: defaultBoxDecoration,
          selectedDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 1, color: PRIMARY_COLOR)),
          outsideDecoration: BoxDecoration(
            shape: BoxShape.rectangle
          ),
          defaultTextStyle: defaultTextStyle,
          weekendTextStyle: defaultTextStyle,
          selectedTextStyle: defaultTextStyle.copyWith(color: PRIMARY_COLOR)),
      onDaySelected: onDaySelected ,
      selectedDayPredicate: (day) {
        if (selectedDay == null) return false;

        return day.year == selectedDay?.year &&
            day.month == selectedDay?.month &&
            day.day == selectedDay?.day;
      },
    );
  }
}
