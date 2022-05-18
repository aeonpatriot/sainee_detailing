import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/screen/account_screen/account_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/booking_list_screen.dart';
import 'package:sainee_detailing/screen/car_list_screen/car_list_screen.dart';
import 'package:sainee_detailing/screen/main_menu_screen/main_menu_screen_body.dart';

class MainmenuViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;
  set currentIndex(value) => _currentIndex = value;

  List<Widget> screen = [
    const MainMenuScreenBody(),
    const BookingListScreen(),
    const CarListScreen(),
    const AccountScreen(),
  ];

  onTapBottomNav(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
