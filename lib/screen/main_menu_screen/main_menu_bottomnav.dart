import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';

class MainmenuBottomNav extends StatelessWidget {
  const MainmenuBottomNav({
    Key? key,
    required this.mainmenuViewModel,
  }) : super(key: key);

  final MainmenuViewModel mainmenuViewModel;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: mainmenuViewModel.currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 50,
        iconSize: 35,
        selectedIconTheme: const IconThemeData(color: kPrimaryColorDarker),
        selectedItemColor: kPrimaryColorDarker,
        onTap: (index) => mainmenuViewModel.onTapBottomNav(index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: (mainmenuViewModel.currentIndex == 0)
                  ? const Icon(Icons.other_houses)
                  : const Icon(Icons.other_houses_outlined),
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
