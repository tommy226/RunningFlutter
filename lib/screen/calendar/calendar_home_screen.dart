import 'package:flutter/material.dart';
import 'package:flutter_first/component/calendar.dart';
import 'package:flutter_first/component/schedule_bottom_sheet.dart';
import 'package:flutter_first/component/schedule_card.dart';
import 'package:flutter_first/component/today_banner.dart';
import 'package:flutter_first/constant/color.dart';
import 'package:flutter_first/datebase/drift_database.dart';
import 'package:flutter_first/model/schedule_with_color.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHomeScreen extends StatefulWidget {
  const CalendarHomeScreen({super.key});

  @override
  State<CalendarHomeScreen> createState() => _CalendarHomeScreenState();
}

class _CalendarHomeScreenState extends State<CalendarHomeScreen> {
  DateTime selectedDay =
  DateTime.utc(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected: OnDaySelected,
              selectedDay: selectedDay,
              focusedDay: focusedDay,
            ),
            SizedBox(
              height: 8,
            ),
            TodayBanner(selectedDay: selectedDay),
            SizedBox(
              height: 8,
            ),
            _ScheduleList(selectedDate: selectedDay,)
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true, context: context, builder: (_) {
          return ScheduleBottomSheet(selectedDate: selectedDay,);
        });
      },
      child: Icon(Icons.add),
    );
  }

  OnDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("스케줄이 없습니다."),
                  );
                }

                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    final scheduleWithcolor = snapshot.data![index];

                    return Dismissible(
                      key: ObjectKey(scheduleWithcolor.schedule.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (DismissDirection direction) {
                        GetIt.I<LocalDatabase>().removeSchedule(
                            scheduleWithcolor.schedule.id);
                      },
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return ScheduleBottomSheet(
                                  selectedDate: selectedDate,
                                  scheduleId: scheduleWithcolor.schedule.id);
                              });
                        },
                        child: ScheduleCard(
                            startTime: scheduleWithcolor.schedule.startTime,
                            endTime: scheduleWithcolor.schedule.endTime,
                            content: scheduleWithcolor.schedule.content,
                            color: Color(int.parse(
                                "FF${scheduleWithcolor.categoryColor.hexCode}",
                                radix: 16))),
                      ),
                    );
                  },
                );
              }
          )),
    );
  }
}
