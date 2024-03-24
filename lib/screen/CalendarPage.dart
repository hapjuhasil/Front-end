import 'package:flutter/material.dart';
import '/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//캘린더페이지
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarState();
}

class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    this.notes,
  });

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? notes;
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

  @override
  Object? convertAppointmentToObject(
      Object? customData, Appointment appointment) {
    return Meeting(
      eventName: appointment.subject,
      from: appointment.startTime,
      to: appointment.endTime,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
    ) as Object?;
  }
}

class CalendarState extends State<CalendarPage> {
  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';
  Color? _headerColor, _viewHeaderColor, _calendarColor;

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
      eventName: '홍대 오렌지',
      from: startTime,
      to: endTime,
      background: const Color(0xFF3974FD),
      isAllDay: false,
    ));
    meetings.add(Meeting(
      eventName: '건대 오렌지', // 'eventName' 매개변수에 대한 인자를 추가합니다.
      from: startTime,
      to: endTime,
      background: const Color(0xFFFDBE01),
      isAllDay: false,
    ));
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
          onTap: calendarTapped,
        ));
  }

  void calendarTapped(CalendarTapDetails details) {
    // 선택된 날짜를 가져옵니다.
    final DateTime selectedDate = details.date!;

    // 선택된 날짜의 약속들을 필터링합니다.
    final List<Meeting> selectedAppointments = _getDataSource()
        .where((Meeting meeting) =>
            meeting.from.day == selectedDate.day &&
            meeting.from.month == selectedDate.month &&
            meeting.from.year == selectedDate.year)
        .toList();

    // 약속 이름만 나열하는 대화상자를 표시합니다.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: selectedAppointments
                .map((meeting) => Text(meeting.eventName))
                .toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
