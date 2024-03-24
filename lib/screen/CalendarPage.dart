import 'package:flutter/material.dart';
import '/const/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//캘린더페이지
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarState();
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class CalendarState extends State<CalendarPage> {
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('스케줄'),
          elevation: 0,
        ),
        body: SfCalendar(
          view: CalendarView.month,
          cellBorderColor: Colors.white,
          viewHeaderHeight: 53,
          todayHighlightColor: purple_100,
          headerHeight: 50,
          headerStyle: CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          headerDateFormat: 'yyyy.MM',
          showNavigationArrow: true,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          monthCellBuilder:
              (BuildContext buildContext, MonthCellDetails details) {
            final DateTime date = details.date;
            final DateTime visibleMonth =
                details.visibleDates.firstWhere((d) => d.day == 1);
            final bool isWeekend = date.weekday == DateTime.saturday ||
                date.weekday == DateTime.sunday;
            final bool isCurrentMonth = date.month == visibleMonth.month;

            Color textColor = Colors.black; // 기본 글씨색

            // 현재 달인지 확인
            if (!isCurrentMonth) {
              textColor = Color(0xFF141414); // 이전달이나 다음달 날짜 색상
            } else if (isWeekend) {
              // 주말에 대한 색상 설정
              textColor =
                  date.weekday == DateTime.saturday ? purple_80 : Colors.red;
            }

            return Container(
              alignment: Alignment.topCenter,
              child: Text(
                date.day.toString(),
                style: TextStyle(color: textColor),
              ),
            );
          },
        ));
  }
}
