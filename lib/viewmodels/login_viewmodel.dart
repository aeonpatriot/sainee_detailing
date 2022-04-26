import 'package:flutter/material.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/user_service.dart';

class LoginViewModel with ChangeNotifier {
  String? _email;
  String? _password;
  bool _hidePassword = true;

  final userService = service<UserService>();

  get email => _email;
  set email(value) => _email = value;
  get password => _password;
  set password(value) => _password = value;
  get hidePassword => _hidePassword;
  setHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  onLoginPressed(BuildContext context) async {
    final User user = User(
      email: email,
      password: password,
    );

    print(user.email);
    print(user.password);

    final _user = await userService.login(user);

    print(_user);

    if (_user == null)
      print('login failed');
    else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/main', ModalRoute.withName('/login'));
    }
  }
}
