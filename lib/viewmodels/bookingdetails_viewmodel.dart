import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/book_service.dart';

class BookingDetailsViewModel extends ChangeNotifier {
  final bookService = service<BookService>();

  final String bookingStatus = 'PENDING';

  Future<List<dynamic>>? futureAllBookingDetails;

  late Book bookingDetails;

  setFutureAllBookingDetails(
      {required String userId,
      required String carId,
      required String addressId}) {
    futureAllBookingDetails = getAllBookingDetails(
        userId: userId, carId: carId, addressId: addressId);
    notifyListeners();
  }

  Future<List<dynamic>> getAllBookingDetails(
      {required String userId,
      required String carId,
      required String addressId}) {
    return Future.wait([
      getUserById(userId),
      getCarById(carId),
      getAddressById(addressId),
    ]);
  }

  Future getUserById(String userId) async {
    final User? user = await bookService.getUserById(userId);
    if (user == null) {
      return [];
    }
    return user;
  }

  Future getCarById(String carId) async {
    final Car? car = await bookService.getCarById(carId);
    if (car == null) {
      return [];
    }
    return car;
  }

  Future getAddressById(String addressId) async {
    final Address? address = await bookService.getAddressById(addressId);
    if (address == null) {
      return [];
    }
    return address;
  }

  String formatPaymentMethod(String paymentMethod) {
    switch (paymentMethod) {
      case 'ASOL':
        return 'Pay online after service';
      case 'ASCS':
        return 'Pay cash after service';
      default:
        return '';
    }
  }

  String formatTimeSlot(String slotNumber) {
    switch (slotNumber) {
      case '1':
        return '9AM-3PM';
      case '2':
        return '3PM-9PM';
      default:
        return '';
    }
  }

  String formatDate(String date) {
    List<String> format = date.split('-');
    final formattedDate = '${format[2]}-${format[1]}-${format[0]}';
    return formattedDate;
  }
}