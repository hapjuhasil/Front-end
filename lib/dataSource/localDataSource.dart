import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import '/model/booking.dart';

class BookingDataSource extends CalendarDataSource {
  BookingDataSource(List<Booking> source) {
    appointments = source;
  }

  Future<List<Booking>> getBookings() async {
    final List<Booking> bookings = [
      Booking(
        eventName: '홍대 오렌지',
        from: DateTime.now(),
        to: DateTime.now().add(Duration(hours: 2)),
        background: Color.fromARGB(255, 67, 120, 255),
        isAllDay: false,
      ),
      Booking(
        eventName: '건대 오렌지',
        from: DateTime.now(),
        to: DateTime.now().add(Duration(hours: 2)),
        background: Colors.orange,
        isAllDay: false,
      ),
    ];
    return bookings;
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
    return Booking(
      eventName: appointment.subject,
      from: appointment.startTime,
      to: appointment.endTime,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
    ) as Object?;
  }
}
