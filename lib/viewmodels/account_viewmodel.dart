import 'package:flutter/Material.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/services/user_service.dart';

class AccountViewModel extends ChangeNotifier {
  List<String> customerItems = ['My Profile', 'My Address', 'My Car', 'Logout'];
  List<String> staffItems = [
    'My Profile',
    'Booking List',
    'Manage Services',
    'Logout'
  ];

  final userService = service<UserService>();

  onTapProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  onTapAddress(BuildContext context) {
    Navigator.pushNamed(context, '/address');
  }

  onTapLogout(BuildContext context) async {
    final logout = await userService.logout();
    if (logout) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/main'));
    }
  }
}
