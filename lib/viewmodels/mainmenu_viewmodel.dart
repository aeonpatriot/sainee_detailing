import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/screen/account_screen/account_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/booking_list_screen.dart';
import 'package:sainee_detailing/screen/car_screen/car_screen.dart';
import 'package:sainee_detailing/screen/main_menu_screen/main_menu_screen_body.dart';

class MainmenuViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int _indexBefore = 0;
  int _topImageCurrentIndex = 0;
  int _bottomImageCurrentIndex = 0;

  get currentIndex => _currentIndex;
  set currentIndex(value) => _currentIndex = value;
  get indexBefore => _indexBefore;
  set indexBefore(value) => _indexBefore = value;
  get topImageCurrentIndex => _topImageCurrentIndex;
  set topImageCurrentIndex(value) {
    _topImageCurrentIndex = value;
    notifyListeners();
  }

  get bottomImageCurrentIndex => _bottomImageCurrentIndex;
  set bottomImageCurrentIndex(value) {
    _bottomImageCurrentIndex = value;
    notifyListeners();
  }

  List<Widget> customerScreenList = [
    const MainMenuScreenBody(),
    const BookingListScreen(),
    const CarScreen(),
    const AccountScreen(),
  ];

  List<Widget> staffScreenList = [
    const MainMenuScreenBody(),
    const BookingListScreen(),
    const CarScreen(),
    const AccountScreen(),
  ];

  final List<String> imageList = [
    'assets/images/promo.jpg',
    'assets/images/promo.jpg',
    'assets/images/promo.jpg',
  ];

  final List<String> gearImageList = [
    'promoImage/gear1.jpg',
    'promoImage/gear2.jpg',
    'promoImage/gear3.jpg',
    'promoImage/gear4.jpg',
    'promoImage/gear5.jpg',
    'promoImage/gear6.jpg',
    'promoImage/gear7.jpg',
    'promoImage/gear8.jpg',
  ];

  onTapBottomNav(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
