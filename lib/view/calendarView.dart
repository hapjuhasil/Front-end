import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;
import '/const/colors.dart';
import '/model/booking.dart';
import '/viewModel/calendarViewModel.dart';
import '/dataSource/localDataSource.dart';
import '/repository/bookingRepository.dart';

class CalendarView extends StatelessWidget {
  List<Booking> testBookings = [];
  @override
  Widget build(BuildContext context) {
    // Provider를 사용하여 CalendarViewModel에 접근
    return ChangeNotifierProvider<CalendarViewModel>(
      create: (context) =>
          CalendarViewModel(BookingRepository(BookingDataSource(testBookings))),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('스케줄'),
          elevation: 0,
        ),
        body: Consumer<CalendarViewModel>(
          builder: (context, viewModel, child) {
            // ViewModel에서 데이터를 가져와서 DataSource를 생성합니다.
            BookingDataSource dataSource =
                BookingDataSource(viewModel.bookingList);
            return sf.SfCalendar(
                view: sf.CalendarView.month,
                cellBorderColor: Colors.white,
                viewHeaderHeight: 53,
                todayHighlightColor: purple_100,
                headerHeight: 50,
                headerStyle: sf.CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                headerDateFormat: 'yyyy.MM',
                showNavigationArrow: true,
                dataSource: dataSource, // ViewModel에서 가져온 데이터를 사용합니다.
                monthViewSettings: sf.MonthViewSettings(
                    appointmentDisplayMode:
                        sf.MonthAppointmentDisplayMode.appointment),
                monthCellBuilder:
                    (BuildContext buildContext, sf.MonthCellDetails details) {
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
                    textColor = date.weekday == DateTime.saturday
                        ? purple_80
                        : Colors.red;
                  }

                  return Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: textColor),
                    ),
                  );
                },
                onTap: (sf.CalendarTapDetails details) {
                  // 선택된 날짜를 가져옵니다.
                  final DateTime selectedDate = details.date!;

                  // 선택된 날짜의 약속들을 필터링합니다.
                  final List<Booking> selectedAppointments = viewModel
                      .bookingList
                      .where((Booking meeting) =>
                          meeting.from.day == selectedDate.day &&
                          meeting.from.month == selectedDate.month &&
                          meeting.from.year == selectedDate.year)
                      .toList();

                  // 약속 이름만 나열하는 대화상자를 표시합니다.
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:
                            Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
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
                });
          },
        ),
      ),
    );
  }
}
