import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/models/other/timeslot.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/services/book_service.dart';
import 'package:sainee_detailing/widget/custom_snackbar.dart';

class BookingViewModel extends ChangeNotifier {
  final bookService = service<BookService>();

  Future<dynamic>? timeAvailability;
  late Service chosenService;
  Address? chosenAddress;
  Car? chosenCar;
  String? chosenDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? chosenTimeSlot;
  late List<Address> addressList;
  late List<Car> carList;
  int paymentMethod = 0;
  bool showPaymentMethod = false;
  bool isPastFirstTimeSlot = false;
  bool isPastSecondTimeSlot = false;

  final List<TimeSlot> smallTimeSlot = [
    TimeSlot('1', '9AM - 3PM', ''),
    TimeSlot('2', '3PM - 9PM', '')
  ];

  setPaymentMethod(value) {
    paymentMethod = value;
    notifyListeners();
  }

  setShowPaymentMethod(value) {
    showPaymentMethod = value;
    notifyListeners();
  }

  setTimeAvailabilityData(String date) {
    timeAvailability = checkTimeAvailability(date);
    notifyListeners();
  }

  Future testFutureData() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
        () => [
              {'id': '1', 'slot': '1', 'date': '2022-06-18'}
            ]);
  }

  String setServicePrice({required String carType, required Service service}) {
    switch (carType) {
      case 'Small':
        return service.smallPrice!;
      case 'Medium':
        return service.mediumPrice!;
      case 'Large':
        return service.largePrice!;
      case 'SUV':
        return service.suvPrice!;
      case 'MPV':
        return service.mpvPrice!;
      default:
        return '';
    }
  }

  String setPaymentType() {
    switch (paymentMethod) {
      case 1:
        return 'ASOL';
      case 2:
        return 'ASCS';
      default:
        return '';
    }
  }

  Future getUserAddresses(String userId) async {
    final List<Address>? addresses = await bookService.getUserAddress(userId);
    if (addresses == null) {
      print('get failed');
    } else {
      print('get success');
      addressList = addresses;
      return addresses;
    }
  }

  Future getUserCars(String userId) async {
    final List<Car>? cars = await bookService.getUserCars(userId);
    if (cars == null) {
      print('get failed');
    } else {
      print('get success');
      carList = cars;
      return cars;
    }
  }

  void setBookingDetails({required Service service}) {
    chosenService = service;
    chosenAddress = setDefaultAddress();
    chosenCar = setDefaultCar();
  }

  Address setDefaultAddress() {
    dynamic defaultAddress;
    for (Address address in addressList) {
      if (address.defaultAddress == 'Y') {
        defaultAddress = address;
      }
    }
    return defaultAddress;
  }

  Car setDefaultCar() {
    dynamic defaultCar;
    for (Car car in carList) {
      if (car.defaultCar == 'Y') {
        defaultCar = car;
      }
    }
    return defaultCar;
  }

  Book newBook(String userId) {
    final Book book = Book(
        userId: userId,
        carId: chosenCar?.id,
        addressId: chosenAddress?.id,
        serviceId: chosenService.id,
        date: chosenDate,
        timeSlot: chosenTimeSlot,
        totalPrice:
            setServicePrice(carType: chosenCar!.type!, service: chosenService),
        paymentType: setPaymentType());
    return book;
  }

  void createNewBooking(
      {required BuildContext context, required String userId}) async {
    final Book? book = await bookService.createNewBooking(newBook(userId));
    if (book == null) {
      FailedSnackBar.show(
          context: context,
          message: 'Failed to add your booking, Please try again.');
    } else {
      SuccessSnackBar.show(
          context: context, message: 'Your booking success, Thank you');
      Navigator.of(context).pop();
      resetBookingDetails();
    }
  }

  Future checkTimeAvailability(String date) async {
    final List<Book>? bookings = await bookService.getTimeAvailability(date);
    if (bookings == null) {
    } else {
      if (bookings.isEmpty) {
      } else {}
    }
    return bookings;
  }

  void setPastFirstTimeSlot(DateTime chosenDateTime) {
    final double firstTimeSlot = 9.toDouble() + (0.toDouble() / 60); //9.00AM
    final double currentTime = DateTime.now().hour.toDouble() +
        (DateTime.now().minute.toDouble() / 60);
    if (isChosenDateToday(chosenDateTime)) {
      if (currentTime > firstTimeSlot) {
        isPastFirstTimeSlot = true;
      } else {
        isPastFirstTimeSlot = false;
      }
    } else {
      isPastFirstTimeSlot = false;
    }
  }

  void setPastSecondTimeSlot(DateTime chosenDateTime) {
    final double secondTimeSlot = 15.toDouble() + (0.toDouble() / 60); //3.00PM
    final double currentTime = DateTime.now().hour.toDouble() +
        (DateTime.now().minute.toDouble() / 60);
    if (isChosenDateToday(chosenDateTime)) {
      if (currentTime > secondTimeSlot) {
        isPastSecondTimeSlot = true;
      } else {
        isPastSecondTimeSlot = false;
      }
    } else {
      isPastSecondTimeSlot = false;
    }
  }

  bool isChosenDateToday(DateTime chosenDateTime) {
    final DateTime pickedDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(chosenDateTime));
    final DateTime todayDate =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    if (pickedDateTime.compareTo(todayDate) == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isAllBookingDetailsChosen() {
    final bool isAddressChosen = chosenAddress != null ? true : false;
    final bool isCarChosen = chosenCar != null ? true : false;
    final bool isDateChosen = chosenDate != null ? true : false;
    final bool isTimeSlotChosen = chosenTimeSlot != null ? true : false;
    final bool isPaymentChosen = paymentMethod != 0 ? true : false;
    if (isAddressChosen &&
        isCarChosen &&
        isDateChosen &&
        isTimeSlotChosen &&
        isPaymentChosen) {
      return true;
    } else {
      return false;
    }
  }

  void setPastTimeSlot(DateTime pickedDateTime) {
    setPastFirstTimeSlot(pickedDateTime);
    setPastSecondTimeSlot(pickedDateTime);
  }

  void resetBookingDetails() {
    paymentMethod = 0;
    showPaymentMethod = false;
  }
}
