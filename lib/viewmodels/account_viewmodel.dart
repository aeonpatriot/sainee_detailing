import 'package:flutter/Material.dart';

class AccountViewModel extends ChangeNotifier {
  List<String> items = ['My Profile', 'My Address', 'My Car', 'Logout'];

  onTapProfile() {
    print('My Profile');
  }

  onTapAddress() {
    print('My Address');
  }

  onTapCar() {
    print('My Car');
  }

  onTapLogout() {
    print('Logout');
  }
}
