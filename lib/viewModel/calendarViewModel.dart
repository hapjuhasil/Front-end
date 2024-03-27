import 'package:flutter/material.dart';
import '/model/booking.dart';
import '/repository/bookingRepository.dart';

class CalendarViewModel with ChangeNotifier {
  late final BookingRepository _bookingRepository;
  List<Booking> _bookingList = List.empty(growable: true);
  List<Booking> get bookingList => _bookingList;

  CalendarViewModel(this._bookingRepository) {
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    _bookingList = await _bookingRepository.getBookings();
    notifyListeners(); // 데이터가 변경되었음을 알려 UI를 업데이트
  }
}
