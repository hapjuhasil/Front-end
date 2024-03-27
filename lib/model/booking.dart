import 'package:flutter/material.dart';

class Booking {
  Booking({
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
