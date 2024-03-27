import '/dataSource/localDataSource.dart';
import '/model/booking.dart';

class BookingRepository {
  final BookingDataSource _dataSource;
  BookingRepository(this._dataSource);

  Future<List<Booking>> getBookings() {
    // LocalDataSource로부터 데이터를 가져오는 로직
    return _dataSource.getBookings();
  }
}
