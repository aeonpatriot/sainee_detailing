import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/services/rest.dart';

class BookService {
  final restService = service<Rest>();

  Future<Book?> createNewBooking(Book newBook) async {
    final json = await restService.postWithToken('booking', data: newBook);
    if (json == null) {
      return null;
    }
    Book book = Book.fromJson(json);
    return book;
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
}
