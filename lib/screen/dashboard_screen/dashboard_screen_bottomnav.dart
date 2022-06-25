import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context);

    return BottomNavigationBar(
        selectedLabelStyle:
            Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
        unselectedLabelStyle: Theme.of(context).textTheme.caption,
        backgroundColor: kColorWhite,
        currentIndex: dashboardViewModel.currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 50,
        iconSize: 35,
        selectedIconTheme: const IconThemeData(color: kPrimaryColorDarker),
        selectedItemColor: kPrimaryColorDarker,
        onTap: (index) {
          dashboardViewModel.onTapBottomNav(index);
          switch (index) {
            case 0:
              dashboardViewModel.setFutureDashboardData();
              // dashboardViewModel.;
              print(dashboardViewModel.indexBefore);
              break;
            case 1:
              if (dashboardViewModel.indexBefore != 1) {
                bookingListViewModel.setFutureAllBookingList();
              }
              break;
            case 2:
              print(dashboardViewModel.indexBefore);
              break;
            case 3:
              print(dashboardViewModel.indexBefore);
              break;
            default:
              break;
          }
          dashboardViewModel.indexBefore = index;
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: (dashboardViewModel.currentIndex == 0)
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: (dashboardViewModel.currentIndex == 1)
                  ? const Icon(Icons.edit_calendar_rounded)
                  : const Icon(Icons.edit_calendar_outlined),
              label: 'Booking'),
          BottomNavigationBarItem(
              icon: (dashboardViewModel.currentIndex == 2)
                  ? const Icon(Icons.car_rental)
                  : const Icon(Icons.car_rental_outlined),
              label: 'Service'),
          BottomNavigationBarItem(
              icon: (dashboardViewModel.currentIndex == 3)
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_outline_outlined),
              label: 'Account'),
        ]);
  }
}
