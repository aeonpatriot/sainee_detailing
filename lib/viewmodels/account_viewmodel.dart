import 'package:flutter/Material.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/services/user_service.dart';

class AccountViewModel extends ChangeNotifier {
  List<String> items = ['My Profile', 'My Address', 'My Car', 'Logout'];

  final userService = service<UserService>();

  onTapProfile() {
    print('My Profile');
  }

  onTapAddress() {
    print('My Address');
  }

  onTapCar() {
    print('My Car');
  }

  onTapLogout(BuildContext context) async {
    final logout = await userService.logout();
    if (logout) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/main'));
    }
  }
}
