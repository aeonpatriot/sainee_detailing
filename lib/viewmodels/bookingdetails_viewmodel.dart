import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/book_service.dart';
import 'package:sainee_detailing/widget/custom_snackbar.dart';

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

  Future updateBookingStatus(
      {required BuildContext context,
      required String status,
      required dynamic setBookingList,
      required String failMessage}) async {
    bookingDetails.status = status;
    final Book? updatedBooking =
        await bookService.updateBookingStatus(bookingDetails);
    if (updatedBooking == null) {
      FailedSnackBar.show(
          context: context, message: 'Failed to confirm booking');
    } else {
      setBookingList();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  Future updateCustomerBookingStatus(
      {required BuildContext context,
      required String status,
      required void Function(String) setBookingList,
      required String userId}) async {
    bookingDetails.status = status;
    final Book? updatedBooking =
        await bookService.updateBookingStatus(bookingDetails);
    if (updatedBooking == null) {
      FailedSnackBar.show(
          context: context, message: 'Failed to cancel booking');
    } else {
      setBookingList(userId);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
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
