import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';

class MainmenuBottomNav extends StatelessWidget {
  const MainmenuBottomNav({
    Key? key,
    required this.mainmenuViewModel,
  }) : super(key: key);

  final MainmenuViewModel mainmenuViewModel;

  @override
  Widget build(BuildContext context) {
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return BottomNavigationBar(
        selectedLabelStyle:
            Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
        unselectedLabelStyle: Theme.of(context).textTheme.caption,
        backgroundColor: kColorWhite,
        currentIndex: mainmenuViewModel.currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 50,
        iconSize: 35,
        selectedIconTheme: const IconThemeData(color: kPrimaryColorDarker),
        selectedItemColor: kPrimaryColorDarker,
        onTap: (index) {
          mainmenuViewModel.onTapBottomNav(index);
          switch (index) {
            case 0:
              break;
            case 1:
              if (mainmenuViewModel.indexBefore != 1) {
                bookingListViewModel.setFutureCustomerBookingList(
                    loginViewModel.userDetails.id);
              }
              break;
            case 2:
              break;
            case 3:
              break;
            default:
              break;
          }
          mainmenuViewModel.indexBefore = index;
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: (mainmenuViewModel.currentIndex == 0)
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: (mainmenuViewModel.currentIndex == 1)
                  ? const Icon(Icons.edit_calendar_rounded)
                  : const Icon(Icons.edit_calendar_outlined),
              label: 'Booking'),
          BottomNavigationBarItem(
              icon: (mainmenuViewModel.currentIndex == 2)
                  ? const Icon(Icons.directions_car_filled)
                  : const Icon(Icons.directions_car_filled_outlined),
              label: 'Car'),
          BottomNavigationBarItem(
              icon: (mainmenuViewModel.currentIndex == 3)
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_outline_outlined),
              label: 'Account'),
        ]);
  }
}
