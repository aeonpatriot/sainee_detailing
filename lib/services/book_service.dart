import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/models/other/dashboard.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/rest.dart';

class BookService {
  final restService = service<Rest>();

  Future<Dashboard?> getDashboardData() async {
    final json = await restService.getWithToken('booking/dashboard');
    if (json == null) {
      return null;
    }
    return Dashboard.fromJson(json);
  }

  Future<List<Book>?> getAllBooking() async {
    final json = await restService.getWithToken('booking') as List?;
    if (json == null) {
      return [];
    }
    List<Book> bookingList = json.map((book) => Book.fromJson(book)).toList();
    return bookingList;
  }

  Future<Book?> createNewBooking(Book newBook) async {
    final json = await restService.postWithToken('booking', data: newBook);
    if (json == null) {
      return null;
    }
    Book book = Book.fromJson(json);
    return book;
  }

  Future<Book?> updateBookingStatus(Book newBook) async {
    print('booking/status/${newBook.id}');
    final json = await restService.postWithToken('booking/status/${newBook.id}',
        data: newBook);

    if (json == null) {
      return null;
    }
    return Book.fromJson(json);
  }

  Future<List<Book>?> getTimeAvailability(String date) async {
    final json = await restService.get('booking/time/$date') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? bookings = json.map((book) => Book.fromJson(book)).toList();
    return bookings;
  }

  Future<List<Car>?> getUserCars(String userId) async {
    final json = await restService.get('cars/user/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Car>? cars = json.map((car) => Car.fromJson(car)).toList();
    return cars;
  }

  Future<List<Address>?> getUserAddress(String userId) async {
    final json = await restService.get('addresses/user/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Address>? addresses =
        json.map((address) => Address.fromJson(address)).toList();
    return addresses;
  }

  Future<List<Book>?> getUserNewBookingList(String userId) async {
    final json =
        await restService.getWithToken('booking/new/list/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? customerNewBookingList =
        json.map((book) => Book.fromJson(book)).toList();
    return customerNewBookingList;
  }

  Future<List<Book>?> getUserConfirmedBookingList(String userId) async {
    final json = await restService
        .getWithToken('booking/confirmed/list/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? customerConfirmedBookingList =
        json.map((book) => Book.fromJson(book)).toList();
    return customerConfirmedBookingList;
  }

  Future<List<Book>?> getUserHistoryBookingList(String userId) async {
    final json =
        await restService.getWithToken('booking/history/list/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? customerHistoryBookingList =
        json.map((book) => Book.fromJson(book)).toList();
    return customerHistoryBookingList;
  }

  Future<List<Book>?> getAllNewBookingList() async {
    final json = await restService.getWithToken('booking/new/list') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? newBookingList =
        json.map((book) => Book.fromJson(book)).toList();
    return newBookingList;
  }

  Future<List<Book>?> getAllConfirmedBookingList() async {
    final json =
        await restService.getWithToken('booking/confirmed/list') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? confirmedBookingList =
        json.map((book) => Book.fromJson(book)).toList();
    return confirmedBookingList;
  }

  Future<List<Book>?> getAllHistoryBookingList() async {
    final json =
        await restService.getWithToken('booking/history/list') as List?;
    if (json == null) {
      return null;
    }
    List<Book>? historyBookingList =
        json.map((book) => Book.fromJson(book)).toList();
    return historyBookingList;
  }

  Future<User?> getUserById(String userId) async {
    final json = await restService.getWithToken('user/details/$userId');
    print(json);
    if (json == null) {
      return null;
    }
    return User.fromJson(json);
  }

  Future<Car?> getCarById(String carId) async {
    final json = await restService.get('cars/$carId');
    if (json == null) {
      return null;
    }
    return Car.fromJson(json);
  }

  Future<Address?> getAddressById(String addresssId) async {
    final json = await restService.get('addresses/address/$addresssId');
    if (json == null) {
      return null;
    }
    return Address.fromJson(json);
  }
}
