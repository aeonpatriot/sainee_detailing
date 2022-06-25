import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/other/dashboard.dart';
import 'package:sainee_detailing/screen/account_screen/account_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/booking_list_screen.dart';
import 'package:sainee_detailing/screen/car_screen/car_screen.dart';
import 'package:sainee_detailing/screen/dashboard_screen/chart/bar_booking_status.dart';
import 'package:sainee_detailing/screen/dashboard_screen/chart/doughnut_payment_type.dart';
import 'package:sainee_detailing/screen/dashboard_screen/dahsboard_screen_body.dart';
import 'package:sainee_detailing/services/book_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardViewModel extends ChangeNotifier {
  final bookService = service<BookService>();

  final chartController = PageController(initialPage: 0);
  late TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

  int _currentIndex = 0;
  int _indexBefore = 0;
  // double totalRevenue = 0;
  // int totalPending = 0;
  // int totalConfirmed = 0;

  Future<Object?>? futureDashboardData;
  late Dashboard dashboardData;
  late List<DoughnutData> doughPaymentStatusData;
  late List<BarData> barBookingStatusData;
  late List<BarData> barServiceBookedData;

  get currentIndex => _currentIndex;
  set currentIndex(value) => _currentIndex = value;
  get indexBefore => _indexBefore;
  set indexBefore(value) => _indexBefore = value;

  List<Widget> staffScreenList = [
    const DashboardScreenBody(),
    const BookingListScreen(),
    const CarScreen(),
    const AccountScreen(),
  ];

  onTapBottomNav(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  setFutureDashboardData() {
    futureDashboardData = getDashboardData();
    notifyListeners();
  }

  Future getDashboardData() async {
    final Dashboard? data = await bookService.getDashboardData();
    if (data == null) {
      print('no data');
    } else {
      dashboardData = data;
      initializeChartData(data);
      return data;
    }
  }

  void initializeChartData(Dashboard data) {
    doughPaymentStatusData = setDoughPaymentTypeData(data);
    barBookingStatusData = setBarBookingStatusData(data);
    barServiceBookedData = setBarServiceBookedData(data);
  }

  List<DoughnutData> setDoughPaymentTypeData(Dashboard data) {
    final List<DoughnutData> newData = [
      DoughnutData('Pay Online', int.parse(data.totalASOL!)),
      DoughnutData('Pay Cash', int.parse(data.totalASCS!))
    ];
    return newData;
  }

  List<BarData> setBarBookingStatusData(Dashboard data) {
    final List<BarData> newData = [
      BarData(
          label: 'PENDING',
          value: int.parse(data.totalPending!),
          color: Colors.yellow[600]!),
      BarData(
          label: 'CONFIRMED',
          value: int.parse(data.totalConfirmed!),
          color: Colors.green),
      BarData(
          label: 'COMPLETED',
          value: int.parse(data.totalCompleted!),
          color: kSecondaryColor),
      BarData(
          label: 'CANCELLED',
          value: int.parse(data.totalCancelled!),
          color: Colors.red),
    ];
    return newData;
  }

  List<BarData> setBarServiceBookedData(Dashboard data) {
    final List<BarData> newData = [
      BarData(
          label: 'Premium Wash',
          value: int.parse(data.totalPremiumWash!),
          color: const Color.fromARGB(255, 148, 109, 255)),
      BarData(
          label: 'Details Wash',
          value: int.parse(data.totalDetailsWash!),
          color: const Color.fromARGB(255, 255, 115, 248)),
      BarData(
          label: 'Basic Polish',
          value: int.parse(data.totalBasicPolish!),
          color: const Color.fromARGB(255, 90, 236, 255)),
      BarData(
          label: 'Ultimate Polish',
          value: int.parse(data.totalUltimatePolish!),
          color: const Color.fromARGB(255, 255, 88, 79)),
    ];
    return newData;
  }

  // Future getAllBooking() async {
  //   final List<Book>? bookingList = await bookService.getAllBooking();
  //   print(bookingList);
  //   if (bookingList == null) {
  //     return [];
  //   } else {
  //     if (bookingList.isEmpty) {
  //       return [];
  //     } else {
  //       calculateAllDashboard(bookingList);
  //     }
  //   }
  // }

  // calculateAllDashboard(List<Book> bookingList) {
  //   calculateTotalRevenue(bookingList);
  //   calculateTotalPending(bookingList);
  //   calculateTotalConfirmed(bookingList);
  //   notifyListeners();
  // }

  // calculateTotalRevenue(List<Book> bookingList) {
  //   double revenue = 0;
  //   for (Book book in bookingList) {
  //     revenue += double.parse(book.totalPrice!);
  //   }
  //   totalRevenue = revenue;
  // }

  // calculateTotalPending(List<Book> bookingList) {
  //   int value = 0;
  //   for (Book book in bookingList) {
  //     if (book.status == 'PENDING') {
  //       value++;
  //     }
  //   }
  //   totalPending = value;
  // }

  // calculateTotalConfirmed(List<Book> bookingList) {
  //   int value = 0;
  //   for (Book book in bookingList) {
  //     if (book.status == 'CONFIRMED') {
  //       value++;
  //     }
  //   }
  //   totalConfirmed = value;
  // }
}
