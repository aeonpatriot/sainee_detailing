import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/services/book_service.dart';

class BookingListViewModel extends ChangeNotifier {
  final bookService = service<BookService>();
  final controller = PageController(initialPage: 0);

  Future<dynamic>? futureCustomerNewBookingList;
  Future<dynamic>? futureCustomerConfirmedBookingList;
  Future<dynamic>? futureCustomerHistoryBookingList;
  Future<dynamic>? futureAllNewBookingList;
  Future<dynamic>? futureAllConfirmedBookingList;
  Future<dynamic>? futureAllHistoryBookingList;

  int customerBookingTab = 0;

  void setCustomerBookingTab(int value) {
    customerBookingTab = value;
    notifyListeners();
  }

  setFutureCustomerBookingList(String userId) {
    futureCustomerNewBookingList = getCustomerNewBookingList(userId);
    futureCustomerConfirmedBookingList =
        getCustomerConfirmedBookingList(userId);
    futureCustomerHistoryBookingList = getCustomerHistoryBookingList(userId);
    notifyListeners();
  }

  void setFutureAllBookingList() {
    futureAllNewBookingList = getAllNewBookingList();
    futureAllConfirmedBookingList = getAllConfirmedBookingList();
    futureAllHistoryBookingList = getAllHistoryBookingList();
    notifyListeners();
  }

  Future getCustomerNewBookingList(String userId) async {
    final List<Book>? newBookingList =
        await bookService.getUserNewBookingList(userId);

    if (newBookingList == null) {
      return [];
    } else {
      return newBookingList;
    }
  }

  Future getCustomerConfirmedBookingList(String userId) async {
    final List<Book>? confirmedBookingList =
        await bookService.getUserConfirmedBookingList(userId);

    if (confirmedBookingList == null) {
      return [];
    } else {
      return confirmedBookingList;
    }
  }

  Future getCustomerHistoryBookingList(String userId) async {
    final List<Book>? historyBookingList =
        await bookService.getUserHistoryBookingList(userId);

    if (historyBookingList == null) {
      return [];
    } else {
      return historyBookingList;
    }
  }

  Future getAllNewBookingList() async {
    final List<Book>? newBookingList = await bookService.getAllNewBookingList();

    if (newBookingList == null) {
      return [];
    } else {
      return newBookingList;
    }
  }

  Future getAllConfirmedBookingList() async {
    final List<Book>? confirmedBookingList =
        await bookService.getAllConfirmedBookingList();

    if (confirmedBookingList == null) {
      return [];
    } else {
      return confirmedBookingList;
    }
  }

  Future getAllHistoryBookingList() async {
    final List<Book>? historyBookingList =
        await bookService.getAllHistoryBookingList();

    if (historyBookingList == null) {
      return [];
    } else {
      return historyBookingList;
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
